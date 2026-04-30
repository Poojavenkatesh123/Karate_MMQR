Feature: InActivate User API
 
   Background:

    # ✅ SAFE fallback (no ReferenceError)
    * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'

    # ✅ Now it's safe to print
    * print 'Base URL:', baseUrl

    * url baseUrl

    Scenario: Verify API returns 200 status
    Given path 'onboarded-users/v1/payplus/mobileNumber/00959972972973/deactivate'
    When method PUT
    Then status 200
 
  Scenario: Verify inactive account details for valid mobile number
    Given path 'onboarded-users/v1/payplus/mobileNumber/00959972972973/deactivate'
    When method PUT
    Then status 200
    And match response.status == 'IN_ACTIVE'
    And match response.activeFlag == false
    And match response.message == 'Account is DeActivated'
    And match response.mobileNumber == '00959972972973'
    And match response.accountId != null
    And match response.addressInfo.villageTract != null
    And match response.identityDetails[0].idNumber != null
    And match response.identityDetails[0].kycFiles[0].type != null
    And match response.identityDetails[0].kycFiles[0].assetUrl != null
    And match response.identityDetails[0].kycFiles[1].type != null
    And match response.identityDetails[0].kycFiles[1].assetUrl  != null
    And match response.name != null
    And match response.fatherName != null
    And match response.gender != null
    And match response.dateOfBirth != null
    And match response.financialAccountNumber != null
    And match response.createdDateTime != null
    And match response.createdAt != null
    And match response.updatedAt != null
    And match response.addressInfo.country != null
    And match response.addressInfo.division != null
    And match response.addressInfo.townShip != null
    And match response.addressInfo.street != null
    And match response.identityDetails[0].idType != null
    And match response.identityDetails[0].kycFiles[0].fileId != null
    And match response.identityDetails[0].kycFiles[1].fileId != null
 
  Scenario: Verify error response when mobile number does not exist in system
    Given path 'onboarded-users/v1/payplus/mobileNumber/00959972972977/deactivate'
    When method PUT
    Then status 404
    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'ERROR'
    And match response.errorCodeValue == 'ERROR'
    And match response.errorMessage == 'USER_NOT_FOUND'
    And match response.errorDescription == 'UNKNOWN'
    And match response.xrequestId == null
    And match response.errorMessageValue != null
    And match response.timestamp != null
 
 
  Scenario: Verify error response when no mobile number is passed in path
    Given path 'onboarded-users/v1/payplus/mobileNumber//deactivate'
    When method PUT
    Then status 500
    And match response.httpStatusCode == 500
    And match response.httpStatus == 'INTERNAL_SERVER_ERROR'
    And match response.errorCode == 'INTERNAL_SERVER_ERROR'
    And match response.errorCodeValue == 'INTERNAL_SERVER_ERROR'
    And match response.errorMessage == 'Internal Server Error'
    And match response.errorMessageValue == "Request method 'PUT' is not supported"
    And match response.errorDescription == 'UNKNOWN'
    And match response.xrequestId == null
    And match response.timestamp != null