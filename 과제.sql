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


-- 3. "국어국문학과"에 다니는 여중생 중 현재 휴학중인 여학생을 
