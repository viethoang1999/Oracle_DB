--1.liet ke danh sach sinh vien theo thu tu
--a.Id Tang dan
SELECT *
FROM student
ORDER BY student.id ASC;
--b.gioi tinh
SELECT *
FROM student
ORDER BY student.gender ASC;
--c.ng�y sinh T?NG D?N v� h?c b?ng GI?M D?N
SELECT *
FROM student
ORDER BY student.birthday ASC,
         student.scholarship DESC;
-- 2. M�n h?c c� t�n b?t ??u b?ng ch? 'T'
SELECT *
FROM student
WHERE student.name LIKE 'T%';
-- 3. Sinh vi�n c� ch? c�i cu?i c�ng trong t�n l� 'i'
SELECT *
FROM student
WHERE student.name LIKE '%i';
-- 4. Nh?ng khoa c� k� t? th? hai c?a t�n khoa c� ch?a ch? 'n'
SELECT *
FROM faculty
WHERE faculty.name LIKE '_n%';
-- 5. Sinh vi�n trong t�n c� t? 'Th?'
SELECT *
FROM student
WHERE student.name LIKE '%Th?%';
-- 6. Sinh vi�n c� k� t? ??u ti�n c?a t�n n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? t�n sinh vi�n
SELECT *
FROM student
WHERE student.name BETWEEN 'A' AND 'M'
ORDER BY student.name;
-- 7. Sinh vi�n c� h?c b?ng l?n h?n 100000, s?p x?p theo m� khoa gi?m d?n
SELECT *
FROM student
WHERE scholarship > 100000
ORDER BY faculty_id DESC;
-- 8. Sinh vi�n c� h?c b?ng t? 150000 tr? l�n v� sinh ? H� N?i
SELECT *
FROM student
WHERE scholarship >= 150000
  AND hometown = 'H� N?i';
-- 9. Nh?ng sinh vi�n c� ng�y sinh t? ng�y 01/01/1991 ??n ng�y 05/06/1992
SELECT *
FROM student
WHERE birthday BETWEEN TO_DATE('19900101', 'YYYYMMDD') AND TO_DATE('19920605', 'YYYYMMDD');
-- 10. Nh?ng sinh vi�n c� h?c b?ng t? 80000 ??n 150000
SELECT *
FROM student
WHERE scholarship BETWEEN 80000 AND 150000;
-- 11. Nh?ng m�n h?c c� s? ti?t l?n h?n 30 v� nh? h?n 45
SELECT *
FROM subject
WHERE lesson_quantity > 30
  AND id < 45;
/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t th�ng tin v? m?c h?c b?ng c?a c�c sinh vi�n, g?m: M� sinh vi�n, Gi?i t�nh, M� 
-- khoa, M?c h?c b?ng. Trong ?�, m?c h?c b?ng s? hi?n th? l� �H?c b?ng cao� n?u gi� tr?
-- c?a h?c b?ng l?n h?n 500,000 v� ng??c l?i hi?n th? l� �M?c trung b�nh�.

SELECT student.id,
       student.gender,
       student.faculty_id,
       student.scholarship,
       CASE
           WHEN scholarship > 500000 THEN
               'H?c b?ng cao'
           ELSE
               'H?c trung b�nh'
           END
FROM student
         INNER JOIN faculty ON student.faculty_id = faculty.id;
-- 2. T�nh t?ng s? sinh vi�n c?a to�n tr??ng
SELECT COUNT(name) AS t?ngs?sinhvi�n
FROM student;
-- 3. T�nh t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n?.
SELECT gender,
       COUNT(student.id)
FROM student
GROUP BY gender;

-- 4. T�nh t?ng s? sinh vi�n t?ng khoa (ch?a c?n JOIN)
SELECT COUNT(student.faculty_id)
FROM student
GROUP BY faculty_id;

SELECT student.faculty_id,
       COUNT(*)
