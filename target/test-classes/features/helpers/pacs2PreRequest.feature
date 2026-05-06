@helper @ignore
Feature: PACS 2 pre-request - generate current_timestamp and BizMsgIdr

  Scenario: Generate values
    * def buildPacs2 = function(){ var t = new Date(new Date().getTime() + 60*60*1000); var pad = function(n,len){ var s=''+n; while(s.length<len) s='0'+s; return s; }; var YYYY=t.getFullYear(); var MM=pad(t.getMonth()+1,2); var DD=pad(t.getDate(),2); var HH=pad(t.getHours(),2); var mm=pad(t.getMinutes(),2); var ss=pad(t.getSeconds(),2); var currentTimestamp = YYYY+'-'+MM+'-'+DD+'T'+HH+':'+mm+':'+ss+'+06:30'; var compact = ''+YYYY+MM+DD+HH+mm+ss; var bizMsgIdr = 'BizMsgIdr'+compact; return { currentTimestamp: currentTimestamp, bizMsgIdr: bizMsgIdr }; }
    * def out = buildPacs2()
    * def currentTimestamp = out.currentTimestamp
    * def bizMsgIdr = out.bizMsgIdr
    * print 'currentTimestamp =', currentTimestamp
    * print 'bizMsgIdr =', bizMsgIdr
