--GL & AM Recon - 2014
SELECT 'GL_AM_RECON_2014', HDR.BUSINESS_UNIT, HDR.JOURNAL_ID, DIST.ASSET_ID, DIST.TRANS_TYPE, B.IN_SERVICE_DT, B.LAST_TRANS_DT, 
            LINE.ACCOUNT, LINE.OPERATING_UNIT, LINE.FUND_CODE, LINE.DEPTID, LINE.CHARTFIELD2, LINE.BUSINESS_UNIT_PC, LINE.PROJECT_ID, LINE.ACTIVITY_ID, 
            LINE.ANALYSIS_TYPE, HDR.DESCR254, LINE.LINE_DESCR, 
            LINE.JOURNAL_DATE, SUM(LINE.FOREIGN_AMOUNT) GL_LC, LINE.FOREIGN_CURRENCY, SUM(LINE.MONETARY_AMOUNT) GL_BC, 
            SUM(DIST.AMOUNT) AM_AMT, DIST.CURRENCY_CD, A.TAG_NUMBER
FROM PS_JRNL_HEADER HDR, PS_JRNL_LN LINE, PS_DIST_LN DIST, PS_BOOK B, PS_ASSET A
WHERE HDR.BUSINESS_UNIT = LINE.BUSINESS_UNIT
    AND HDR.JOURNAL_ID = LINE.JOURNAL_ID
    AND HDR.JOURNAL_DATE = LINE.JOURNAL_DATE
    AND HDR.UNPOST_SEQ = LINE.UNPOST_SEQ
    AND HDR.BUSINESS_UNIT = DIST.BUSINESS_UNIT_GL 
    AND HDR.JOURNAL_ID = DIST.JOURNAL_ID 
    AND HDR.JOURNAL_DATE = DIST.JOURNAL_DATE 
    AND LINE.JOURNAL_LINE = DIST.JOURNAL_LINE
    AND B.BUSINESS_UNIT = DIST.BUSINESS_UNIT
    AND B.ASSET_ID = DIST.ASSET_ID
    AND B.BUSINESS_UNIT = A.BUSINESS_UNIT
    AND B.ASSET_ID = A.ASSET_ID
    --AND HDR.JOURNAL_ID IN ('AM05104079', 'AM05104080')
    --AND HDR.LEDGER = DIST.LEDGER
    AND HDR.BUSINESS_UNIT = 'UNUNI'
    AND DIST.BUSINESS_UNIT = 'UNUNI'
    AND HDR.LEDGER_GROUP = 'ACTUALS'
    AND TO_CHAR(HDR.JOURNAL_DATE, 'YYYY') = '2014'
    AND HDR.SOURCE IN ('AM')
    AND HDR.JRNL_HDR_STATUS IN ('P','U')
GROUP BY HDR.BUSINESS_UNIT, HDR.JOURNAL_ID, DIST.ASSET_ID, DIST.TRANS_TYPE, B.IN_SERVICE_DT, B.LAST_TRANS_DT,
               LINE.ACCOUNT, LINE.OPERATING_UNIT, LINE.FUND_CODE, LINE.DEPTID, LINE.CHARTFIELD2, LINE.BUSINESS_UNIT_PC, LINE.PROJECT_ID, LINE.ACTIVITY_ID, 
               LINE.ANALYSIS_TYPE, HDR.DESCR254, LINE.LINE_DESCR, LINE.JOURNAL_DATE, LINE.FOREIGN_CURRENCY, DIST.CURRENCY_CD, A.TAG_NUMBER
ORDER BY ASSET_ID;
--GL & AM Recon - 2015
SELECT 'GL_AM_RECON_2015', HDR.BUSINESS_UNIT, HDR.JOURNAL_ID, DIST.ASSET_ID, DIST.TRANS_TYPE, B.IN_SERVICE_DT, B.LAST_TRANS_DT, 
            LINE.ACCOUNT, LINE.OPERATING_UNIT, LINE.FUND_CODE, LINE.DEPTID, LINE.CHARTFIELD2, LINE.BUSINESS_UNIT_PC, LINE.PROJECT_ID, LINE.ACTIVITY_ID, 
            LINE.ANALYSIS_TYPE, HDR.DESCR254, LINE.LINE_DESCR, 
            LINE.JOURNAL_DATE, SUM(LINE.FOREIGN_AMOUNT) GL_LC, LINE.FOREIGN_CURRENCY, SUM(LINE.MONETARY_AMOUNT) GL_BC, 
            SUM(DIST.AMOUNT) AM_AMT, DIST.CURRENCY_CD, A.TAG_NUMBER
