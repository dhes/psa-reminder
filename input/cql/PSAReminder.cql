library PSAReminder version '0.1.0'

using QICore version '6.0.0'

include FHIRHelpers version '4.4.000' called FHIRHelpers
include QICoreCommon version '4.0.000' called QICoreCommon

codesystem "LOINC": 'http://loinc.org'

code "PSA": '2857-1' from "LOINC" display 'Prostate specific Ag [Mass/volume] in Serum or Plasma'

context Patient

define "Most Recent PSA":
  Last([LaboratoryResultObservation: "PSA"] O
    where O.status = 'final'
    sort by end of effective.toInterval()
  )

define "PSA Overdue":
  "Most Recent PSA" is null
    or 
    end of "Most Recent PSA".effective.toInterval() before (Today() - 1 year)