ValueSet: GroupTypeSubset
Id: group-type-subset
Title: "Person and Practitioner from GroupType Value Set"
Description: "Valuset to constrain the type element in a Group to just person and practitioner"
* ^experimental = false
* ^jurisdiction = $m49.htm#001 "World"
* ^immutable = true
* http://hl7.org/fhir/group-type#person
* http://hl7.org/fhir/group-type#practitioner


Extension: MemberFilter
Id: member-filter
Title: "Member Filter"
Description: "Extension to define the population of the group using FHIR REST API parameters"
Context: Group
* . ^isModifier = true
* . ^isModifierReason = "Filters members of group to a subset"
* value[x] only Expression
  * language = #application/x-fhir-query


Extension: MembersRefreshed
Id: members-refreshed
Title: "Members Refreshed"
Description: "Extension used by a server to indicate to a client when the members in a dynamic group were last updated"
Context: Group
* value[x] only dateTime


Profile: BulkCohortGroup
Parent: Group 
Id: bulk-cohort-group
Title: "Bulk Cohort Group"
Description: "Group that provides characteristic based cohorts through coarse-grained, REST search expression based filters to support constraining bulk export requests"
* type from GroupTypeSubset (required)
  * ^definition = """
    A client SHALL populate this element with `person` when creating a group of Patients, or `practitioner` when creating a group of Practitioners.
    """
* member
  * ^definition = """
    A server MAY support the inclusion of one or more `member` elements that contain an `entity` element with a reference to a Patient resource, Practitioner resource, or Group resource that is a group of Patient resources or Practitioner resources. When members are provided, the expression in the `memberFilter` extension for the Group SHALL only be applied to the compartments of the referenced resources, or those of the members of referenced Group resources. When members are not provided and the Group's `type` element is set to `person`, the expression in the `memberFilter` extension SHALL be applied to all of the Patient compartments the client is authorized to access. When members are not provided and the Group's `type` element is set to `practitioner`, the expression in the `memberFilter` extension SHALL be applied to all of the Practitioner compartments the client is authorized to access.
    """
* modifierExtension contains MemberFilter named memberFilter 1..*
  * ^short = "Filter for members of this group" 
  * ^definition = """
    A server SHALL support the inclusion of one or more `memberFilter` modifier extensions containing a `valueExpression` with a language of `application/x-fhir-query` and an `expression` populated with a FHIR REST API query for a resource type included in the Patient or Practitioner compartment. If multiple `memberFilter` extensions are provided that contain criteria for different resource types, servers SHALL filter the group to only include Patients or Practitioners that have resources in their compartments that meet the conditions in all of the expressions. If multiple `memberFilter` extensions are provided that contain criteria for a single resource type, the server SHALL include Patients or Practitioners who have resources in their compartments that meet the criteria for that resource type in any of those expressions (a logical "or"). 
 
    FHIR [search result parameters](https://www.hl7.org/fhir/search.html#modifyingresults) (such as _sort, _include, and _elements) SHALL NOT be used as `memberFilter` criteria. Clients should consult the server's capability statement to identify supported search parameters. Servers SHALL reject Group creation requests that include unsupported search parameters in a `memberFilter` expression. Implementation guides that reference the Bulk Cohort API, should specify required search parameters must be supported for their use case. Other implementations guides that incorporate the Bulk Export operation MAY provide a set of core search parameters that servers implementing the guide need to support.
    """
* extension contains MembersRefreshed named membersRefreshed 0..1
  * ^short = "when membership in this group was updated"
  * ^definition = """
    If a groups membership is calculated periodically from the `memberFilter` criteria, a server SHALL populate a `valueDateTime` with the date the group's membership was last updated. When a `date` element is populated for the Group, the `valueDateTime` element SHALL NOT be later than the date in that element, but may be the same datetime or an earlier datetime. If members are calculated dynamically for the group (for example, when a Bulk Export operation is kicked off) this value SHALL be omitted. The server's refresh cycle capabilities and relevent configuration options SHOULD be described in the server's documentation.
    """
* name 1..1
* characteristic 0..0
  * ^short = "This element is not used for in groups complying with this profile"
* actual
  * ^short = "'actual' if member element is popluated, 'descriptive' otherwise"
  
Instance: BulkCohortGroupExample
InstanceOf: BulkCohortGroup
Title: "Bulk Cohort Group Example"
Usage: #example
* name = "BC with DM Dx and January Ambulatory Encounter"
* member.entity = Reference(Group/blue-cross-members)
* extension[membersRefreshed].valueDateTime = "2024-08-22T10:00:00Z"
* modifierExtension[memberFilter][0].valueExpression.expression = "Condition?category=http://terminology.hl7.org/CodeSystem/condition-category|problem-list-item&clinical-status=http://terminology.hl7.org/CodeSystem/condition-clinical|active&code=http://hl7.org/fhir/sid/icd-10-cm|E11.9"
* modifierExtension[memberFilter][1].valueExpression.expression = "Encounter?class=http://terminology.hl7.org/CodeSystem/v3-ActCode|AMB&date=ge2024-01-01&date=le2024-01-31"
* type = #person
* actual = true