FROM PS_JRNL_HEADER HDR, PS_JRNL_LN LINE, PS_DIST_LN DIST, PS_BOOK B, PS_ASSET A
WHERE HDR.BUSINESS_UNIT = LINE.BUSINESS_UNIT
    AND HDR.JOURNAL_ID = LINE.JOURNAL_ID
    AND HDR.JOURNAL_DATE = LINE.JOURNAL_DATE
    AND HDR.UNPOST_SEQ = LINE.UNPOST_SEQ
    AND HDR.BUSINESS_UNIT = DIST.BUSINESS_UNIT_GL 
    AND HDR.JOURNAL_ID = DIST.JOURNAL_ID 
    AND HDR.JOURNAL_DATE = DIST.JOURNAL_DATE 
    AND LINE.JOURNAL_LINE = DIST.JOURNAL_LINE
    AND B.BUSINESS_UNIT = DIST.BUSINESS_UNIT
    AND B.ASSET_ID = DIST.ASSET_ID
    AND B.BUSINESS_UNIT = A.BUSINESS_UNIT
    AND B.ASSET_ID = A.ASSET_ID
    --AND HDR.JOURNAL_ID IN ('AM05104079', 'AM05104080')
    --AND HDR.LEDGER = DIST.LEDGER
    AND HDR.BUSINESS_UNIT = 'UNUNI'
    AND DIST.BUSINESS_UNIT = 'UNUNI'
    AND HDR.LEDGER_GROUP = 'ACTUALS'
    AND TO_CHAR(HDR.JOURNAL_DATE, 'YYYY') = '2015'
    AND HDR.SOURCE IN ('AM')
    AND HDR.JRNL_HDR_STATUS IN ('P','U')
GROUP BY HDR.BUSINESS_UNIT, HDR.JOURNAL_ID, DIST.ASSET_ID, DIST.TRANS_TYPE, B.IN_SERVICE_DT, B.LAST_TRANS_DT,
               LINE.ACCOUNT, LINE.OPERATING_UNIT, LINE.FUND_CODE, LINE.DEPTID, LINE.CHARTFIELD2, LINE.BUSINESS_UNIT_PC, LINE.PROJECT_ID, LINE.ACTIVITY_ID, 
               LINE.ANALYSIS_TYPE, HDR.DESCR254, LINE.LINE_DESCR, LINE.JOURNAL_DATE, LINE.FOREIGN_CURRENCY, DIST.CURRENCY_CD, A.TAG_NUMBER
ORDER BY ASSET_ID;
--UNU_ALL_ASSETS
--With Asset Custodian
--Added A.TXN_AMOUNT, A.TXN_CURRENCY_CD on 20th Jan 2014
--Added details for PO/Receipt/Voucher on 24 Feb 2014
--Added ASSET_CLASS on 14 May 2014
--Modified the query on 24Mar2015 to include EFFSEQ check on ASSET_CUSTODIAN as more than one row was showing up for few assets
--Also changed column headings to improve readability
SELECT A.BUSINESS_UNIT "Business Unit", A.ASSET_ID "Asset ID", D.PROFILE_ID "Profile ID", D.ASSET_CLASS "Asset Class", D.DESCR "Descr", D.ASSET_STATUS "Asset Status", D.TAG_NUMBER "Tag Number", 
       D.SERIAL_ID "Serial Numbmer", D.MODEL "Model", D.ACQUISITION_DT "Acquisition Date",
       A.CURRENCY_CD "Amt Currency", C.FROM_CUR "Cost Currency", NVL(C.COST, A.AMOUNT) "Asset Value", A.TXN_AMOUNT "Transaction Amt", A.TXN_CURRENCY_CD "Transaction Currency",
       DECODE(B.FUND_CODE,'', A.FUND_CODE, B.FUND_CODE) FUND_CODE,  
       DECODE( B.OPERATING_UNIT, '',  A.OPERATING_UNIT,  B.OPERATING_UNIT) OPERATING_UNIT,  
       DECODE( B.DEPTID, '',  A.DEPTID,  B.DEPTID) DEPTID,  DECODE( B.CHARTFIELD2, '',  A.CHARTFIELD2,  B.CHARTFIELD2) CHARTFIELD2,  
       DECODE( B.PROJECT_ID, '',  A.PROJECT_ID,  B.PROJECT_ID) PROJECT_ID, D.FINANCIAL_ASSET_SW "Capitalized Asset", F.LOCATION, G.DESCR AS LOCATION_DESCR, 
       ASD.CUSTODIAN, ASD.DEPTID AS CUSTODIAN_DEPTID, ASD.PROJECT_ID AS CUSTODIAN_PROJECT_ID,
       A.BUSINESS_UNIT_PO, A.PO_ID, A.BUSINESS_UNIT_RECV, A.RECEIVER_ID, A.INV_ITEM_ID, 
       A.BUSINESS_UNIT_AP, A.VOUCHER_ID, A.VENDOR_ID