FROM student
GROUP BY faculty_id;
-- 5. T�nh t?ng s? sinh vi�n c?a t?ng m�n h?c
SELECT subject_id,
       COUNT(student_id)
FROM exam_management
GROUP BY subject_id;
-- 6. T�nh s? l??ng m�n h?c m� sinh vi�n ?� h?c
SELECT *
FROM student;

SELECT student.name,
       COUNT(subject_id)
FROM student,
     exam_management
WHERE student.id = exam_management.student_id
GROUP BY student.name;
-- 7. T?ng s? h?c b?ng c?a m?i khoa	
SELECT faculty.name,
       COUNT(student.scholarship)
FROM faculty,
     student
WHERE student.faculty_id = faculty.id
GROUP BY faculty.name;
-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
SELECT faculty.name,
       MAX(student.scholarship)
FROM faculty,
     student
WHERE student.faculty_id = faculty.id
GROUP BY faculty.name;
-- 9. Cho bi?t t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n? c?a m?i khoa
SELECT faculty.name,
       gender,
       COUNT(student.id)
FROM faculty,
     student
WHERE gender = 'Nam'
  AND student.faculty_id = faculty.id
GROUP BY student.gender,
         faculty.name
UNION
SELECT faculty.name,
       gender,
       COUNT(student.id)
FROM faculty,
     student
WHERE gender = 'N?'
  AND student.faculty_id = faculty.id
GROUP BY student.gender,
         faculty.name;
-- 10. Cho bi?t s? l??ng sinh vi�n theo t?ng ?? tu?i
SELECT name,
       COUNT(birthday)
FROM student
GROUP BY name;
-- 11. Cho bi?t nh?ng n?i n�o c� h?n 2 sinh vi�n ?ang theo h?c t?i tr??ng
SELECT student.hometown,
       COUNT(id)
FROM student
GROUP BY hometown
HAVING COUNT(id) >= 2;
-- 12. Cho bi?t nh?ng sinh vi�n thi l?i �t nh?t 2 l?n
SELECT student.name,
       exam_management.subject_id,
       COUNT(exam_management.number_of_exam_taking)
FROM student,
     exam_management
WHERE student.id = exam_management.student_id
GROUP BY student.name,
         exam_management.subject_id
HAVING COUNT(number_of_exam_taking) >= 2;
-- 13. Cho bi?t nh?ng sinh vi�n nam c� ?i?m trung b�nh l?n 1 tr�n 7.0 
SELECT student.name,
       AVG(exam_management.mark)
FROM student,
     exam_management
WHERE student.id = exam_management.student_id
  AND gender = 'Nam'
  AND exam_management.number_of_exam_taking = 1
GROUP BY student.name
HAVING AVG(exam_management.mark) >= 7;
-- 14. Cho bi?t danh sách các sinh viên r?t trên 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)
select student.name
from student,
     exam_management
where student.id = exam_management.student_id
  and exam_management.number_of_exam_taking = 1
  and exam_management.mark <= 4
group by student.id, student.name;
-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam (ch?a c?n JOIN)
select faculty.name, count(student.id)
from faculty,
     student
where student.faculty_id = faculty.id
  and student.gender = 'Nam'
group by faculty.id, faculty.name
having count(student.id) >= 2
-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000
select faculty.name, count(student.id)
from faculty,
     student
where student.faculty_id = faculty.id
  and student.scholarship between 200000 and 300000
group by faculty.id, faculty.name
having count(student.id) = 2

-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t
select student.name, max(student.scholarship)
from student
where student.scholarship = (select max(student.scholarship) from student)
group by student.id, student.name;

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh viên có n?i sinh ? Hà N?i và sinh vào tháng 02
select student.name
from student
where to_char(birthday, 'MM') = '02'
  and student.hometown = 'Hà Nội';

