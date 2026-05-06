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
    And match response.name == '#notnull'
    And match response.fatherName == '#notnull'
    And match response.gender == '#notnull'
    And match response.dateOfBirth == '#notnull'
    And match response.financialAccountNumber == '#notnull'
    And match response.createdDateTime == '#notnull'
    And match response.createdAt == '#notnull'
    And match response.updatedAt == '#notnull'
    And match response.addressInfo.country == '#notnull'
    And match response.addressInfo.division == '#notnull'
    And match response.addressInfo.townShip == '#notnull'
    And match response.addressInfo.street == '#notnull'
    And match response.identityDetails[0].idType == '#notnull'
    And match response.identityDetails[0].kycFiles[0].fileId == '#notnull'
    And match response.identityDetails[0].kycFiles[1].fileId == '#notnull'
    And match response.accountId == null
    And match response.addressInfo.villageTract == '#notnull'
    And match response.identityDetails[0].idNumber == '#notnull'
    And match response.identityDetails[0].kycFiles[0].type == '#notnull'
    And match response.identityDetails[0].kycFiles[0].assetUrl == '#notnull'
    And match response.identityDetails[0].kycFiles[1].type == '#notnull'
    And match response.identityDetails[0].kycFiles[1].assetUrl == '#notnull'
 
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
    And match response.errorMessageValue == '#notnull'
    And match response.timestamp == '#notnull'
 
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
    And match response.timestamp == '#notnull'
 
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
    # And match response.timestamp == '#notnull'