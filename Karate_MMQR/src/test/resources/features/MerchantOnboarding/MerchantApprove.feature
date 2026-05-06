Feature: Approve Merchant API

Background:

    # ✅ SAFE fallback (no ReferenceError)
    * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'

    # ✅ Now it's safe to print
    * print 'Base URL:', baseUrl

    * url baseUrl


  # Scenario: Verify merchant approved successfully with valid mobile number
  #   Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard/approve'
  #   And request { "mobileNumber": "098837497032" }
  #   When method POST
  #   Then status 200
  #   And match response.status == 'ACTIVE'
  #   And match response.message == 'Merchant is Active'
  #   And match response.merchantData.countryCode == 'MM'
  #   And match response.merchantData.isSameAsBillingOutletNumber == false
  #   And match response.merchantData.transactionCurrency == '104'
  #   And match response.merchantData.al_LanguagePreference == 'MY'
  #   And match response.payloadData.activeStatus == true
  #   And match response.payloadData.ids[0].kycFiles[0].type != null
  #   And match response.payloadData.ids[1].kycFiles[0].type != null
  #   And match response.merchantData.application_id != null
  #   And match response.merchantData.merchant_RIPAN != null
  #   And match response.merchantData.merchant_status != null
  #   And match response.merchantData.terminal_number != null
  #   And match response.merchantData.merchantName_AL != null
  #   And match response.merchantData.merchantName != null
  #   And match response.merchantData.postalCode != null
  #   And match response.merchantData.merchantCity != null
  #   And match response.merchantData.guiid != null
  #   And match response.merchantData.mcc != null
  #   And match response.merchantData.merchantCity_AL != null
  #   And match response.payloadData.merchantName != null
  #   And match response.payloadData.businessName != null
  #   And match response.payloadData.firstName != null
  #   And match response.payloadData.surname != null
  #   And match response.payloadData.mcc != null
  #   And match response.payloadData.secondaryMobileNumber != null
  #   And match response.payloadData.city != null
  #   And match response.payloadData.ids[0].idType != null
  #   And match response.payloadData.ids[0].idNumber != null
  #   And match response.payloadData.ids[0].kycFiles[0].fileId != null
  #   And match response.payloadData.ids[1].idType != null
  #   And match response.payloadData.ids[1].idNumber != null
  #   And match response.payloadData.ids[1].kycFiles[0].fileId != null
  #   And match response.payloadData.merchantNumber != null
  #   And match response.payloadData.customerNumber != null
  #   And match response.payloadData.contractNumber != null
  #   And match response.payloadData.terminalNumber != null
  #   And match response.payloadData.createdAt != null
  #   And match response.payloadData.updatedAt != null

  Scenario: Verify error response when merchant is not found in system
    Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard/approve'
    And request { "mobileNumber": "009598837497471" }
    When method POST
    Then status 404
    And match response.httpStatusCode == 404
    And match response.httpStatus == 'NOT_FOUND'
    And match response.errorCode == 'NOT_FOUND'
    And match response.errorCodeValue == 'MERCHANT_NOT_FOUND'
    And match response.errorMessage == 'NOT_FOUND'
    And match response.errorMessageValue == 'MERCHANT_NOT_FOUND'
    And match response.errorDescription == 'UNKNOWN'
    And match response.timestamp != null

  Scenario: Verify error response when merchant is already registered with same ID number
    Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard/approve'
    And request { "mobileNumber": "098837497471" }
    When method POST
    Then status 400
    And match response.httpStatusCode == 400
    And match response.httpStatus == 'BAD_REQUEST'
    And match response.errorCode == 'DUPLICATE_ID_NUMBER'
    And match response.errorCodeValue == 'DUPLICATE_ID_NUMBER'
    And match response.errorMessage == 'DUPLICATE_ID_NUMBER'
    And match response.errorMessageValue == 'THE MERCHANT IS ALREADY REGISTERED WITH THIS ID NUMBER'
    And match response.errorDescription == 'UNKNOWN'
    And match response.timestamp != null

  Scenario: Verify error response when mobile number is empty in request body
    Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard/approve'
    And request { "mobileNumber": "" }
    When method POST
    Then status 400
    And match response.httpStatusCode == 400
    And match response.httpStatus == 'BAD_REQUEST'
    And match response.errorCode == 'EMPTY_FIELDS'
    And match response.errorCodeValue == 'EMPTY_FIELDS'
    And match response.errorMessage == 'EMPTY_FIELDS'
    And match response.errorMessageValue == 'SOME OF THE FIELDS ARE EMPTY'
    And match response.errorDescription == 'UNKNOWN'
    And match response.timestamp != null
