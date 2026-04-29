Feature: User Status Check by Mobile Number
 
  Background:
    * url baseUrl
 
    Scenario: Verify API returns 200 status
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959972972972'
    When method GET
    Then status 200
 
  # ═══════════════════════════════════════════════════════════════════
  # POSITIVE TEST CASES
  # ═══════════════════════════════════════════════════════════════════
 
  # TC-001: ACTIVE Account
  Scenario: Mobile number belongs to an ACTIVE account
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959972972972'
    When method GET
    Then status 200
    # --- Static Fields (exact match) ---
    And match response.status == 'ACTIVE'
    And match response.activeFlag == true
    And match response.message == 'Account is Active'
    And match response.mobileNumber == '00959972972972'
    # --- Dynamic Fields (must have data) ---
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
    And match response.addressInfo.villageTract  != null
    And match response.identityDetails[0].idNumber  != null
    And match response.identityDetails[0].kycFiles[0].type  != null
    And match response.identityDetails[0].kycFiles[0].assetUrl  != null
    And match response.identityDetails[0].kycFiles[1].type  != null
    And match response.identityDetails[0].kycFiles[1].assetUrl  != null
 
  # TC-002: IN_ACTIVE Account
  Scenario: Mobile number belongs to an IN_ACTIVE account
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959752781355'
    When method GET
    Then status 200
    # --- Static Fields (exact match) ---
    And match response.status == 'IN_ACTIVE'
    And match response.activeFlag == false
    And match response.message == 'Account is DeActivated'
    And match response.mobileNumber == '00959752781355'
    # --- Dynamic Fields (must have data) ---
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
    And match response.accountId  != null
    And match response.addressInfo.villageTract  != null
    And match response.identityDetails[0].idNumber  != null
    And match response.identityDetails[0].kycFiles[0].type  != null
    And match response.identityDetails[0].kycFiles[0].assetUrl  != null
    And match response.identityDetails[0].kycFiles[1].type  != null
    And match response.identityDetails[0].kycFiles[1].assetUrl  != null
 
  # ═══════════════════════════════════════════════════════════════════
  # NEGATIVE TEST CASES
  # ═══════════════════════════════════════════════════════════════════
 
  # TC-003: NOT FOUND — Wrong mobile number
  Scenario: Mobile number does not exist in system
    Given path '/onboarded-users/v1/payplus/mobileNumber/00959972972978'
    When method GET
    Then status 404
    # --- Static Fields (exact match) ---
    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'ERROR'
    And match response.errorCodeValue == 'ERROR'
    And match response.errorMessage == 'USER_NOT_FOUND'
    And match response.errorDescription == 'UNKNOWN'
    And match response.xrequestId == null
    # --- Dynamic Fields (must have data) ---
    And match response.errorMessageValue != null
    And match response.timestamp != null
 
  # TC-004: EMPTY VALUE — No mobile number in path
  Scenario: No mobile number passed in path
    Given path '/onboarded-users/v1/payplus/mobileNumber/'
    When method PUT
    Then status 404
    # --- Static Fields (exact match) ---
    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'NOT_FOUND'
    And match response.errorCodeValue == 'NoResourceFoundException'
    And match response.errorMessage == 'NOT_FOUND'
    And match response.errorMessageValue == 'org.springframework.web.servlet.resource.NoResourceFoundException'
    And match response.errorDescription == 'No static resource v1/payplus/mobileNumber.'
    And match response.xrequestId == null
    # --- Dynamic Fields (must have data) ---
    And match response.timestamp != null