FROM (((PS_ASSET_ACQ_DET A LEFT OUTER JOIN PS_UN_OAPR_COST_CF B ON A.BUSINESS_UNIT =  B.BUSINESS_UNIT AND A.ASSET_ID =  B.ASSET_ID)
      LEFT OUTER JOIN PS_UN_OAPR_COST_VW C ON A.BUSINESS_UNIT =  C.BUSINESS_UNIT AND A.ASSET_ID =  C.ASSET_ID)
      LEFT OUTER JOIN PS_ASSET_CUSTODIAN ASD ON A.BUSINESS_UNIT =  ASD.BUSINESS_UNIT AND A.ASSET_ID =  ASD.ASSET_ID)
     , PS_ASSET D, PS_ASSET_LOCATION F, PS_LOCATION_TBL G
WHERE A.BUSINESS_UNIT = 'UNUNI'
  AND A.SEQUENCE_NBR_6 = (SELECT MAX( E.SEQUENCE_NBR_6) FROM PS_ASSET_ACQ_DET E WHERE E.BUSINESS_UNIT = A.BUSINESS_UNIT AND E.ASSET_ID = A.ASSET_ID)
  AND A.BUSINESS_UNIT =  D.BUSINESS_UNIT
  AND A.ASSET_ID =  D.ASSET_ID
  AND D.BUSINESS_UNIT = F.BUSINESS_UNIT
  AND D.ASSET_ID = F.ASSET_ID
  AND F.EFFDT = (SELECT MAX(F_ED.EFFDT) FROM PS_ASSET_LOCATION F_ED WHERE F.BUSINESS_UNIT = F_ED.BUSINESS_UNIT AND F.ASSET_ID = F_ED.ASSET_ID AND F_ED.EFFDT <= SYSDATE)
  AND F.EFFSEQ = (SELECT MAX(F_ES.EFFSEQ) FROM PS_ASSET_LOCATION F_ES WHERE F.BUSINESS_UNIT = F_ES.BUSINESS_UNIT AND F.ASSET_ID = F_ES.ASSET_ID AND F.EFFDT = F_ES.EFFDT)
  AND (ASD.EFFDT = (SELECT MAX(EFFDT) FROM PS_ASSET_CUSTODIAN A_ASD WHERE ASD.BUSINESS_UNIT = A_ASD.BUSINESS_UNIT AND ASD.ASSET_ID = A_ASD.ASSET_ID AND A_ASD.EFFDT <= SYSDATE)
    OR ASD.EFFDT IS NULL)
  AND (ASD.EFFSEQ = (SELECT MAX(ASD_ED.EFFSEQ) FROM PS_ASSET_CUSTODIAN ASD_ED WHERE ASD.BUSINESS_UNIT = ASD_ED.BUSINESS_UNIT AND ASD.ASSET_ID = ASD_ED.ASSET_ID AND ASD.EFFDT = ASD_ED.EFFDT)
    OR ASD.EFFSEQ IS NULL)  
  AND G.LOCATION = F.LOCATION
  AND G.EFFDT = (SELECT MAX(G_ED.EFFDT) FROM PS_LOCATION_TBL G_ED WHERE G.SETID = G_ED.SETID AND G.LOCATION = G_ED.LOCATION AND G_ED.EFFDT <= SYSDATE)
  AND G.SETID = 'UNUNI'
  --AND A.ASSET_ID IN ('000000012902', '000000012903')
