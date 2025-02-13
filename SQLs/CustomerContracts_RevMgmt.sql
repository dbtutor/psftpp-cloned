--Experimental Version 3
--Under testing
--Added Sponsor Type
SELECT A.BUSINESS_UNIT "Bus Unit", F.DESCR "BU Descriptioin", A.CURRENCY_CD "Currency", A.SOLD_TO_CUST_ID "Sold To Customer", E.NAME1 "Customer Name", E.SPNSR_TYPE, GM.DESCR "Sponsor Descr",
       A.CONTRACT_TYPE "Contract Type", A.CONTRACT_NUM "Contract ID", A.DESCR "Contract Description", A.CA_STATUS "Contract Status", --X8.FIELDVALUE || ' - ' || X8.XLATLONGNAME AS "Contract Status", 
       A.CA_PROC_STATUS, X9.FIELDVALUE || ' - ' || X9.XLATLONGNAME AS "Processing Status", A.ALLOCATION_DONE "Allocation Complete Y/N",
       TO_CHAR(A.CONTRACT_SIGN_DT,'YYYY-MM-DD') "Contract Sign Date", TO_CHAR(A.AMENDMENT_DT,'YYYY-MM-DD') "Amendment Date", A.REVISED_NET "Revised Net Amount", A.LEGAL_REVIEW_FLG "Legal Review Y/N",
       I.CONTRACT_LINE_NUM "Contract Line Nbr", I.DESCR "Contract Line Descr", I.PRICING_STRUCTURE "Pricing Structure", I.SHIP_TO_CUST_ID, 
       TO_CHAR(I.START_DT,'YYYY-MM-DD') "Start Date DTL", TO_CHAR(I.END_DT,'YYYY-MM-DD') "End Date DTL", I.GROSS_AMT "Gross Amount", I.NET_AMOUNT "Net Amount", 
       
       (SELECT NVL(SUM(AMOUNT), 0) FROM PS_CA_AP_EVENT CG WHERE CG.CONTRACT_NUM = C.CONTRACT_NUM AND CG.ACCT_PLAN_ID = C.ACCT_PLAN_ID AND CG.EVENT_NUM = C.EVENT_NUM AND CG.MS_SEQNUM = G.MS_SEQNUM 
                                                    AND CG.AP_EVENT_STATUS = 'DON') "Rev Events To Date",
       
       TO_CHAR(CAST((I.LASTUPDDTTM) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF') "Last Update Date/Time DETAIL", I.LASTUPDOPRID "Last Update User DETAIL", I.PRODUCT_ID "Product DETAIL", I.PRODUCT_GROUP "Product Group",
       C.EVENT_NUM "REV Event Nbr", C.AP_EVENT_TYPE, X3.FIELDVALUE || ' - ' || X3.XLATLONGNAME AS "REV Event Type", C.AP_EVENT_STATUS, X4.FIELDVALUE || ' - ' || X4.XLATLONGNAME AS "REV Event Status",
       TO_CHAR(C.ACCOUNTING_DT,'YYYY-MM-DD') "REV Acctg Date", TO_CHAR(CAST((C.LASTUPDDTTM) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF') "REV Last Update Date/Time",
       B.ACCT_PLAN_ID "Revenue Plan", B.REV_RECOG_METHOD, X7.FIELDVALUE || ' - ' || X7.XLATLONGNAME AS "Revenue Method", 
       B.AP_STATUS, X1.FIELDVALUE || ' - ' || X1.XLATLONGNAME AS "Revenue Plan Status", 
       C.MILESTONE_ORIGIN, X5.FIELDVALUE || ' - ' || X5.XLATLONGNAME AS "M/S Origin", C.MS_SEQNUM "M/S Nbr", G.DESCR "M/S Descr", 
       G.MILESTONE_STATUS, X6.FIELDVALUE || ' - ' || X6.XLATLONGNAME AS "M/S Status", TO_CHAR(G.COMPLETION_DATE,'YYYY-MM-DD') "M/S Compl Date", TO_CHAR(G.ESTIMATED_COMP_DT,'YYYY-MM-DD') "M/S Estd Compl Date",
       C.AMOUNT "Revenue Amount", C.CURRENCY_CD "REV Transaction Currency", B.CA_ALLOC_METHOD, X2.FIELDVALUE || ' - ' || X2.XLATLONGNAME AS "REV Allocation Method",
       
       BP.BILL_PLAN_ID "Billing Plan", BP.BP_STATUS, X15.FIELDVALUE || ' - ' || X15.XLATLONGNAME AS "Bill Plan Status",
       BP.BILL_PLAN_TYPE, X16.FIELDVALUE || ' - ' || X16.XLATLONGNAME AS "Bill Plan Type", BPE.EVENT_OCCURRENCE "Bill Plan Evt Occur", TO_CHAR(BPE.EVENT_DT,'YYYY-MM-DD') "Billing Plan Event Date",
       BPE.BILL_EVENT_TYPE, X17.FIELDVALUE || ' - ' || X17.XLATLONGNAME AS "Bill Plan Event Type", BPE.BP_EVENT_STATUS, X14.FIELDVALUE || ' - ' || X14.XLATLONGNAME AS "Bill Plan Event Status",
       BPE.AMOUNT "Billing Amount", BPE.CURRENCY_CD "Bill Transaction Curr",
       
       (SELECT NVL(SUM(AMOUNT), 0) FROM PS_CA_BP_EVENTS BPEG WHERE BPEG.CONTRACT_NUM = BP.CONTRACT_NUM AND BPEG.BILL_PLAN_ID = BP.BILL_PLAN_ID AND BPE.EVENT_OCCURRENCE = BPE.EVENT_OCCURRENCE 
                                                       AND BPEG.MS_SEQNUM = G.MS_SEQNUM AND BPEG.BP_EVENT_STATUS = 'DON') "Events Billed To Date",
                                                       
       H.ACCOUNT "Cntrct Acct", H.OPERATING_UNIT "Cntrct Op Unit", H.FUND_CODE "Cntrct Fund", H.DEPTID "Cntrct Dtl DeptID", H.PROJECT_ID "Cntrct Prj ID", H.CHARTFIELD2 "Cntrct Donor", H.COMBO_VALID_FLG,
       CADP.BUSINESS_UNIT_PC "Cntrct Trms PC BU", CADP.PROJECT_ID "Cntrct Trms Prj ID", CADP.ACTIVITY_ID "Cntrct Trms Act ID",
       BIH.INVOICE, TO_CHAR(BIH.INVOICE_DT,'YYYY-MM-DD') "Invoice Date", TO_CHAR(BIH.ACCOUNTING_DT,'YYYY-MM-DD') "Inv Acctg Date", TO_CHAR(BIH.RATE_DATE,'YYYY-MM-DD') "Inv Rate Date", BIH.RATE_MULT, BIH.RATE_DIV,
       BIH.AR_LVl, BIH.AR_DST_OPT, BIH.AR_ENTRY_CREATED, BIH.BUSINESS_UNIT_GL, BIH.GL_LVL, BIH.GL_ENTRY_CREATED, 
       TO_CHAR(CAST((BIH.ADD_DTTM) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF') "Billing Header Add Date/Time", TO_CHAR(CAST((BIH.LAST_UPDATE_DTTM) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF') "Bill Hdr Last Update Date/Time", 
       BIH.LAST_MAINT_OPRID, BIH.BILL_STATUS, BIH.BANK_CD, BIH.BANK_ACCT_KEY, 
       BIL.BUSINESS_UNIT_CA, BIL.CONTRACT_NUM, TO_CHAR(BIL.CONTRACT_DT,'YYYY-MM-DD') "BIL Inv Date", BIL.CONTRACT_LINE_NUM, BIL.LINE_SEQ_NUM, BIL.INVOICE_LINE, BIL.LINE_TYPE, 
       BIL.PRODUCT_ID, BIL.IDENTIFIER, BIL.DESCR, BIL.ERROR_STATUS_BI,
       BIL.BILL_PLAN_ID, BIL.BPLAN_LN_NBR, BIL.EVENT_OCCURRENCE, BIL.XREF_SEQ_NUM, BIL.GROSS_EXTENDED_AMT, BIL.NET_EXTENDED_AMT, BIL.GROSS_EXTENDED_BSE, BIL.NET_EXTENDED_BSE
FROM ((((((((((((((((((((((PS_CA_CONTR_HDR A LEFT OUTER JOIN PS_CA_DETAIL I ON A.CONTRACT_NUM = I.CONTRACT_NUM)
      LEFT OUTER JOIN PS_CA_ACCTPLAN B ON A.CONTRACT_NUM = B.CONTRACT_NUM)
      LEFT OUTER JOIN PS_CA_AP_EVENT C ON B.CONTRACT_NUM = C.CONTRACT_NUM AND B.ACCT_PLAN_ID = C.ACCT_PLAN_ID)
      LEFT OUTER JOIN PS_CA_MILESTONE G ON A.CONTRACT_NUM = G.CONTRACT_NUM AND C.MS_SEQNUM = G.MS_SEQNUM)
      LEFT OUTER JOIN PS_CA_DETAIL_DST H ON A.CONTRACT_NUM = H.CONTRACT_NUM AND I.CONTRACT_LINE_NUM = H.CONTRACT_LINE_NUM)
      LEFT OUTER JOIN PS_CA_DETAIL_PROJ CADP ON A.CONTRACT_NUM = CADP.CONTRACT_NUM AND I.CONTRACT_LINE_NUM = CADP.CONTRACT_LINE_NUM)
      LEFT OUTER JOIN PS_CA_BILL_PLAN BP ON A.CONTRACT_NUM = BP.CONTRACT_NUM)
      LEFT OUTER JOIN PS_CA_BP_EVENTS BPE ON BP.CONTRACT_NUM = BPE.CONTRACT_NUM AND BP.BILL_PLAN_ID = BPE.BILL_PLAN_ID AND C.EVENT_NUM = BPE.EVENT_OCCURRENCE)
      LEFT OUTER JOIN PS_BI_LINE BIL ON BIL.CONTRACT_NUM = A.CONTRACT_NUM AND BIL.BUSINESS_UNIT = A.BUSINESS_UNIT_BI AND BIL.BUSINESS_UNIT_CA = A.BUSINESS_UNIT AND BIL.BILL_PLAN_ID = I.BILL_PLAN_ID 
      AND BIL.BPLAN_LN_NBR = I.BPLAN_LN_NBR AND C.EVENT_NUM = BIL.EVENT_OCCURRENCE)
      LEFT OUTER JOIN PS_BI_HDR BIH ON BIH.BUSINESS_UNIT = BIL.BUSINESS_UNIT AND BIH.INVOICE = BIL.INVOICE)
      LEFT OUTER JOIN PSXLATITEM X1 ON X1.FIELDNAME = 'AP_STATUS' AND X1.FIELDVALUE = B.AP_STATUS AND X1.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X2 ON X2.FIELDNAME = 'CA_ALLOC_METHOD' AND X2.FIELDVALUE = B.CA_ALLOC_METHOD AND X2.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X7 ON X7.FIELDNAME = 'REV_RECOG_METHOD' AND X7.FIELDVALUE = B.REV_RECOG_METHOD AND X7.EFF_STATUS = 'A')
      --LEFT OUTER JOIN PSXLATITEM X8 ON X8.FIELDNAME = 'CA_STATUS' AND X8.FIELDVALUE = A.CA_STATUS AND X8.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X9 ON X9.FIELDNAME = 'CA_PROC_STATUS' AND X9.FIELDVALUE = A.CA_PROC_STATUS AND X9.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X3 ON X3.FIELDNAME = 'AP_EVENT_TYPE' AND X3.FIELDVALUE = C.AP_EVENT_TYPE AND X3.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X4 ON X4.FIELDNAME = 'AP_EVENT_STATUS' AND X4.FIELDVALUE = C.AP_EVENT_STATUS AND X4.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X5 ON X5.FIELDNAME = 'MILESTONE_ORIGIN' AND X5.FIELDVALUE = C.MILESTONE_ORIGIN AND X5.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X6 ON X6.FIELDNAME = 'MILESTONE_STATUS' AND X6.FIELDVALUE = G.MILESTONE_STATUS AND X6.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X14 ON X14.FIELDNAME = 'BP_EVENT_STATUS' AND X14.FIELDVALUE = BPE.BP_EVENT_STATUS AND X14.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X15 ON X15.FIELDNAME = 'BP_STATUS' AND X15.FIELDVALUE = BP.BP_STATUS AND X15.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X16 ON X16.FIELDNAME = 'BILL_PLAN_TYPE' AND X16.FIELDVALUE = BP.BILL_PLAN_TYPE AND X16.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X17 ON X17.FIELDNAME = 'BILL_EVENT_TYPE' AND X17.FIELDVALUE = BPE.BILL_EVENT_TYPE AND X17.EFF_STATUS = 'A'), PS_SET_CNTRL_REC D, 
      (PS_CUSTOMER E LEFT OUTER JOIN PS_GM_SPNSR_TYPE GM ON E.SETID = GM.SETID AND E.SPNSR_TYPE = GM.SPNSR_TYPE), PS_BUS_UNIT_TBL_FS F
WHERE D.SETCNTRLVALUE = A.BUSINESS_UNIT
  AND D.RECNAME = 'CUSTOMER'
  AND E.SETID = D.SETID
  AND E.CUST_ID = A.SOLD_TO_CUST_ID
  AND F.BUSINESS_UNIT = A.BUSINESS_UNIT
  AND (H.EFFDT = (SELECT MAX(H_ED.EFFDT) FROM PS_CA_DETAIL_DST H_ED WHERE H.CONTRACT_NUM = H_ED.CONTRACT_NUM AND H.CONTRACT_LINE_NUM = H_ED.CONTRACT_LINE_NUM AND H.DST_SEQ_NUM = H_ED.DST_SEQ_NUM AND H_ED.EFFDT<= SYSDATE)
    OR H.EFFDT IS NULL)
  AND A.BUSINESS_UNIT = 'UNUNI'
  --AND A.BUSINESS_UNIT IN (SELECT BUSINESS_UNIT FROM PS_BUS_UNIT_TBL_CA WHERE BUSINESS_UNIT_GL = 'UNDP1')
  --AND A.SOLD_TO_CUST_ID IN ('10685', '10824')
  AND A.CONTRACT_TYPE NOT LIKE '%GRANTS%'
  --AND A.CONTRACT_TYPE NOT IN ('GRANTS', 'GLOC', 'PROJECT', 'PROJECTS', 'JPO')
  --AND A.CA_PROC_STATUS LIKE :4
  --AND A.CONTRACT_NUM = '00089610'
  --AND B.AP_STATUS LIKE :6
  --AND A.CA_RQST_SRC = :8
ORDER BY A.CONTRACT_NUM, I.CONTRACT_LINE_NUM, C.EVENT_NUM, C.MS_SEQNUM, B.ACCT_PLAN_ID, BPE.EVENT_OCCURRENCE;
