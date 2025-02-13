--Bank Statements
--Yearly Aggregation
--More detail and easier to interpret
SELECT X.BANK_CD, X.DESCR, X.COUNTRY, X.BANK_ACCT_KEY, X.BNK_ID_NBR, X.BANK_ACCOUNT_NUM, X.BANK_ACCT_DESCR, X.CURRENCY_CD, X.VALUE_YEAR, X.VALUE_MONTH,
       SUM(X.OPENING_LEDGER) AS "OPENING LEDGER", SUM(X.CLOSING_LEDGER) "CLOSING LEDGER"
FROM
(
SELECT B.BANK_CD, B.DESCR, B.COUNTRY, C.BANK_ACCT_KEY, A.BNK_ID_NBR, A.BANK_ACCOUNT_NUM, C.DESCR AS BANK_ACCT_DESCR, A.CURRENCY_CD, 
       TO_CHAR(A.VALUE_DT, 'YYYY') AS VALUE_YEAR, TO_CHAR(A.VALUE_DT, 'MM') AS VALUE_MONTH, COUNT(1), SUM(A.BALANCE) AS BALANCE
       , CASE A.BANK_STMT_CODE WHEN '010' THEN SUM(A.BALANCE) ELSE 0 END AS "OPENING_LEDGER"
       , CASE A.BANK_STMT_CODE WHEN '015' THEN SUM(A.BALANCE) ELSE 0 END AS "CLOSING_LEDGER"
FROM PS_BANK_BALANCES A, PS_BANK_CD_TBL B, PS_BANK_ACCT_DEFN C
WHERE B.SETID = 'SHARE' 
  AND A.BNK_ID_NBR = B.BNK_ID_NBR
  AND B.SETID = C.SETID 
  AND B.BANK_CD = C.BANK_CD
  AND A.BANK_ACCOUNT_NUM = C.BANK_ACCOUNT_NUM
  AND B.BANK_CD LIKE '6%'
  --AND B.BANK_CD = '60001'
  AND TO_CHAR(A.VALUE_DT, 'YYYY') >= '2015'
GROUP BY B.BANK_CD, B.DESCR, B.COUNTRY, C.BANK_ACCT_KEY, A.BNK_ID_NBR, A.BANK_ACCOUNT_NUM, C.DESCR, A.CURRENCY_CD, A.BANK_STMT_CODE, TO_CHAR(A.VALUE_DT, 'YYYY'), TO_CHAR(A.VALUE_DT, 'MM')
) X
GROUP BY X.BANK_CD, X.DESCR, X.COUNTRY, X.BANK_ACCT_KEY, X.BNK_ID_NBR, X.BANK_ACCOUNT_NUM, X.BANK_ACCT_DESCR, X.CURRENCY_CD, X.VALUE_YEAR, X.VALUE_MONTH
ORDER BY X.BANK_CD, X.VALUE_YEAR DESC, X.VALUE_MONTH DESC;
--Trying to see if the numbers can somehow be reconciled with PAYMENT_TBL
--Numbers tie
--Creation Date and Payment Date need to check
SELECT BANK_NAME, COUNTRY_NAME, BANK_ACCOUNT_NUM, PAY_CYCLE, TO_CHAR(PYMNT_DT, 'YYYY') AS "YEAR", SUM(PYMNT_AMT) AS "PYMNT_AMT", CURRENCY_CD 
FROM PS_EFT_BANK_TMP 
WHERE BNK_ID_NBR IN (SELECT BNK_ID_NBR FROM PS_BANK_CD_TBL WHERE SETID = 'SHARE' AND BANK_CD LIKE '6%')
  AND TO_CHAR(PYMNT_DT, 'YYYY') >= '2015'
GROUP BY BANK_NAME, COUNTRY_NAME, BANK_ACCOUNT_NUM, PAY_CYCLE, TO_CHAR(PYMNT_DT, 'YYYY'), CURRENCY_CD
ORDER BY TO_CHAR(PYMNT_DT, 'YYYY') DESC, BANK_NAME, COUNTRY_NAME, BANK_ACCOUNT_NUM, PAY_CYCLE;
--Stats from PAYMENT_TBL
--Numbers tie with EFT_BANK_TMP
SELECT PY.BANK_CD, BCD.DESCR AS BANK_CD_DESCR, BCD.BANK_ID_QUAL, BCD.COUNTRY, BAD.BANK_ACCT_KEY, PY.BANK_ACCOUNT_NUM, BAD.DESCR AS BANK_ACCT_NUM_DESCR, 
       PY.PAY_CYCLE, PY.PYMNT_METHOD, PY.PYMNT_HANDLING_CD, PY.EFT_PYMNT_FMT_CD, PY.EFT_TRANS_HANDLING, X2.XLATLONGNAME AS EFT_TANS_CD, PY.PYMNT_TYPE, PY.SOURCE_TXN, PY.PREFERRED_LANGUAGE, PY.EFT_LAYOUT_CD, 
       PY.STL_THROUGH, X1.XLATLONGNAME AS SETTLED_BY, TO_CHAR(PY.PYMNT_DT, 'YYYY') AS "YEAR", SUM(PY.PYMNT_AMT) AS "PYMNT_AMT", PY.CURRENCY_PYMNT
FROM ((((PS_PAYMENT_TBL PY LEFT OUTER JOIN PS_BANK_CD_TBL BCD ON PY.BANK_SETID = BCD.SETID AND PY.BANK_CD = BCD.BANK_CD)
      LEFT OUTER JOIN PS_BANK_ACCT_DEFN BAD ON BCD.SETID = BAD.SETID AND BCD.BANK_CD = BAD.BANK_CD AND PY.BANK_ACCT_KEY = BAD.BANK_ACCT_KEY)
      LEFT OUTER JOIN PSXLATITEM X1 ON X1.FIELDNAME = 'STL_THROUGH' AND X1.FIELDVALUE = PY.STL_THROUGH AND X1.EFF_STATUS = 'A')
      LEFT OUTER JOIN PSXLATITEM X2 ON X2.FIELDNAME = 'EFT_TRANS_HANDLING' AND X2.FIELDVALUE = PY.EFT_TRANS_HANDLING AND X2.EFF_STATUS = 'A')
WHERE PY.BANK_SETID = 'SHARE' 
  AND PY.BANK_CD LIKE '6%'
  AND TO_CHAR(PY.PYMNT_DT, 'YYYY') >= '2015'
GROUP BY PY.BANK_CD, BCD.DESCR, BCD.BANK_ID_QUAL, BCD.COUNTRY, BAD.BANK_ACCT_KEY, PY.BANK_ACCOUNT_NUM, BAD.DESCR,
         PY.PAY_CYCLE, PY.PYMNT_METHOD, PY.PYMNT_HANDLING_CD, PY.EFT_PYMNT_FMT_CD, PY.EFT_TRANS_HANDLING, X2.XLATLONGNAME, PY.PYMNT_TYPE, PY.SOURCE_TXN, PY.PREFERRED_LANGUAGE, 
         PY.EFT_LAYOUT_CD, PY.STL_THROUGH, X1.XLATLONGNAME, TO_CHAR(PY.PYMNT_DT, 'YYYY'), PY.CURRENCY_PYMNT
ORDER BY TO_CHAR(PY.PYMNT_DT, 'YYYY') DESC, PY.BANK_CD, BAD.BANK_ACCT_KEY, PY.BANK_ACCOUNT_NUM, PY.PAY_CYCLE;
