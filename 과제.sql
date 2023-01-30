--[BASIC SELECT]
-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 
SELECT
       DEPARTMENT_NAME 학과명
     , CATEGORY 계열
  FROM TB_DEPARTMENT;
  

-- 2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
SELECT
       DEPARTMENT_NAME || '의 정원은' || CAPACITY || '입니다.' 학과별정원
  FROM TB_DEPARTMENT;


-- 3. "국어국문학과"에 다니는 여중생 중 현재 휴학중인 여학생을 찾아달라는 요청이 들어왔다. 누구인가?
SELECT
       S.STUDENT_NAME 학생이름
  FROM TB_STUDENT S
  JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
 WHERE SUBSTR(S.STUDENT_SSN, 8, 1) = 2 AND S.ABSENCE_YN = 'Y' AND D.DEPARTMENT_NAME = '국어국문학과';
 
 
--4. 도서관에서 대출 도서 장기 연체자들을 찾아 이름을 게시하고자 한다. 그 대상자들의 학번이 다음과 같을 때 
--   대상자들을 찾는 적절한 SQL 구문을 작성하시오 (A513079, A513090, A513091, A513110, A513119
SELECT
       S.STUDENT_NAME
  FROM TB_STUDENT S
 WHERE S.STUDENT_NO = 'A513079' OR S.STUDENT_NO = 'A513090' OR S.STUDENT_NO = 'A513091' OR  S.STUDENT_NO = 'A513110' OR  S.STUDENT_NO = 'A513119' ;

-- 5. 입학정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 출력하세요.
SELECT
       D.DEPARTMENT_NAME
      , D.CATEGORY
  FROM TB_DEPARTMENT D
 WHERE D.CAPACITY BETWEEN 20 AND 30;



--6. 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다. 
--   그럼 춘 기술대학교 총장 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
SELECT
        PROFESSOR_NAME
  FROM TB_PROFESSOR
 WHERE DEPARTMENT_NO IS NULL;


--7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
SELECT
       STUDENT_NAME 학생이름
  FROM TB_STUDENT
 WHERE DEPARTMENT_NO IS NULL;
 
 
 --8. 수강신청을 하려고한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는 과목들은 어떤 과목인지
 -- 과목번호를 조회해보세요.
 
 
 -- 9.  춘 대학에는 어떤 계열들이 있는지 조회해보세요.
 SELECT
       DISTINCT CATEGORY
  FROM TB_DEPARTMENT;
-- GROUP BY CATEGORY;
 
 -- 10. 02학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외한 재학중인 학생들의
 --    학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
 SELECT
       S.STUDENT_NO
     , S.STUDENT_NAME
     , S.STUDENT_SSN
  FROM TB_STUDENT S
 WHERE TO_CHAR(S.ENTRANCE_DATE, 'YY') = 02 AND SUBSTR(S.STUDENT_ADDRESS, 1, 2) = '전주' AND S.ABSENCE_YN = 'N';
 
 
-- [ADDITIONAL]
 
 --1. 영어영문학과(학과코드002) 학생들의 학번과 이름, 입학년도를 입학 년도가 빠른 순으로 표시하는 SQL문 작성
 SELECT
       STUDENT_NO 학번
     , STUDENT_NAME 이름
     , TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
  FROM TB_STUDENT S
  JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
 WHERE DEPARTMENT_NAME = '영어영문학과'
 ORDER BY S.ENTRANCE_DATE;
 
 
 -- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다. 
 --     그 교수의 이름과 주민번호를 화면에 출력하는 SQL작성
 SELECT
       PROFESSOR_NO
     , PROFESSOR_NAME
     , PROFESSOR_SSN
  FROM TB_PROFESSOR
 WHERE PROFESSOR_NAME NOT LIKE '___';
 
 
 -- 3.
 SELECT 
       PROFESSOR_NAME 교수이름
     ,TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN, 1,6), 'RRMMDD'), 'RRRR') -1 나이
  FROM TB_PROFESSOR
 WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
ORDER BY PROFESSOR_SSN DESC;
 
 --4 
SELECT
        SUBSTR(PROFESSOR_NAME, 2) 이름
  FROM TB_PROFESSOR;
 
--5 
SELECT
       STUDENT_NO
     , STUDENT_NAME
  FROM TB_STUDENT
 WHERE SUBSTR(TO_CHAR(ENTRANCE_DATE, 'RRRR'), 1,4) - (TO_CHAR(SUBSTR(STUDENT_SSN, 1, 2) ) + 1900) -1 = '19';
 
 -- 6 
 SELECT
       TO_CHAR(TO_DATE('20201225', 'RRRRMMDD'), 'DAY')
  FROM DUAL;
 
 --8
 SELECT
       STUDENT_NO
     , STUDENT_NAME
  FROM TB_STUDENT
 WHERE STUDENT_NO LIKE '9______';
 
 
 --9
SELECT
       ROUND(AVG(G.POINT), 1)
  FROM TB_GRADE G
  JOIN TB_STUDENT S ON( G.STUDENT_NO = S.STUDENT_NO)
 WHERE S.STUDENT_NO = 'A517178';
--  GROUP BY G.STUDENT_NO;
 
 
--10
SELECT
       D.DEPARTMENT_NO 학과번호
     , COUNT(S.STUDENT_NO) AS 학생수
  FROM TB_DEPARTMENT D
  JOIN TB_STUDENT S ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO)
  GROUP BY (D.DEPARTMENT_NO)
ORDER BY 1;


--11
SELECT
       COUNT(*)
  FROM TB_STUDENT
 WHERE COACH_PROFESSOR_NO IS NULL;


--12
SELECT
       SUBSTR(G.TERM_NO, 1, 4) 년도
      ,ROUND(AVG(G.POINT), 1)
  FROM TB_GRADE G
 WHERE G.STUDENT_NO = 'A112113'
GROUP BY SUBSTR(G.TERM_NO, 1, 4);
       
