Feature: Activate Merchant API

Background:

    # ✅ SAFE fallback (no ReferenceError)
    * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'

    # ✅ Now it's safe to print
    * print 'Base URL:', baseUrl

    * url baseUrl


Scenario: Verify API returns 200 status
    Given path 'merchant-onboard/v1/onboarding/reactivating-merchant/00959758365232'
    When method PATCH
    Then status 200

Scenario: Verify merchant reactivated successfully for valid mobile number
    Given path 'merchant-onboard/v1/onboarding/reactivating-merchant/00959758365232'
    When method PATCH
    Then status 200
    And match response.status == 'ACTIVE'
    And match response.message == 'Merchant reactivated successfully'
    And match response.applicationId != null

  Scenario: Verify error response when merchant does not exist in system
    Given path 'merchant-onboard/v1/onboarding/reactivating-merchant/0099758365232'
    When method PATCH
    Then status 500
    And match response.httpStatusCode == 500
    And match response.httpStatus == 'INTERNAL_SERVER_ERROR'
    And match response.errorCode == 'MERCHANT_DOES_NOT_EXIST'
    And match response.errorCodeValue == 'MERCHANT_DOES_NOT_EXIST'
    And match response.errorMessage == 'MERCHANT_DOES_NOT_EXIST'
    And match response.errorMessageValue == 'MERCHANT DOEST NOT EXIST'
    And match response.errorDescription == 'UNKNOWN'
    And match response.timestamp != null

  Scenario: Verify error response when no mobile number is passed in path
    Given path 'merchant-onboard/v1/onboarding/reactivating-merchant/'
    When method PATCH
    Then status 404
    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'NOT_FOUND'
    And match response.errorCodeValue == 'NoResourceFoundException'
    And match response.errorMessage == 'NOT_FOUND'
    And match response.errorMessageValue == 'org.springframework.web.servlet.resource.NoResourceFoundException'
    And match response.errorDescription == 'No static resource v1/onboarding/reactivating-merchant.'
    And match response.timestamp != null
