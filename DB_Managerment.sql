/* I. CREATE TABLES */

-- faculty
CREATE TABLE faculty (
    id   NUMBER PRIMARY KEY,
    name NVARCHAR2(30) NOT NULL
);

CREATE TABLE giaovien (
    id   NUMBER PRIMARY KEY,
    name NVARCHAR2(30) NOT NULL
);
-- subject
CREATE TABLE subject (
    id              NUMBER PRIMARY KEY,
    name            NVARCHAR2(100) NOT NULL,
    lesson_quantity NUMBER(2, 0) NOT NULL
);

-- student
CREATE TABLE student (
    id          NUMBER PRIMARY KEY,
    name        NVARCHAR2(30) NOT NULL,
    gender      NVARCHAR2(10) NOT NULL,
    birthday    DATE NOT NULL,
    hometown    NVARCHAR2(100) NOT NULL,
    scholarship NUMBER,
    faculty_id  NUMBER NOT NULL
        CONSTRAINT faculty_id
            REFERENCES faculty ( id )
);

-- exam management

CREATE TABLE exam_management (
    id                    NUMBER PRIMARY KEY,
    student_id            NUMBER NOT NULL
        CONSTRAINT student_id
            REFERENCES student ( id ),
    subject_id            NUMBER NOT NULL
        CONSTRAINT subject_id
            REFERENCES subject ( id ),
    number_of_exam_taking NUMBER NOT NULL,
    mark                  NUMBER(4, 2) NOT NULL
);

CREATE TABLE tintuc (
    id          NUMBER PRIMARY KEY,
    title       VARCHAR(200),
    description VARCHAR(500)
)


/*================================================*/

/* II. INSERT SAMPLE DATA */

-- subject
INSERT INTO subject (
    id,
    name,
    lesson_quantity
) VALUES (
    1,
    'C? s? d? li?u',
    45
);

INSERT INTO subject VALUES (
    2,
    'Trí tu? nhân t?o',
    45
);

INSERT INTO subject VALUES (
    3,
    'Truy?n tin',
    45
);

INSERT INTO subject VALUES (
    4,
    '?? h?a',
    60
);

INSERT INTO subject VALUES (
    5,
    'V?n ph?m',
    45
);


-- faculty
INSERT INTO faculty VALUES (
    1,
    'Anh - V?n'
);

INSERT INTO faculty VALUES (
    2,
    'Tin h?c'
);

INSERT INTO faculty VALUES (
    3,
    'Tri?t h?c'
);

INSERT INTO faculty VALUES (
    4,
    'V?t lý'
);


-- student
INSERT INTO student VALUES (
    1,
    'Nguy?n Th? H?i',
    'N?',
    TO_DATE('19900223', 'YYYYMMDD'),
    'Hà N?i',
    130000,
    2
);

INSERT INTO student VALUES (
    2,
    'Tr?n V?n Chính',
    'Nam',
    TO_DATE('19921224', 'YYYYMMDD'),
    'Bình ??nh',
    150000,
    4
);

INSERT INTO student VALUES (
    3,
    'Lê Thu Y?n',
    'N?',
    TO_DATE('19900221', 'YYYYMMDD'),
    'TP HCM',
    150000,
    2
);

INSERT INTO student VALUES (
    4,
    'Lê Thu Y?n',
    'N?',
    TO_DATE('19900221', 'YYYYMMDD'),
    'TP HCM',
    170000,
    2
);

INSERT INTO student VALUES (
    5,
    'Tr?n Anh Tu?n',
    'Nam',
    TO_DATE('19901220', 'YYYYMMDD'),
    'Hà N?i',
    180000,
    1
);

INSERT INTO student VALUES (
    6,
    'Tr?n Thanh Mai',
    'N?',
    TO_DATE('19910812', 'YYYYMMDD'),
    'H?i Phòng',
    NULL,
    3
);

INSERT INTO student VALUES (
    7,
    'Tr?n Th? Thu Th?y',
    'N?',
    TO_DATE('19910102', 'YYYYMMDD'),
    'H?i Phòng',
    10000,
    1
);


-- exam_management
INSERT INTO exam_management VALUES (
    1,
    1,
    1,
    1,
    3
);

INSERT INTO exam_management VALUES (
    2,
    1,
    1,
    2,
    6
);

INSERT INTO exam_management VALUES (
    3,
    1,
    2,
    2,
    6
);

INSERT INTO exam_management VALUES (
    4,
    1,
    3,
    1,
    5
);

INSERT INTO exam_management VALUES (
    5,
    2,
    1,
    1,
    4.5
);