ORDER BY 1, 2;
--UNU AM Retirement Report
--Trimmed Version based on 9.2 SQR AMRT2100
--Version 2
--Added XLAT
--Added CoA
SELECT DISTINCT R.BUSINESS_UNIT, R.BOOK, B.FINANCIAL_ASSET_SW "Capitalized Asset", R.ASSET_ID, B.DESCR, B.PROFILE_ID,
       TO_CHAR(CAST((R.DTTM_STAMP) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF') AS DTTM_STAMP, 
       TO_CHAR(R.RETIREMENT_DT, 'YYYY-MM-DD') AS RETIREMENT_DT, TO_DATE('1901-01-01','YYYY-MM-DD') AS TRANS_DT, R.ACCOUNTING_DT, R.CONVENTION, TO_CHAR(R.END_DEPR_DT, 'YYYY-MM-DD') AS END_DEPR_DT, 
       R.DISPOSAL_CODE, X1.XLATLONGNAME AS DISPOSAL_CD_DESCR, R.RETIREMENT_TYPE, X2.XLATLONGNAME AS RETIREMENT_TYPE_DESCR, R.RETIREMENT_STATUS, X3.XLATLONGNAME AS RETIREMENT_STS_DESCR,
       R.REFERENCE, R.QUANTITY, R.RETIREMENT_AMT, R.RETIREMENT_RSV, R.GAIN_LOSS, ACQ.CURRENCY_CD AS ACQ_CURR_CD, ACQ.AMOUNT AS ACQ_AMT, ACQ.TXN_CURRENCY_CD AS ACQ_TXN_CURR_CD, ACQ.TXN_AMOUNT AS ACQ_TXN_AMT,
       R.TXN_CURRENCY_CD, R.FROM_CUR, R.RETIREMENT_PCT, R.FULLY_DEPR_SW, R.IN_SERVICE_PDS,
       DECODE(C.OPERATING_UNIT, '',  ACQ.OPERATING_UNIT,  C.OPERATING_UNIT) OPERATING_UNIT,
       DECODE(C.FUND_CODE,'', ACQ.FUND_CODE, C.FUND_CODE) FUND_CODE,
       DECODE(C.DEPTID, '',  ACQ.DEPTID,  C.DEPTID) DEPTID,
       DECODE(C.CHARTFIELD2, '',  ACQ.CHARTFIELD2,  C.CHARTFIELD2) CHARTFIELD2,
       DECODE(C.PROJECT_ID, '',  ACQ.PROJECT_ID,  C.PROJECT_ID) PROJECT_ID,
       ASD.CUSTODIAN, ASD.OPERATING_UNIT AS CUST_OP_UNIT, ASD.FUND_CODE AS CUST_FUND_CODE, ASD.DEPTID AS CUST_DEPTID, ASD.CHARTFIELD2 AS CUST_DONOR, ASD.PROJECT_ID AS CUST_PROJECT_ID
FROM (((((((PS_RETIREMENT R LEFT OUTER JOIN PS_COST C ON R.BUSINESS_UNIT = C.BUSINESS_UNIT AND R.ASSET_ID = C.ASSET_ID AND R.BOOK = C.BOOK AND R.DTTM_STAMP = C.DTTM_STAMP)
      LEFT OUTER JOIN PS_ASSET_ACQ_DET ACQ ON R.BUSINESS_UNIT = ACQ.BUSINESS_UNIT AND R.ASSET_ID = ACQ.ASSET_ID)
      LEFT OUTER JOIN PS_UN_OAPR_COST_CF C ON R.BUSINESS_UNIT =  C.BUSINESS_UNIT AND R.ASSET_ID =  C.ASSET_ID)
      LEFT OUTER JOIN PS_ASSET_CUSTODIAN ASD ON R.BUSINESS_UNIT =  ASD.BUSINESS_UNIT AND R.ASSET_ID =  ASD.ASSET_ID)
      LEFT OUTER JOIN PSXLATITEM X1 ON X1.FIELDNAME = 'DISPOSAL_CODE' AND X1.FIELDVALUE = R.DISPOSAL_CODE AND X1.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X2 ON X2.FIELDNAME = 'RETIREMENT_TYPE' AND X2.FIELDVALUE = R.RETIREMENT_TYPE AND X2.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X3 ON X3.FIELDNAME = 'RETIREMENT_STATUS' AND X3.FIELDVALUE = R.RETIREMENT_STATUS AND X3.EFF_STATUS = 'A'), PS_ASSET B
WHERE R.BUSINESS_UNIT = B.BUSINESS_UNIT
  AND R.ASSET_ID = B.ASSET_ID 
  AND (ASD.EFFDT = (SELECT MAX(EFFDT) FROM PS_ASSET_CUSTODIAN A_ASD WHERE ASD.BUSINESS_UNIT = A_ASD.BUSINESS_UNIT AND ASD.ASSET_ID = A_ASD.ASSET_ID AND A_ASD.EFFDT <= SYSDATE)
    OR ASD.EFFDT IS NULL)
  AND (ASD.EFFSEQ = (SELECT MAX(ASD_ED.EFFSEQ) FROM PS_ASSET_CUSTODIAN ASD_ED WHERE ASD.BUSINESS_UNIT = ASD_ED.BUSINESS_UNIT AND ASD.ASSET_ID = ASD_ED.ASSET_ID AND ASD.EFFDT = ASD_ED.EFFDT)
    OR ASD.EFFSEQ IS NULL)
  AND R.BUSINESS_UNIT = 'UNUNI' 
  --AND C.AM_PHY_TXN_SW <> 'Y'
UNION
SELECT DISTINCT R.BUSINESS_UNIT, R.BOOK, B.FINANCIAL_ASSET_SW, R.ASSET_ID, B.DESCR, B.PROFILE_ID,
       TO_CHAR(CAST((R.DTTM_STAMP) AS TIMESTAMP),'YYYY-MM-DD-HH24.MI.SS.FF') AS DTTM_STAMP, TO_CHAR(R.RETIREMENT_DT, 'YYYY-MM-DD') AS RETIREMENT_DT, 
       R.TRANS_DT, TO_DATE('1901-01-01','YYYY-MM-DD') AS ACCOUNTING_DT, R.CONVENTION, TO_CHAR(R.END_DEPR_DT, 'YYYY-MM-DD') AS END_DEPR_DT, 
       R.DISPOSAL_CODE, X1.XLATLONGNAME AS DISPOSAL_CD_DESCR, R.RETIREMENT_TYPE, X2.XLATLONGNAME AS RETIREMENT_TYPE_DESCR, R.RETIREMENT_STATUS, X3.XLATLONGNAME AS RETIREMENT_STS_DESCR,
       R.REFERENCE, R.QUANTITY, R.RETIREMENT_AMT, R.RETIREMENT_RSV, R.GAIN_LOSS, ACQ.CURRENCY_CD AS ACQ_CURR_CD, ACQ.AMOUNT AS ACQ_AMT, ACQ.TXN_CURRENCY_CD AS ACQ_TXN_CURR_CD, ACQ.TXN_AMOUNT AS ACQ_TXN_AMT, 
       ' ', R.FROM_CUR, R.RETIREMENT_PCT, R.FULLY_DEPR_SW, 0.00,
       ACQ.OPERATING_UNIT, ACQ.FUND_CODE, ACQ.DEPTID, ACQ.CHARTFIELD2, ACQ.PROJECT_ID,
       ASD.CUSTODIAN, ASD.OPERATING_UNIT AS CUST_OP_UNIT, ASD.FUND_CODE AS CUST_FUND_CODE, ASD.DEPTID AS CUST_DEPTID, ASD.CHARTFIELD2 AS CUST_DONOR, ASD.PROJECT_ID AS CUST_PROJECT_ID
FROM (((((PS_RETIREMENT_NF R LEFT OUTER JOIN PS_ASSET_ACQ_DET ACQ ON R.BUSINESS_UNIT = ACQ.BUSINESS_UNIT AND R.ASSET_ID = ACQ.ASSET_ID)
      LEFT OUTER JOIN PS_ASSET_CUSTODIAN ASD ON R.BUSINESS_UNIT =  ASD.BUSINESS_UNIT AND R.ASSET_ID =  ASD.ASSET_ID)
      LEFT OUTER JOIN PSXLATITEM X1 ON X1.FIELDNAME = 'DISPOSAL_CODE' AND X1.FIELDVALUE = R.DISPOSAL_CODE AND X1.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X2 ON X2.FIELDNAME = 'RETIREMENT_TYPE' AND X2.FIELDVALUE = R.RETIREMENT_TYPE AND X2.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X3 ON X3.FIELDNAME = 'RETIREMENT_STATUS' AND X3.FIELDVALUE = R.RETIREMENT_STATUS AND X3.EFF_STATUS = 'A'), PS_ASSET B
WHERE R.BUSINESS_UNIT = B.BUSINESS_UNIT
  AND R.ASSET_ID = B.ASSET_ID
  AND (ASD.EFFDT = (SELECT MAX(EFFDT) FROM PS_ASSET_CUSTODIAN A_ASD WHERE ASD.BUSINESS_UNIT = A_ASD.BUSINESS_UNIT AND ASD.ASSET_ID = A_ASD.ASSET_ID AND A_ASD.EFFDT <= SYSDATE)
    OR ASD.EFFDT IS NULL)
  AND (ASD.EFFSEQ = (SELECT MAX(ASD_ED.EFFSEQ) FROM PS_ASSET_CUSTODIAN ASD_ED WHERE ASD.BUSINESS_UNIT = ASD_ED.BUSINESS_UNIT AND ASD.ASSET_ID = ASD_ED.ASSET_ID AND ASD.EFFDT = ASD_ED.EFFDT)
    OR ASD.EFFSEQ IS NULL)
  AND R.BUSINESS_UNIT = 'UNUNI'
ORDER BY DTTM_STAMP DESC, BUSINESS_UNIT, ASSET_ID, BOOK, RETIREMENT_DT;
