Feature: Get Merchant Details API

Background:

    # ✅ SAFE fallback (no ReferenceError)
    * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'

    # ✅ Now it's safe to print
    * print 'Base URL:', baseUrl

    * url baseUrl


Scenario: Verify API returns 200 status
    Given path '/merchant-onboard/v1/onboarding/merchant-details-by/phone-number/00959758365232'
    When method GET
    Then status 200


  Scenario: Verify merchant details for valid mobile number
    Given path '/merchant-onboard/v1/onboarding/merchant-details-by/phone-number/00959758365232'
    When method GET
    Then status 200
    And match response.status == 'ACTIVE'
    And match response.message == 'Merchant is Active'
    And match response.merchantData.countryCode == 'MM'
    And match response.merchantData.isSameAsBillingOutletNumber == true
    And match response.merchantData.transactionCurrency == '104'
    And match response.merchantData.al_LanguagePreference == '#notnull'
    And match response.payloadData.activeStatus == true
    And match response.payloadData.message == 'Account is Active'
    And match response.payloadData.ids[0].kycFiles[0].type == '#notnull'
    And match response.payloadData.ids[0].kycFiles[1].type == '#notnull'
    And match response.merchantData.application_id == '#notnull'
    And match response.merchantData.merchant_RIPAN == '#notnull'
    And match response.merchantData.merchant_status == '#notnull'
    And match response.merchantData.merchant_Number == '#notnull'
    And match response.merchantData.customer_Number == '#notnull'
    And match response.merchantData.contract_Number == '#notnull'
    And match response.merchantData.terminal_number == '#notnull'
    And match response.merchantData.billingOutletMobileNumber == '#notnull'
    And match response.merchantData.merchantName_AL == '#notnull'
    And match response.merchantData.merchantName == '#notnull'
    And match response.merchantData.postalCode == '#notnull'
    And match response.merchantData.merchantCity == '#notnull'
    And match response.merchantData.guiid == '#notnull'
    And match response.merchantData.mcc == '#notnull'
    And match response.merchantData.merchantCity_AL == '#notnull'
    And match response.payloadData.merchantName == '#notnull'
    And match response.payloadData.merchantShortName == '#notnull'
    And match response.payloadData.merchantNameInOtherLan == '#notnull'
    And match response.payloadData.merchantShortNameInOtherLan == '#notnull'
    And match response.payloadData.businessName == '#notnull'
    And match response.payloadData.firstName == '#notnull'
    And match response.payloadData.surname == '#notnull'
    And match response.payloadData.mobileNumber == '#notnull'
    And match response.payloadData.emailId == '#notnull'
    And match response.payloadData.streetName == '#notnull'
    And match response.payloadData.city == '#notnull'
    And match response.payloadData.pinCode == '#notnull'
    And match response.payloadData.ids[0].idType == '#notnull'
    And match response.payloadData.ids[0].idNumber == '#notnull'
    And match response.payloadData.ids[0].kycFiles[0].fileId == '#notnull'
    And match response.payloadData.ids[0].kycFiles[0].assetUrl == '#notnull'
    And match response.payloadData.ids[0].kycFiles[1].fileId == '#notnull'
    And match response.payloadData.ids[0].kycFiles[1].assetUrl == '#notnull'
    And match response.payloadData.merchantNumber == '#notnull'
    And match response.payloadData.customerNumber == '#notnull'
    And match response.payloadData.contractNumber == '#notnull'
    And match response.payloadData.terminalNumber == '#notnull'
    And match response.payloadData.createdAt == '#notnull'
    And match response.payloadData.updatedAt == '#notnull'

  Scenario: Verify error response when merchant mobile number does not exist in system
    Given path '/merchant-onboard/v1/onboarding/merchant-details-by/phone-number/0095975836233'
    When method GET
    Then status 404
    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'NOT_FOUND'
    And match response.errorCodeValue == 'MERCHANT_NOT_FOUND'
    And match response.errorMessage == 'NOT_FOUND'
    And match response.errorMessageValue == 'MERCHANT_NOT_FOUND'
    And match response.errorDescription == 'UNKNOWN'
    And match response.timestamp == '#notnull'

  Scenario: Verify error response when no mobile number is passed in path
    Given path '/merchant-onboard/v1/onboarding/merchant-details-by/phone-number/'
    When method GET
    Then status 404
    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'NOT_FOUND'
    And match response.errorCodeValue == 'NoResourceFoundException'
    And match response.errorMessage == 'NOT_FOUND'
    And match response.errorMessageValue == 'org.springframework.web.servlet.resource.NoResourceFoundException'
    And match response.errorDescription == 'No static resource v1/onboarding/merchant-details-by/phone-number.'
    And match response.timestamp == '#notnull'