INSERT INTO exam_management VALUES (
    6,
    2,
    1,
    2,
    7
);

INSERT INTO exam_management VALUES (
    7,
    2,
    3,
    1,
    10
);

INSERT INTO exam_management VALUES (
    8,
    2,
    5,
    1,
    9
);

INSERT INTO exam_management VALUES (
    9,
    3,
    1,
    1,
    2
);

INSERT INTO exam_management VALUES (
    10,
    3,
    1,
    2,
    5
);

INSERT INTO exam_management VALUES (
    11,
    3,
    3,
    1,
    2.5
);

INSERT INTO exam_management VALUES (
    12,
    3,
    3,
    2,
    4
);

INSERT INTO exam_management VALUES (
    13,
    4,
    5,
    2,
    10
);

INSERT INTO exam_management VALUES (
    14,
    5,
    1,
    1,
    7
);

INSERT INTO exam_management VALUES (
    15,
    5,
    3,
    1,
    2.5
);

INSERT INTO exam_management VALUES (
    16,
    5,
    3,
    2,
    5
);

INSERT INTO exam_management VALUES (
    17,
    6,
    2,
    1,
    6
);

INSERT INTO exam_management VALUES (
    18,
    6,
    4,
    1,
    10
);


--UPDATE
--    table_name
--SET
--    column1 = value1,
--    column2 = value2,
--    column3 = value3,
--    ...
--WHERE
--    condition;

--Câu UPDATEl?nh sau thay ??i chi phí c?a b? ph?n v?i id 1:

UPDATE parts
SET
    cost = 130
WHERE
    part_id = 1;

--DELETE
--FROM
--    table_name
--WHERE
--    condition;

DELETE FROM sales
WHERE
        order_id = 1
    AND item_id = 1;

--khi s? d?ng TRUNCATE TABLEcâu l?nh ?? xóa t?t c? các hàng kh?i m?t b?ng l?n.
SELECT
    *
FROM
    subject;
--?? thêm m?t c?t trong b?ng hi?n có
ALTER TABLE subject ADD (
    score1 VARCHAR(10)
);
--?? s?a ??i m?t c?t duy nh?t c?a b?ng
ALTER TABLE subject MODIFY (
    score VARCHAR2(20) NOT NULL,
    giaovien VARCHAR(50)
);

--xoa cot
ALTER TABLE subject DROP COLUMN score1; 

--thay doi ten cot
ALTER TABLE subject RENAME COLUMN giaovien TO teacher;

SELECT
    *
FROM
    giaovien;

DROP TABLE giaovien;

--order by: ???c s? d?ng ?? s?p x?p ho?c s?p x?p l?i các b?n ghi trong t?p k?t qu?
SELECT
    scholarship AS luong
FROM
    student
WHERE
    scholarship > 0
ORDER BY
    scholarship ASC;

SELECT
    *
FROM
    student
WHERE
        gender = 'Nam'
    AND scholarship > 10000;

SELECT
    *
FROM
    student
WHERE
    gender = 'Nam'
    OR scholarship > 10000;

SELECT
    *
FROM
    student
WHERE
    NOT gender = 'Nam'
        AND scholarship > 10000;

SELECT
    *
FROM
    student
WHERE
    name LIKE '%Chính';
-- in: dùng ?? gi?m vi?c s? d?ng nhi?u ?i?u ki?n OR.    
SELECT
    *
FROM
    student
WHERE
    hometown IN ( 'Hà N?i', 'H?i Phòng' );
--BETWEEN ???c s? d?ng ?? l?y các giá tr? t? ph?m vi ?ã cho
SELECT
    *
FROM
    student
WHERE
    scholarship BETWEEN 10000 AND 180000;

SELECT
    SUM(scholarship) AS tong
FROM
    student;

SELECT
    AVG(scholarship) AS trungbinh
FROM
    student;

SELECT
    MIN(scholarship) AS giatrinhonhat
FROM
    student;

SELECT
    MAX(scholarship) AS giatrilonnhat
FROM
    student;

--h??ng d?n b?n cách nhóm các hàng thành các nhóm con và áp d?ng hàm t?ng h?p cho m?i nhóm
SELECT
    hometown
FROM
    student
GROUP BY
    hometown;

SELECT
    hometown,
    COUNT(id),
    SUM(scholarship)
FROM
    student
GROUP BY
    hometown
HAVING COUNT(id) > 1
       OR SUM(scholarship) > 10000;

--cho b?n cách l?c m?t nhóm hàng.
--N?u b?n s? d?ng HAVINGm?nh ?? không có GROUP BYm?nh ?? thì HAVING m?nh ?? ho?t ??ng gi?ng nh? WHEREm?nh ??.
SELECT
    *
