Instance: patient-export
InstanceOf: OperationDefinition
Usage: #definition
* url = "http://hl7.org/fhir/uv/bulkdata/OperationDefinition/patient-export"
* version = "2.0.0"
* name = "PatientLevelExport"
* title = "FHIR Bulk Data Patient Level Export"
* status = #active
* kind = #operation
* date = "2021-07-29"
* jurisdiction = $m49.htm#001 "World"
* description = "FHIR Operation to obtain a detailed set of FHIR resources of diverse resource types pertaining to all patients. The FHIR server SHALL support invocation of this operation using the [FHIR Asynchronous Request Pattern](http://hl7.org/fhir/R4/async.html)"
* code = #export
* resource = #Patient
* system = false
* type = true
* instance = false
* parameter[0]
  * name = #_outputFormat
  * use = #in
  * min = 0
  * max = "1"
  * documentation = "Support is required for a server, optional for a client.\n\nThe format for the requested Bulk Data files to be generated as per [FHIR Asynchronous Request Pattern](http://hl7.org/fhir/R4/async.html). Defaults to `application/fhir+ndjson`. The server SHALL support [Newline Delimited JSON](http://ndjson.org), but MAY choose to support additional output formats. The server SHALL accept the full content type of `application/fhir+ndjson` as well as the abbreviated representations `application/ndjson` and `ndjson`."
  * type = #string
* parameter[+]
  * name = #_since
  * use = #in
  * min = 0
  * max = "1"
  * documentation = "Support is required for a server, optional for a client.\n\nResources will be included in the response if their state has changed after the supplied time (e.g., if `Resource.meta.lastUpdated` is later than the supplied `_since` time). The server MAY return resources that are referenced by the resources being returned regardless of when the referenced resources were last updated. For resources where the server does not maintain a last updated time, the server MAY include these resources in a response irrespective of the `_since` value supplied by a client."
  * type = #instant
* parameter[+]
  * name = #_type
  * use = #in
  * min = 0
  * max = "*"
  * documentation = "Support is optional for a server and a client.\n\nA string of comma-delimited FHIR resource types.\n\nThe response SHALL be filtered to only include resources of the specified resource types(s).\n\nIf this parameter is omitted, the server SHALL return all supported resources within the scope of the client authorization, though implementations MAY limit the resources returned to specific subsets of FHIR, such as those defined in the [US Core Implementation Guide](http://www.hl7.org/fhir/us/core/). For groups of patients, the [Patient Compartment](https://www.hl7.org/fhir/compartmentdefinition-patient.html) SHOULD be used as a point of reference for recommended resources to be returned. However, other resources outside of the Patient Compartment that are referenced by the resources being returned and would be helpful in interpreting the patient data MAY also be returned (such as Organization and Practitioner). When this behavior is supported, a server SHOULD document this support (for example, as narrative text, or by including a [GraphDefinition Resource](https://www.hl7.org/fhir/graphdefinition.html)).\n\nA server that is unable to support `_type` SHOULD return an error and FHIR `OperationOutcome` resource so the client can re-submit a request omitting the `_type` parameter. If the client explicitly asks for export of resources that the Bulk Data server doesn't support, or asks for only resource types that are outside the Patient Compartment, the server SHOULD return details via a FHIR `OperationOutcome` resource in an error response to the request. When a `Prefer: handling=lenient` header is included in the request, the server MAY process the request instead of returning an error.\n\nFor example `_type=Observation` could be used to filter a given export response to return only FHIR `Observation` resources."
  * type = #string
* parameter[+]
  * name = #_elements
  * use = #in
  * min = 0
  * max = "*"
  * documentation = "Experimental - support is optional for a server and a client.\n\nString of comma-delimited FHIR Elements.\n\nWhen provided, the server SHOULD omit unlisted, non-mandatory elements from the resources returned. Elements SHOULD be of the form `[resource type].[element name]` (e.g., `Patient.id`) or `[element name]` (e.g., `id`) and only root elements in a resource are permitted. If the resource type is omitted, the element SHOULD be returned for all resources in the response where it is applicable. \n\nA server is not obliged to return just the requested elements. A server SHOULD always return mandatory elements whether they are requested or not. A server SHOULD mark the resources with the tag `SUBSETTED` to ensure that the incomplete resource is not actually used to overwrite a complete resource.\n\nA server that is unable to support `_elements` SHOULD return an error and a FHIR `OperationOutcome` resource so the client can re-submit a request omitting the `_elements` parameter. When a `Prefer: handling=lenient` header is included in the request, the server MAY process the request instead of returning an error."
  * type = #string
* parameter[+]
  * name = #patient
  * use = #in
  * min = 0
  * max = "*"
  * documentation = "Experimental - support is optional for a server and a client.\n\nThis parameter is only valid in kickoff requests initiated through a HTTP POST request. When provided, the server SHALL NOT return resources in the patient compartments belonging to patients outside of this list. If a client requests patients who are not present on the server or are not members of the requested group, the server SHOULD return details via a FHIR `OperationOutcome` resource in an error response to the request.\n\nA server that is unable to support the `patient` parameter SHOULD return an error and FHIR `OperationOutcome` resource so the client can re-submit a request omitting the `patient` parameter. When a `Prefer: handling=lenient` header is included in the request, the server MAY process the request instead of returning an error."
  * type = #Reference
  * targetProfile = "http://hl7.org/fhir/StructureDefinition/Patient"
* parameter[+]
  * name = #includeAssociatedData
  * use = #in
  * min = 0
  * max = "*"
  * documentation = "Experimental - support is optional for a server and a client.\n\nString of comma-delimited values.\n\nWhen provided, a server with support for the parameter and requested values SHALL return or omit a pre-defined set of FHIR resources associated with the request.\n\nA server that is unable to support the requested `includeAssociatedData` values SHOULD return an error and a FHIR `OperationOutcome` resource so the client can re-submit a request that omits those values (for example, if a server does not retain provenance data). When a `Prefer: handling=lenient` header is included in the request, the server MAY process the request instead of returning an error.\n\nIf multiple conflicting values are included, the server SHALL apply the least restrictive value (value that will return the largest dataset)."
  * type = #code
  * binding
    * strength = #extensible
    * valueSet = Canonical(IncludeAssociatedDataValueSet)
* parameter[+]
  * name = #_typeFilter
  * use = #in
  * min = 0
  * max = "*"
  * documentation = """
    Support is optional for a server and a client.
    
    String with a FHIR REST search query.
    
    When provided, a server with support for the parameter and requested search queries SHALL filter the data in the response for resource types referenced in the typeFilter expression to only include resources that meet the specified criteria. FHIR search response parameters such as `_include` and `_sort` SHALL NOT be used. 
    
    A server unable to support the requested `_typeFilter` queries SHOULD return an error and FHIR `OperationOutcome` resource so the client can re-submit a request that omits those queries. When a `Prefer: handling=lenient` header is included in the request, the server MAY process the request instead of returning an error.
  """
  * type = #string