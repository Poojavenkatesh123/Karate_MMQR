Feature: Activate User API
 

   Background:

    # ✅ SAFE fallback (no ReferenceError)
    * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'

    # ✅ Now it's safe to print
    * print 'Base URL:', baseUrl

    * url baseUrl

 
    Scenario: Verify API returns 200 status
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959972972972/activate'
    When method PUT
    Then status 200
 
  Scenario: Verify active account details for valid mobile number
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959972972972/activate'
    When method PUT
    Then status 200
    And match response.status == 'ACTIVE'
    And match response.activeFlag == true
    And match response.message == 'Account is Active'
    And match response.mobileNumber == '00959972972972'
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
    And match response.accountId == null
    And match response.addressInfo.villageTract != null
    And match response.identityDetails[0].idNumber != null
    And match response.identityDetails[0].kycFiles[0].type != null
    And match response.identityDetails[0].kycFiles[0].assetUrl != null
    And match response.identityDetails[0].kycFiles[1].type != null
    And match response.identityDetails[0].kycFiles[1].assetUrl != null
 
  Scenario: Verify error response when invalid mobile number is passed
    Given path '/onboarded-users/v1/payplus/mobileNumber/009599292977/activate'
    When method PUT
    Then status 400
    And match response.httpStatusCode == 400
    And match response.httpStatus == 'BAD_REQUEST'
    And match response.errorCode == 'ERROR'
    And match response.errorCodeValue == 'ERROR'
    And match response.errorMessage == 'BAD_REQUEST'
    And match response.errorDescription == 'UNKNOWN'
    And match response.xrequestId == null
    And match response.errorMessageValue != null
    And match response.timestamp != null
 
  Scenario: Verify error response when no mobile number is passed in path
    Given path '/onboarded-users/v1/payplus/mobileNumber//activate'
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
 
    # Scenario: Verify error response when no mobile number is passed in path
    # Given path '/onboarded-users/v1/payplus/mobileNumber/009599292977/activate'
    # When method PUT
    # Then status 500
    # And match response.httpStatusCode == 500
    # And match response.httpStatus == 'INTERNAL_SERVER_ERROR'
    # And match response.errorCode == 'INTERNAL_SERVER_ERROR'
    # And match response.errorCodeValue == 'INTERNAL_SERVER_ERROR'
    # And match response.errorMessage == 'Internal Server Error'
    # And match response.errorMessageValue == "Request method 'PUT' is not supported"
    # And match response.errorDescription == 'UNKNOWN'
    # And match response.xrequestId == null
    # And match response.timestamp != null