-- 2. Sinh viên có tu?i l?n h?n 20
select student.name, current_year - to_number(to_char(student.birthday, 'YYYY')) as age
from student,
     (select to_number(to_char(sysdate, 'YYYY')) current_year from dual)
where current_year - to_number(to_char(student.birthday, 'YYYY')) > 20;
-- 3. Sinh viên sinh vào mùa xuân n?m 1990
select name
from student
where to_number(to_char(birthday, 'MM')) < 5;

-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh sách các sinh viên c?a khoa ANH V?N và khoa V?T LÝ
select student.name
from student
         join faculty on student.faculty_id = faculty.id
where faculty.name = 'Anh - Văn'
   or faculty.name = 'Vật lý';
-- 2. Nh?ng sinh viên nam c?a khoa ANH V?N và khoa TIN H?C
select student.name, faculty.name
from student,
     faculty
where student.faculty_id = faculty.id
  and (faculty.name = 'Anh - Văn' or faculty.name = 'Tin học')
  and student.gender = 'Nam';
-- 3. Cho bi?t sinh viên nào có ?i?m thi l?n 1 môn c? s? d? li?u cao nh?t
select student.name, exam_management.mark
from exam_management
         join student on student.id = exam_management.student_id
where number_of_exam_taking = 1
  and subject_id = 1
  and mark = (select max(mark)
              from exam_management
              where number_of_exam_taking = 1
                and subject_id = 1);
-- 4. Cho bi?t sinh viên khoa anh v?n có tu?i l?n nh?t.
select student.name, faculty.name, current_year - to_number(to_char(student.birthday, 'YYYY')) age
from faculty,
     student,
     (select to_number(to_char(sysdate, 'YYYY')) current_year from dual)
where faculty.name = 'Anh - V?n'
  and student.faculty_id = faculty.id
  and current_year - to_number(to_char(student.birthday, 'YYYY')) =
      (select max(current_year - to_number(to_char(student.birthday, 'YYYY')))
       from faculty,
            student,
            (select to_number(to_char(sysdate, 'YYYY')) current_year from dual)
       where faculty.name = 'Anh - V?n'
         and student.faculty_id = faculty.id);
-- 5. Cho bi?t khoa nào có ?ông sv nh?t
select faculty.name, count(student.id)
from faculty,
     student
where faculty.id = student.faculty_id
group by faculty.id, faculty.name
having count(student.faculty_id) >= all (select count(student.id) from student group by student.faculty_id);


-- 6. Cho bi?t khoa nào có ?ông n? nh?t
select faculty.name, gender, count(gender)
from faculty,
     student
where faculty.id = student.faculty_id
  and gender = 'Nữ'
group by faculty.name, gender
having count(student.faculty_id) >= all
       (select count(gender) from student where gender = 'Nữ' group by student.faculty_id);
-- 7. Cho bi?t nh?ng sinh viên ??t ?i?m cao nh?t trong t?ng môn
select student.name, max(mark)
from exam_management,
     student,
     subject
where exam_management.student_id = student.id
  and exam_management.subject_id = subject.id
group by student.id, student.name;
-- 8. Cho bi?t nh?ng khoa không có sinh viên h?c
select faculty.name, count(student.id)
from faculty
         join student on faculty.id = student.faculty_id
group by faculty.name
having count(student.id) = 0;
-- 9. Cho bi?t sinh viên ch?a thi môn c? s? d? li?u
select student.name, count(subject_id)
from exam_management
         join student on exam_management.student_id = student.id
where not exam_management.subject_id = 1
group by student.name;

-- 10. Cho bi?t sinh viên nào không thi l?n 1 mà có d? thi l?n 2

select student.name, number_of_exam_taking
from exam_management
         join student on student.id = exam_management.student_id
where number_of_exam_taking = 2
  and not exists(select id, student_id, subject_id, exam_management.number_of_exam_taking, mark
                 from exam_management
                 where number_of_exam_taking = 1
                   and student.id = exam_management.student_id);