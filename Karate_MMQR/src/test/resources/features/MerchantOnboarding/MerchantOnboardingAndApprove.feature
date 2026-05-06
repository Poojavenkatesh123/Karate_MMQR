# Feature: Merchant Onboarding and Approve API

#   Background:
#     * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'
#     * print 'Base URL:', baseUrl
#     * url baseUrl
#     * header Content-Type = 'application/json'

#   # ═══════════════════════════════════════════════════════════════════
#   # TC-001: ONBOARD + APPROVE — chained flow
#   # ═══════════════════════════════════════════════════════════════════
#   Scenario Outline: Verify merchant onboarding then approve with same mobile number
#     # ── STEP 1: Load onboarding request and set mobile numbers ──
#     * def onboardRequest = read('classpath:testdata/requests/validMerchant.json')
#     * set onboardRequest.mobileNumber = '<mobileNumber>'
#     * set onboardRequest.secondaryMobileNumber = '<secondaryMobileNumber>'

#     # ── STEP 2: Hit Onboarding API ──
#     Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard'
#     And request onboardRequest
#     When method POST
#     Then status 200
#     And match response.status == 'PENDING'
#     And match response.activeStatus == false
#     And match response.message == 'Merchant Created Successfully.Please wait for our KYC Team to verify the details'
#     And match response.merchantName != null
#     And match response.businessName != null
#     And match response.mcc != null
#     And match response.firstName != null
#     And match response.surname != null
#     And match response.secondaryMobileNumber != null
#     And match response.createdAt != null
#     And match response.updatedAt != null

#     # ── STEP 3: Capture mobile number from onboarding response ──
#     * def onboardedMobileNumber = '<mobileNumber>'
#     * print 'Onboarded Mobile Number:', onboardedMobileNumber

#     # ── STEP 4: Load approve request and set same mobile number ──
#     * def approveRequest = read('classpath:testdata/requests/approveMerchant.json')
#     * set approveRequest.mobileNumber = onboardedMobileNumber

#     # ── STEP 5: Hit Approve API ──
#     Given path '/v1/onboarding/approveMerchant'
#     And request approveRequest
#     When method POST
#     Then status 200
#     And match response.status == 'ACTIVE'
#     And match response.message == 'Merchant is Active'
#     And match response.merchantData.countryCode == 'MM'
#     And match response.merchantData.isSameAsBillingOutletNumber != null
#     And match response.merchantData.transactionCurrency == '104'
#     And match response.merchantData.al_LanguagePreference == 'MY'
#     And match response.payloadData.activeStatus == true
#     And match response.merchantData.application_id != null
#     And match response.merchantData.merchant_RIPAN != null
#     And match response.merchantData.merchant_status != null
#     And match response.merchantData.terminal_number != null
#     And match response.merchantData.merchantName != null
#     And match response.payloadData.merchantName != null
#     And match response.payloadData.businessName != null
#     And match response.payloadData.firstName != null
#     And match response.payloadData.surname != null
#     And match response.payloadData.merchantNumber != null
#     And match response.payloadData.customerNumber != null
#     And match response.payloadData.contractNumber != null
#     And match response.payloadData.terminalNumber != null
#     And match response.payloadData.createdAt != null
#     And match response.payloadData.updatedAt != null

#     Examples:
#       | read('classpath:testdata/testdata.csv') |

Feature: Merchant Onboarding and Approve API
 
  Background:
    * def baseUrl = karate.get('baseUrl') ? karate.get('baseUrl') : 'http://mpay-uat.okdollar.org'
    * print 'Base URL:', baseUrl
    * url baseUrl
    * header Content-Type = 'application/json'
 
  # ═══════════════════════════════════════════════════════════════════
  # TC-001: ONBOARD + APPROVE — ONE number per run
  # ═══════════════════════════════════════════════════════════════════
  Scenario: Verify merchant onboarding then approve with same mobile number
 
    # ── STEP 1: Load all rows from CSV ──
    * def testData = karate.read('classpath:testdata/testdata.csv')
 
    # ── STEP 2: Pick ONE row per run using rowIndex ──
    # Run 1 → -DrowIndex=0 → picks number 1
    # Run 2 → -DrowIndex=1 → picks number 2
    * def rowIndex = karate.properties['rowIndex'] != null ? parseInt(karate.properties['rowIndex']) : 0
    * def row = testData[rowIndex]
 
    * print 'Running for Row Index :', rowIndex
    * print 'Mobile Number         :', row.mobileNumber
    * print 'Secondary Mobile      :', row.secondaryMobileNumber
    * print 'ID Number             :', row.idNumber
 
    # ── STEP 3: Load full onboard request from JSON and override dynamic fields only ──
    * def onboardRequest = read('classpath:testdata/requests/validMerchant.json')
    * set onboardRequest.mobileNumber                = row.mobileNumber
    * set onboardRequest.secondaryMobileNumber       = row.secondaryMobileNumber
    * set onboardRequest.ids[0].idNumber             = row.idNumber
    * set onboardRequest.ids[1].idNumber             = row.idNumber2
 
    # ── STEP 4: Hit Onboarding API ──
    Given path '/merchant-onboard/v1/single-Onboarding/singleMerchantOnboard'
    And request onboardRequest
    When method POST
    Then status 200
    And match response.status                == 'PENDING'
    And match response.activeStatus          == false
    And match response.message               == 'Merchant Created Successfully.Please wait for our KYC Team to verify the details'
    And match response.merchantName          != null
    And match response.businessName          != null
    And match response.mcc                   != null
    And match response.firstName             != null
    And match response.surname               != null
    And match response.secondaryMobileNumber != null
    And match response.createdAt             != null
    And match response.updatedAt             != null
 
    * print '✅ ONBOARD PASSED | Mobile:', row.mobileNumber
 
    # ── STEP 5: Load full approve request from JSON and override mobile number only ──
    * def approveRequest = read('classpath:testdata/requests/approveMerchant.json')
    * set approveRequest.mobileNumber = row.mobileNumber
 
    # ── STEP 6: Hit Approve API ──
    Given path '/v1/onboarding/approveMerchant'
    And request approveRequest
    When method POST
    Then status 200
    And match response.status                                   == 'ACTIVE'
    And match response.message                                  == 'Merchant is Active'
    And match response.merchantData.countryCode                 == 'MM'
    And match response.merchantData.isSameAsBillingOutletNumber != null
    And match response.merchantData.transactionCurrency         == '104'
    And match response.merchantData.al_LanguagePreference       == 'MY'
    And match response.payloadData.activeStatus                 == true
    And match response.merchantData.application_id              != null
    And match response.merchantData.merchant_RIPAN              != null
    And match response.merchantData.merchant_status             != null
    And match response.merchantData.terminal_number             != null
    And match response.merchantData.merchantName                != null
    And match response.payloadData.merchantName                 != null
    And match response.payloadData.businessName                 != null
    And match response.payloadData.firstName                    != null
    And match response.payloadData.surname                      != null
    And match response.payloadData.merchantNumber               != null
    And match response.payloadData.customerNumber               != null
    And match response.payloadData.contractNumber               != null
    And match response.payloadData.terminalNumber               != null
    And match response.payloadData.createdAt                    != null
    And match response.payloadData.updatedAt                    != null
 
    * print '✅ APPROVE PASSED | Mobile:', row.mobileNumber