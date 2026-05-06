@pacs2 @ignore
Feature: PACS 2 - Payment Status Report

  Background:
    * configure headers = { 'Content-Type': 'application/xml', 'Accept': 'application/xml' }
  # Caller passes only:  { txnId: <endToEndId from PACS 8> }
  Scenario: Send PACS 2 and validate status

    # PACS 2 pre-request: generates current_timestamp + BizMsgIdr (with ns suffix)
    * def pre = call read('classpath:features/helpers/pacs2PreRequest.feature')
    * def currentTimestamp = pre.currentTimestamp
    * def bizMsgIdr        = pre.bizMsgIdr

    # The original transaction id (from PACS 8) drives the OrgnlEndToEndId,
    # OrgnlMsgId, OrgnlTxId and ClrSysRef placeholders in the XML
    * def endToEndId = txnId

    * def requestPayload = read('classpath:request/pacs2Request.xml')
    * replace requestPayload
      | token                 | value             |
      | {{EndToEndId}}        | endToEndId        |
      | {{BizMsgIdr}}         | bizMsgIdr         |
      | {{current_timestamp}} | currentTimestamp  |
      | {{Amount}}            | Amount            |
      | {{BusinessName}}      | BusinessName      |
      | {{mPANno}}            | mPANno            |

    Given url 'http://mpay-uat.okdollar.org/qr-pay/ri/v1/iso20022/callback'
    And request requestPayload
    When method POST

    # ─── Structured payment log (always written, even on failure) ───
    * def logType  = (type == null ? 'unknown' : type)
    * def logReq   = karate.toString(requestPayload)
    * def logBody  = (response == null ? '' : karate.toString(response))
    * def logTxSts = (function(){ var m = logBody.match(/TxSts["'\s>:]+([A-Za-z0-9]+)/); return m ? m[1] : 'N/A'; })()
    * def logEntry = '\n--------------------------------------------------------------------------------\n[' + nowStamp() + '] Payment type: ' + logType + ' | PACS 2\n--------------------------------------------------------------------------------\nbizMsgIdr       : ' + bizMsgIdr + '\nendToEndId      : ' + endToEndId + '\ncurrentTimestamp: ' + currentTimestamp + '\nHTTP Status     : ' + responseStatus + '\nTxSts           : ' + logTxSts + '\n\n--- Request body ---\n' + logReq + '\n\n--- Response body ---\n' + logBody + '\n'
    * eval appendPaymentLog(logEntry)

    # ─── Validations: HTTP status + payment status ───
    Then status 200
    And match logTxSts == 'ACSC'

    * print '[PACS 2] HTTP', responseStatus, '| TxSts =', logTxSts

    # ─── Persist response body to a file ───
    * def responseFile = 'karate-logs/responses/pacs2_' + logType + '_' + bizMsgIdr + '.xml'
    * eval karate.write(response, responseFile)
    * print '[PACS 2] response written to target/' + responseFile

    * def httpStatus = responseStatus
    * def txStatusResp = logTxSts