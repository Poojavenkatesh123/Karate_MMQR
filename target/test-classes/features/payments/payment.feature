@payment
Feature: Payment Testing - All Types

  Scenario Outline: Validate payment flow for <type>
    * def data = read('classpath:data/' + fileName)
    * def input = data[0]

    # PACS 008 Call
    * def pacs8Input = karate.merge(input, { type: type })
    * def pacs8Result = call read('classpath:features/payments/pacs8.feature') pacs8Input

    # Wait 2s before firing PACS 2 (gives backend time to settle the PACS 8 txn)
    * eval java.lang.Thread.sleep(2000)

    # PACS 002 Call (uses txnId from PACS 8 + carries JSON fields for substitution)
    * def pacs2Input = karate.merge(input, { txnId: pacs8Result.txnId, type: type })
    * def pacs2Result = call read('classpath:features/payments/pacs2.feature') pacs2Input

    * print '[' + type + '] PACS 8 =', pacs8Result.httpStatus, pacs8Result.txStatus, '| PACS 2 =', pacs2Result.httpStatus, pacs2Result.txStatusResp

     Examples:
      | type      | fileName                |
      | RI        | RI_payment.json         |
      | EZYNK     | ezynk_payment.json      |
      | STARTHING | starthing_payment.json  |
     | OSM       | osm_payment.json        |
     |RIOutlet    | RIOutlet_Payment.json|