FROM
    student
HAVING COUNT(id) > 1
       OR SUM(scholarship) > 10000;




-- ch? cho b?n cách truy v?n các hàng t? m?t b?ng có các hàng phù h?p t? m?t b?ng khác.
SELECT
    student.id,
    student.name
FROM
         student
    INNER JOIN exam_management ON exam_management.student_id = student.id;


-- ?? ch?n các hàng t? b?ng bên trái có ho?c không có các hàng phù h?p trong b?ng bên ph?i
SELECT
    student.id,
    student.name,
    exam_management.mark,
    exam_management.subject_id
FROM
    student
    LEFT JOIN exam_management ON exam_management.student_id = student.id;

--?? truy v?n các hàng t? b?ng bên ph?i có ho?c không có các hàng phù h?p trong b?ng bên trái
SELECT DISTINCT
    student.id,
    student.name,
    exam_management.mark
FROM
         exam_management right
    JOIN student ON exam_management.student_id = student.id;

--mô t? cách s? d?ng k?t n?i bên ngoài ??y ?? ho?c k?t n?i ??y ?? ?? truy v?n d? li?u t? hai b?ng.
--UNION  - ch? cho b?n cách k?t h?p k?t qu? c?a hai truy v?n thành m?t k?t qu? duy nh?t.
--xóa t?t c? d? li?u kh?i b?ng nhanh h?n và hi?u qu? h?n.
--- delete xóa khôi ph?c ???c
---truncate : xóa và không khôi ph?c ???c;
---having: ?i vs group by vs các hàm tính toán;
---1 t?p h?p
---cross join vs full join


--1.liet ke danh sach sinh vien theo thu tu 
--a.Id Tang dan
SELECT
    *
FROM
    student
ORDER BY
    student.id ASC;
--b.gioi tinh
SELECT
    *
FROM
    student
ORDER BY
    student.gender ASC;
--c.ngày sinh T?NG D?N và h?c b?ng GI?M D?N
SELECT
    *
FROM
    student
ORDER BY
    student.birthday ASC,
    student.scholarship DESC;
-- 2. Môn h?c có tên b?t ??u b?ng ch? 'T'
SELECT
    *
FROM
    student
WHERE
    student.name LIKE 'T%';
-- 3. Sinh viên có ch? cái cu?i cùng trong tên là 'i'
SELECT
    *
FROM
    student
WHERE
    student.name LIKE '%i';
-- 4. Nh?ng khoa có ký t? th? hai c?a tên khoa có ch?a ch? 'n'
SELECT
    *
FROM
    faculty
WHERE
    faculty.name LIKE '_n%';
-- 5. Sinh viên trong tên có t? 'Th?'
SELECT
    *
FROM
    student
WHERE
    student.name LIKE '%Th?%';
-- 6. Sinh viên có ký t? ??u tiên c?a tên n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? tên sinh viên
SELECT
    *
FROM
    student
WHERE
    student.name BETWEEN 'A' AND 'M'
ORDER BY
    student.name;
-- 7. Sinh viên có h?c b?ng l?n h?n 100000, s?p x?p theo mã khoa gi?m d?n
SELECT
    *
FROM
    student
WHERE
    scholarship > 100000
ORDER BY
    faculty_id DESC;
-- 8. Sinh viên có h?c b?ng t? 150000 tr? lên và sinh ? Hà N?i
SELECT
    *
FROM
    student
WHERE
        scholarship >= 150000
    AND hometown = 'Hà N?i';
-- 9. Nh?ng sinh viên có ngày sinh t? ngày 01/01/1991 ??n ngày 05/06/1992
SELECT
    *
FROM
    student
WHERE
    birthday BETWEEN TO_DATE('19900101', 'YYYYMMDD') AND TO_DATE('19920605', 'YYYYMMDD'); 
-- 10. Nh?ng sinh viên có h?c b?ng t? 80000 ??n 150000
SELECT
    *
FROM
    student
WHERE
    scholarship BETWEEN 80000 AND 150000;
-- 11. Nh?ng môn h?c có s? ti?t l?n h?n 30 và nh? h?n 45
SELECT
    *
FROM
    subject
WHERE
        lesson_quantity > 30
    AND id < 45;
/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t thông tin v? m?c h?c b?ng c?a các sinh viên, g?m: Mã sinh viên, Gi?i tính, Mã 
		-- khoa, M?c h?c b?ng. Trong ?ó, m?c h?c b?ng s? hi?n th? là “H?c b?ng cao” n?u giá tr? 
		-- c?a h?c b?ng l?n h?n 500,000 và ng??c l?i hi?n th? là “M?c trung bình”.

