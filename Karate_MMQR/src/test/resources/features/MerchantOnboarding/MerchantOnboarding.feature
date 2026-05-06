Feature: Merchant Onboarding API

  Background:
    * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'
    * print 'Base URL:', baseUrl
    * url baseUrl
    * header Content-Type = 'application/json'

  # Scenario Outline: Verify single merchant onboarding successfully with valid details
  #   * def requestBody = read('classpath:testdata/requests/validMerchant.json')
  #   * set requestBody.mobileNumber = '<mobileNumber>'
  #   * set requestBody.secondaryMobileNumber = '<secondaryMobileNumber>'
  #   Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard'
  #   And request requestBody
  #   When method POST
  #   Then status 200
  #   And match response.status == 'PENDING'
  #   And match response.activeStatus == false
  #   And match response.message == 'Merchant Created Successfully.Please wait for our KYC Team to verify the details'
  #   And match response.merchantName != null
  #   And match response.businessName != null
  #   And match response.businessLanguage != null
  #   And match response.businessLanguageInAL != null
  #   And match response.mcc != null
  #   And match response.firstName != null
  #   And match response.surname != null
  #   And match response.surnameInAL != null
  #   And match response.secondaryMobileNumber != null
  #   And match response.emailId != null
  #   And match response.url != null
  #   And match response.streetName != null
  #   And match response.city != null
  #   And match response.pinCode != null
  #   And match response.terminalId != null
  #   And match response.flexibleFieldValue != null
  #   And match response.terminalNumber != null
  #   And match response.ids[0].idType != null
  #   And match response.ids[0].idNumber != null
  #   And match response.ids[0].kycFiles[0].fileId != null
  #   And match response.ids[1].idType != null
  #   And match response.ids[1].idNumber != null
  #   And match response.ids[1].kycFiles[0].fileId != null
  #   And match response.createdAt != null
  #   And match response.updatedAt != null

  #   Examples:m
  #     | read('classpath:testdata/testdata.csv') |

  Scenario: Verify error response when merchant already exists with same secondary mobile number
    * def requestBody = read('classpath:testdata/requests/duplicateMerchant.json')
    Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard'
    And request requestBody
    When method POST
    Then status 409
    And match response.httpStatusCode == 409
    And match response.httpStatus == 'CONFLICT'
    And match response.errorCode == 'ALREADY_EXISTS'
    And match response.errorCodeValue == 'MERCHANT_ALREADY_EXISTS_SECONDARY_MOBILE_NUMBER'
    And match response.errorMessage == 'ALREADY_EXISTS'
    And match response.errorMessageValue == 'MERCHANT_ALREADY_EXISTS_SECONDARY_MOBILE_NUMBER'
    And match response.errorDescription == 'UNKNOWN'
    And match response.timestamp != null

  Scenario: Verify error response when mobile number is empty in request body
    * def requestBody = read('classpath:testdata/requests/emptyMobile.json')
    Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard'
    And request requestBody
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