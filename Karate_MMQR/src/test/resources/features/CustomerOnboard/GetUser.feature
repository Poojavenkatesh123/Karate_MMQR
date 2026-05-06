Feature: User Status Check by Mobile Number

Background:

    # ✅ SAFE fallback (no ReferenceError)
    * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'

    # ✅ Now it's safe to print
    * print 'Base URL:', baseUrl

    * url baseUrl


Scenario: Verify API returns 200 status
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959972972972'
    When method GET
    Then status 200


# ═══════════════════════════════════════════════════════════════════
# POSITIVE TEST CASES
# ═══════════════════════════════════════════════════════════════════

# TC-001: ACTIVE
Scenario: Mobile number belongs to an ACTIVE account
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959972972972'
    When method GET
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
    And match response.addressInfo.villageTract == '#notnull'

    And match response.identityDetails[0].idType == '#notnull'
    And match response.identityDetails[0].idNumber == '#notnull'
    And match response.identityDetails[0].kycFiles[0].fileId == '#notnull'
    And match response.identityDetails[0].kycFiles[1].fileId == '#notnull'
    And match response.identityDetails[0].kycFiles[0].type == '#notnull'
    And match response.identityDetails[0].kycFiles[1].type == '#notnull'
    And match response.identityDetails[0].kycFiles[0].assetUrl == '#notnull'
    And match response.identityDetails[0].kycFiles[1].assetUrl == '#notnull'

    And match response.accountId == null


# TC-002: IN_ACTIVE Account
Scenario: Mobile number belongs to an IN_ACTIVE account
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959752781355'
    When method GET
    Then status 200

    And match response.status == 'IN_ACTIVE'
    And match response.activeFlag == false
    And match response.message == 'Account is DeActivated'
    And match response.mobileNumber == '00959752781355'

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
    And match response.addressInfo.villageTract == '#notnull'

    And match response.identityDetails[0].idType == '#notnull'
    And match response.identityDetails[0].idNumber == '#notnull'
    And match response.identityDetails[0].kycFiles[0].fileId == '#notnull'
    And match response.identityDetails[0].kycFiles[1].fileId == '#notnull'
    And match response.identityDetails[0].kycFiles[0].type == '#notnull'
    And match response.identityDetails[0].kycFiles[1].type == '#notnull'
    And match response.identityDetails[0].kycFiles[0].assetUrl == '#notnull'
    And match response.identityDetails[0].kycFiles[1].assetUrl == '#notnull'

    And match response.accountId == '#notnull'


# ═══════════════════════════════════════════════════════════════════
# NEGATIVE TEST CASES
# ═══════════════════════════════════════════════════════════════════

# TC-003: NOT FOUND
Scenario: Mobile number does not exist in system
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959972972978'
    When method GET
    Then status 404

    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'ERROR'
    And match response.errorCodeValue == 'ERROR'
    And match response.errorMessage == 'USER_NOT_FOUND'
    And match response.errorDescription == 'UNKNOWN'
    And match response.xrequestId == null

    And match response.errorMessageValue == '#notnull'
    And match response.timestamp == '#notnull'


# TC-004: EMPTY VALUE
Scenario: No mobile number passed in path
    Given path '/onboarded-users/v1/payplus/mobileNumber/'
    When method PUT
    Then status 404

    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'NOT_FOUND'
    And match response.errorCodeValue == 'NoResourceFoundException'
    And match response.errorMessage == 'NOT_FOUND'
    And match response.errorMessageValue == 'org.springframework.web.servlet.resource.NoResourceFoundException'
    And match response.errorDescription == 'No static resource v1/payplus/mobileNumber.'
    And match response.xrequestId == null

    And match response.timestamp == '#notnull'