SELECT
    student.id,
    student.gender,
    student.faculty_id,
    student.scholarship,
    CASE
        WHEN scholarship > 500000 THEN
            'H?c b?ng cao'
        ELSE
            'H?c trung bình'
    END
FROM
         student
    INNER JOIN faculty ON student.faculty_id = faculty.id;
-- 2. Tính t?ng s? sinh viên c?a toàn tr??ng
SELECT
    COUNT(name) AS t?ngs?sinhviên
FROM
    student;
-- 3. Tính t?ng s? sinh viên nam và t?ng s? sinh viên n?.
SELECT
    gender,
    COUNT(student.id)
FROM
    student
GROUP BY
    gender;

-- 4. Tính t?ng s? sinh viên t?ng khoa (ch?a c?n JOIN)
SELECT
    COUNT(student.faculty_id)
FROM
    student
GROUP BY
    faculty_id;

SELECT
    student.faculty_id,
    COUNT(*)
FROM
    student
GROUP BY
    faculty_id; 
-- 5. Tính t?ng s? sinh viên c?a t?ng môn h?c
SELECT
    subject_id,
    COUNT(student_id)
FROM
    exam_management
GROUP BY
    subject_id;
-- 6. Tính s? l??ng môn h?c mà sinh viên ?ã h?c
SELECT
    *
FROM
    student;

SELECT
    student.name,
    COUNT(subject_id)
FROM
    student,
    exam_management
WHERE
    student.id = exam_management.student_id
GROUP BY
    student.name;
-- 7. T?ng s? h?c b?ng c?a m?i khoa	
SELECT
    faculty.name,
    COUNT(student.scholarship)
FROM
    faculty,
    student
WHERE
    student.faculty_id = faculty.id
GROUP BY
    faculty.name;
-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
SELECT
    faculty.name,
    MAX(student.scholarship)
FROM
    faculty,
    student
WHERE
    student.faculty_id = faculty.id
GROUP BY
    faculty.name;
-- 9. Cho bi?t t?ng s? sinh viên nam và t?ng s? sinh viên n? c?a m?i khoa
SELECT
    faculty.name,
    gender,
    COUNT(student.id)
FROM
    faculty,
    student
WHERE
        gender = 'Nam'
    AND student.faculty_id = faculty.id
GROUP BY
    student.gender,
    faculty.name
UNION
SELECT
    faculty.name,
    gender,
    COUNT(student.id)
FROM
    faculty,
    student
WHERE
        gender = 'N?'
    AND student.faculty_id = faculty.id
GROUP BY
    student.gender,
    faculty.name;
-- 10. Cho bi?t s? l??ng sinh viên theo t?ng ?? tu?i
SELECT
    name,
    COUNT(birthday)
FROM
    student
GROUP BY
    name;
-- 11. Cho bi?t nh?ng n?i nào có h?n 2 sinh viên ?ang theo h?c t?i tr??ng
SELECT
    student.hometown,
    COUNT(id)
FROM
    student
GROUP BY
    hometown
HAVING
    COUNT(id) >= 2;
-- 12. Cho bi?t nh?ng sinh viên thi l?i ít nh?t 2 l?n
SELECT
    student.name,
    exam_management.subject_id,
    COUNT(exam_management.number_of_exam_taking)
FROM
    student,
    exam_management
WHERE
    student.id = exam_management.student_id
GROUP BY
    student.name,
    exam_management.subject_id
HAVING
    COUNT(number_of_exam_taking) >= 2;
-- 13. Cho bi?t nh?ng sinh viên nam có ?i?m trung bình l?n 1 trên 7.0 
SELECT
    student.name,
    AVG(exam_management.mark)
FROM
    student,
    exam_management
WHERE
        student.id = exam_management.student_id
    AND gender = 'Nam'
    AND exam_management.number_of_exam_taking = 1
GROUP BY
    student.name
HAVING
    AVG(exam_management.mark) >= 7;
-- 14. Cho bi?t danh sách các sinh viên r?t trên 2 môn ? l?n thi 1 (r?t môn là ?i?m thi c?a môn không quá 4 ?i?m)

-- 15. Cho bi?t danh sách nh?ng khoa có nhi?u h?n 2 sinh viên nam (ch?a c?n JOIN)

-- 16. Cho bi?t nh?ng khoa có 2 sinh viên ??t h?c b?ng t? 200000 ??n 300000

-- 17. Cho bi?t sinh viên nào có h?c b?ng cao nh?t