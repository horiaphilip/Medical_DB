---4

CREATE SEQUENCE seq_clinici START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_manageri START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_firme_sec START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_firme_curat START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_angajati_sec START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_angajati_curat START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_personal_med START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_medicamente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_pacienti START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cas START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_asig_med START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_diagnostice START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_prescriptii START WITH 1 INCREMENT BY 1;

CREATE TABLE CLINICI (
    id_clinica NUMBER PRIMARY KEY,
    nume_sediu VARCHAR2(100),
    nr_tel VARCHAR2(15),
    email VARCHAR2(100),
    fax VARCHAR2(15)
);

CREATE TABLE MANAGERI (
    id_manager NUMBER PRIMARY KEY,
    id_clinica NUMBER REFERENCES CLINICI(id_clinica),
    cnp VARCHAR2(13) UNIQUE,
    nume VARCHAR2(50),
    prenume VARCHAR2(50),
    varsta NUMBER,
    data_angajarii DATE
);

CREATE TABLE FIRME_SEC (
    id_firma_sec NUMBER PRIMARY KEY,
    cui VARCHAR2(20) UNIQUE,
    nr_tel VARCHAR2(15),
    email VARCHAR2(100)
);

CREATE TABLE FIRME_CURAT (
    id_firma_curat NUMBER PRIMARY KEY,
    cui VARCHAR2(20) UNIQUE,
    nr_tel VARCHAR2(15),
    email VARCHAR2(100)
);

CREATE TABLE ANGAJATI_SEC (
    id_ang_sec NUMBER PRIMARY KEY ,
    id_firma_sec NUMBER REFERENCES FIRME_SEC(id_firma_sec),
    cnp VARCHAR2(13) UNIQUE,
    nume VARCHAR2(50),
    prenume VARCHAR2(50),
    varsta NUMBER,
    data_angajarii DATE
);

CREATE TABLE ANGAJATI_CURAT (
    id_ang_curat NUMBER PRIMARY KEY ,
    id_firma_curat NUMBER REFERENCES FIRME_CURAT(id_firma_curat),
    cnp VARCHAR2(13) UNIQUE,
    nume VARCHAR2(50),
    prenume VARCHAR2(50),
    varsta NUMBER,
    data_angajarii DATE
);

CREATE TABLE PAZA (
    id_clinica NUMBER REFERENCES CLINICI(id_clinica),
    id_ang_sec NUMBER REFERENCES ANGAJATI_SEC(id_ang_sec),
    PRIMARY KEY (id_clinica, id_ang_sec)
);

CREATE TABLE CURAT (
    id_clinica NUMBER REFERENCES CLINICI(id_clinica),
    id_ang_curat NUMBER REFERENCES ANGAJATI_CURAT(id_ang_curat),
    PRIMARY KEY (id_clinica, id_ang_curat)
);

CREATE TABLE PERSONAL_MED (
    id_pers NUMBER PRIMARY KEY,
    cnp VARCHAR2(13) UNIQUE,
    nume VARCHAR2(50),
    prenume VARCHAR2(50),
    varsta NUMBER,
    data_angajarii DATE
);

CREATE TABLE MEDICI (
    id_pers NUMBER PRIMARY KEY REFERENCES PERSONAL_MED(id_pers),
    specializare VARCHAR2(100),
    grad_profesional VARCHAR2(50)
);

CREATE TABLE ASISTENTI_MED (
    id_pers NUMBER PRIMARY KEY REFERENCES PERSONAL_MED(id_pers),
    nivel_studii VARCHAR2(50)
);

CREATE TABLE LUCRU (
    id_clinica NUMBER REFERENCES CLINICI(id_clinica),
    id_pers NUMBER REFERENCES PERSONAL_MED(id_pers),
    nr_contract_lucru VARCHAR2(50),
    PRIMARY KEY (id_clinica, id_pers)
);

CREATE TABLE MEDICAMENTE (
    id_medicament NUMBER PRIMARY KEY,
    nume VARCHAR2(100),
    stoc NUMBER,
    data_expirarii DATE
);

CREATE TABLE PACIENTI (
    id_pacient NUMBER PRIMARY KEY ,
    cnp VARCHAR2(13) UNIQUE,
    nume VARCHAR2(50),
    prenume VARCHAR2(50),
    varsta NUMBER
);

CREATE TABLE PRESCRIPTII (
    id_pers NUMBER REFERENCES MEDICI(id_pers),
    id_medicament NUMBER REFERENCES MEDICAMENTE(id_medicament),
    id_pacient NUMBER REFERENCES PACIENTI(id_pacient),
    data_emiterii DATE,
    PRIMARY KEY (id_pers, id_pacient, id_medicament)
);

CREATE TABLE CAS (
    id_cas NUMBER PRIMARY KEY ,
    judet VARCHAR2(50)
);

CREATE TABLE ASIG_MED (
    id_asig_med NUMBER PRIMARY KEY ,
    id_cas NUMBER REFERENCES CAS(id_cas),
    id_pacient NUMBER REFERENCES PACIENTI(id_pacient),
    data_emiterii DATE
);

CREATE TABLE DIAGNOSTICE (
    id_diagnostic NUMBER PRIMARY KEY ,
    nume VARCHAR2(100),
    tip VARCHAR2(50)
);

CREATE TABLE PACIENTI_DIAGNOSTICE (
    id_pacient NUMBER REFERENCES PACIENTI(id_pacient),
    id_diagnostic NUMBER REFERENCES DIAGNOSTICE(id_diagnostic),
    PRIMARY KEY (id_pacient, id_diagnostic)
);



---5




INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica Sf. Maria', '0212345678', 'contact@sfmaria.ro', '0212345679');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica Nova Med', '0312345678', 'contact@novamed.ro', '0312345679');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica de Urgenta Bucuresti', '0219876543', 'urgenta@buc.ro', '0219876544');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica Alina', '0231122333', 'alina@clinica.ro', '0231122334');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica Floreasca', '0215639876', 'floreasca@med.ro', '0215639877');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica MedLife', '0212223333', 'medlife@med.ro', '0212223334');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica Colentina', '0214326543', 'colentina@col.ro', '0214326544');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica Dr. Ioan', '0317778888', 'ioan@clinicadr.ro', '0317778889');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica Dr. Radulescu', '0215656789', 'rad@gmail.com', '0215656790');
INSERT INTO CLINICI (id_clinica, nume_sediu, nr_tel, email, fax)
VALUES (seq_clinici.NEXTVAL, 'Clinica Sante', '0264567890', 'sante@gmail.com', '0264567891');






INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 1, '1960220112345', 'Popescu', 'Ion', 45, TO_DATE('2010-06-15', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 2, '1980420356789', 'Ionescu', 'Maria', 38, TO_DATE('2015-08-20', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 3, '1975122154321', 'Georgescu', 'Vasile', 50, TO_DATE('2012-01-10', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 4, '1988010785432', 'Radu', 'Elena', 35, TO_DATE('2017-03-25', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 5, '1992010754321', 'Vlad', 'Gabriel', 33, TO_DATE('2020-04-10', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 6, '1987022554321', 'Mihaila', 'Alexandra', 41, TO_DATE('2013-12-19', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 7, '1978092143210', 'Stefan', 'Mihai', 48, TO_DATE('2010-04-15', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 8, '1986112487654', 'Luca', 'Sorina', 38, TO_DATE('2014-02-10', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 9, '1994042243210', 'Popa', 'Daciana', 30, TO_DATE('2019-05-22', 'YYYY-MM-DD'));
INSERT INTO MANAGERI (id_manager, id_clinica, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_manageri.NEXTVAL, 10, '1987091265432', 'Vasile', 'Ion', 42, TO_DATE('2012-10-02', 'YYYY-MM-DD'));



INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO1234567890', '0219876543', 'contact@firmasec.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO9876543210', '0216549876', 'contact@firmasec2.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO1928374650', '0312345678', 'contact@firmasec3.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO5647382910', '0345678901', 'contact@firmasec4.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO6574839201', '0212345678', 'contact@firmasec5.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO3434343434', '0217778899', 'contact@firmasec6.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO4567890987', '0218765432', 'contact@firmasec7.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO6345432100', '0312112233', 'contact@firmasec8.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO7628420531', '0213433434', 'contact@firmasec9.ro');
INSERT INTO FIRME_SEC (id_firma_sec, cui, nr_tel, email)
VALUES (seq_firme_sec.NEXTVAL, 'RO3245678765', '0212349999', 'contact@firmasec10.ro');




INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO123456789', '0212345678', 'contact@firma1curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO987654321', '0212345679', 'contact@firma2curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO112233445', '0212345680', 'contact@firma3curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO223344556', '0212345681', 'contact@firma4curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO556677889', '0212345682', 'contact@firma5curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO998877665', '0212345683', 'contact@firma6curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO112233667', '0212345684', 'contact@firma7curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO667788990', '0212345685', 'contact@firma8curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO123987654', '0212345686', 'contact@firma9curat.ro');
INSERT INTO FIRME_CURAT (id_firma_curat, cui, nr_tel, email)
VALUES (seq_firme_curat.NEXTVAL, 'RO987123456', '0212345687', 'contact@firma10curat.ro');




INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 1, '2920312345678', 'Ionescu', 'Mihai', 35, TO_DATE('2015-05-12', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 2, '1930212345678', 'Popescu', 'Ion', 40, TO_DATE('2016-08-09', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 3, '2920412345678', 'Dumitrache', 'Andreea', 28, TO_DATE('2017-03-22', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 4, '1930612345678', 'Georgescu', 'Cosmin', 50, TO_DATE('2018-06-18', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 5, '2920512345678', 'Vasilescu', 'Elena', 36, TO_DATE('2019-11-25', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 6, '1930812345678', 'Radu', 'Alexandra', 32, TO_DATE('2020-02-10', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 7, '2920612345678', 'Iliescu', 'Gheorghe', 47, TO_DATE('2017-07-30', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 8, '1930912345678', 'Marinescu', 'Cristina', 31, TO_DATE('2016-04-13', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 9, '2920712345678', 'Stan', 'Florin', 38, TO_DATE('2018-01-20', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 10, '1931012345678', 'Constantinescu', 'Mihail', 45, TO_DATE('2019-09-15', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 2, '2920812345678', 'Neagu', 'Ion', 28, TO_DATE('2016-11-22', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_SEC (id_ang_sec, id_firma_sec, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_sec.NEXTVAL, 2, '1931112345678', 'Chiriac', 'Adriana', 41, TO_DATE('2017-07-04', 'YYYY-MM-DD'));




INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 1, '2921212345678', 'Luca', 'Daniela', 30, TO_DATE('2016-07-14', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 2, '1931312345678', 'Mihaila', 'Ion', 45, TO_DATE('2017-08-20', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 3, '2921312345678', 'Pavel', 'Vasile', 29, TO_DATE('2015-03-10', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 4, '1931412345678', 'Chiriac', 'Adriana', 38, TO_DATE('2018-05-25', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 5, '2921412345678', 'Gheorghiu', 'Marius', 32, TO_DATE('2019-02-18', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 6, '1931512345678', 'Rusu', 'Oana', 40, TO_DATE('2016-11-12', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 7, '2921512345678', 'Stoica', 'Doru', 36, TO_DATE('2017-09-21', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 8, '1931612345678', 'Dragomir', 'Florin', 41, TO_DATE('2018-03-03', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 9, '2921612345678', 'Costache', 'Maria', 27, TO_DATE('2019-06-28', 'YYYY-MM-DD'));
INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (seq_angajati_curat.NEXTVAL, 10, '1931712345678', 'Popa', 'Lucian', 34, TO_DATE('2020-01-15', 'YYYY-MM-DD'));



INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (1, 1);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (2, 2);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (3, 3);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (4, 4);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (5, 5);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (6, 6);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (7, 7);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (8, 8);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (9, 9);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (10, 10);
INSERT INTO PAZA (id_clinica, id_ang_sec) VALUES (1, 11);





INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (1, 1);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (2, 2);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (3, 3);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (4, 4);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (5, 5);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (6, 6);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (7, 7);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (8, 8);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (9, 9);
INSERT INTO CURAT (id_clinica, id_ang_curat) VALUES (10, 10);





INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '1234567890123', 'Popescu', 'Maria', 35, TO_DATE('2020-01-15', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '2345678901234', 'Ionescu', 'Ion', 28, TO_DATE('2019-05-20', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '3456789012345', 'Stan', 'Elena', 42, TO_DATE('2021-11-10', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '4567890123456', 'Popa', 'Mihai', 31, TO_DATE('2018-07-08', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '5678901234567', 'Dumitrescu', 'Ana', 40, TO_DATE('2022-03-25', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '6789012345678', 'Georgescu', 'Vasile', 36, TO_DATE('2017-09-12', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '7890123456789', 'Dragomir', 'Raluca', 29, TO_DATE('2023-08-05', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '8901234567890', 'Ivan', 'Andrei', 33, TO_DATE('2020-12-30', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '9012345678901', 'Gheorghe', 'Simona', 37, TO_DATE('2019-04-18', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '0123456789012', 'Stoica', 'Alexandru', 45, TO_DATE('2016-10-22', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '1122334455667', 'Constantinescu', 'Mihai', 38, TO_DATE('2020-09-15', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '2233445566778', 'Radulescu', 'Laura', 29, TO_DATE('2018-08-20', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '3344556677889', 'Vasilescu', 'Dan', 41, TO_DATE('2021-06-10', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '4455667788990', 'Iacob', 'Cristina', 30, TO_DATE('2019-04-25', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '5566778899001', 'Dinu', 'Alexandra', 39, TO_DATE('2022-03-12', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '6677889900112', 'Barbu', 'Stefan', 35, TO_DATE('2017-11-18', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '7788990011223', 'Dragomirescu', 'Ana', 28, TO_DATE('2023-10-05', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '8899001122334', 'Ionescu', 'Gabriel', 33, TO_DATE('2020-12-30', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '9900112233445', 'Marinescu', 'Andreea', 37, TO_DATE('2019-02-18', 'YYYY-MM-DD'));

INSERT INTO PERSONAL_MED (id_pers, cnp, nume, prenume, varsta, data_angajarii) 
VALUES (seq_personal_med.NEXTVAL, '0111223344556', 'Neacsu', 'Marian', 44, TO_DATE('2016-10-22', 'YYYY-MM-DD'));





INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (1, 'Cardiologie', 'Primar');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (2, 'Cardiologie', 'Specialist');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (3, 'Chirurgie', 'Primar');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (4, 'Pediatrie', 'Specialist');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (5, 'Ortopedie', 'Primar');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (6, 'Oftalmologie', 'Specialist');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (7, 'Dermatologie', 'Primar');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (8, 'Endocrinologie', 'Specialist');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (9, 'Dermatologie', 'Primar');

INSERT INTO MEDICI (id_pers, specializare, grad_profesional)
VALUES (10, 'Psihiatrie', 'Specialist');



INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (11, 'Preuniversitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (12, 'Preuniversitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (13, 'Universitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (14, 'Universitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (15, 'Postuniversitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (16, 'Postuniversitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (17, 'Postuniversitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (18, 'Preuniversitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (19, 'Universitar');

INSERT INTO ASISTENTI_MED (id_pers, nivel_studii)
VALUES (20, 'Postuniversitar');






INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (1, 1, 'Numar1'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (2, 2, 'Numar2'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (3, 3, 'Numar3'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (4, 4, 'Numar4'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (5, 5, 'Numar5'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (6, 6, 'Numar6'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (7, 7, 'Numar7'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (1, 8, 'Numar8'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (2, 9, 'Numar9'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (3, 10, 'Numar10'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (4, 11, 'Numar11'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (5, 12, 'Numar12'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (6, 13, 'Numar13'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (7, 14, 'Numar14'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (1, 15, 'Numar15'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (2, 16, 'Numar16'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (3, 17, 'Numar17'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (4, 18, 'Numar18'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (5, 19, 'Numar19'); 

INSERT INTO LUCRU (id_clinica, id_pers,nr_contract_lucru) VALUES (6, 20, 'Numar20'); 




INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Paracetamol', 250, TO_DATE('2024-12-31', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Ibuprofen', 230, TO_DATE('2023-07-15', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Aspirina', 145, TO_DATE('2025-05-20', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Amoxicilina', 360, TO_DATE('2023-11-30', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Omeprazol', 240, TO_DATE('2024-03-18', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Simvastatina', 175, TO_DATE('2026-08-25', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Diazepam', 234, TO_DATE('2024-09-10', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Ranitidina', 421, TO_DATE('2025-12-01', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Metformin', 167, TO_DATE('2023-10-05', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Doxazosina', 321, TO_DATE('2024-02-28', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Fluoxetina', 123, TO_DATE('2025-01-15', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Insulina', 321, TO_DATE('2026-03-22', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Atorvastatina', 202, TO_DATE('2024-11-13', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Captopril', 110, TO_DATE('2023-06-30', 'YYYY-MM-DD'));

INSERT INTO MEDICAMENTE (id_medicament, nume, stoc, data_expirarii) 
VALUES (SEQ_MEDICAMENTE.NEXTVAL, 'Losartan', 123, TO_DATE('2024-07-19', 'YYYY-MM-DD'));



INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1960101123456', 'Enache', 'Marius', 28);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '2750309123456', 'Dima', 'Ioana', 45);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1980805123456', 'Mihailescu', 'Gabriel', 33);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1990203123456', 'Radu', 'Cristina', 32);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1980506123456', 'Tudor', 'Alexandru', 36);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1980123123456', 'Lazar', 'Mirela', 44);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1970625123456', 'Florea', 'Ovidiu', 39);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1960707123456', 'Marin', 'Simona', 57);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1961101123456', 'Diaconu', 'Ionel', 52);

INSERT INTO PACIENTI (id_pacient, cnp, nume, prenume, varsta) 
VALUES (SEQ_PACIENTI.NEXTVAL, '1981201123456', 'Antonescu', 'Daniela', 31);



INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (1, 2, 5, TO_DATE('2024-01-15', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (2, 4, 7, TO_DATE('2023-07-22', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (3, 1, 3, TO_DATE('2024-03-18', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (4, 7, 2, TO_DATE('2023-12-10', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (5, 6, 9, TO_DATE('2023-08-15', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (6, 10, 6, TO_DATE('2024-02-22', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (7, 5, 8, TO_DATE('2024-04-10', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (8, 9, 4, TO_DATE('2023-09-30', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (9, 2, 10, TO_DATE('2023-11-15', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (10, 3, 1, TO_DATE('2024-01-05', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (1, 8, 3, TO_DATE('2024-03-12', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (2, 1, 4, TO_DATE('2023-10-02', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (3, 5, 6, TO_DATE('2024-02-18', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (4, 6, 7, TO_DATE('2023-11-20', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (5, 4, 2, TO_DATE('2023-09-10', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (6, 3, 9, TO_DATE('2024-03-01', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (7, 9, 8, TO_DATE('2024-04-05', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (8, 10, 5, TO_DATE('2024-01-25', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (9, 7, 3, TO_DATE('2024-02-10', 'YYYY-MM-DD'));

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii) 
VALUES (10, 2, 4, TO_DATE('2023-11-01', 'YYYY-MM-DD'));

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Bucuresti');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Cluj');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Iasi');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Timis');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Constanta');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Brasov');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Dolj');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Prahova');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Suceava');

INSERT INTO CAS (id_cas, judet) 
VALUES (seq_cas.NEXTVAL, 'Bacau');

INSERT INTO ASIG_MED (id_asig_med, id_cas, id_pacient, data_emiterii) 
VALUES (seq_asig_med.NEXTVAL, 1, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'));

INSERT INTO ASIG_MED (id_asig_med, id_cas, id_pacient, data_emiterii) 
VALUES (seq_asig_med.NEXTVAL, 2, 2, TO_DATE('2024-02-15', 'YYYY-MM-DD'));

INSERT INTO ASIG_MED (id_asig_med, id_cas, id_pacient, data_emiterii) 
VALUES (seq_asig_med.NEXTVAL, 3, 3, TO_DATE('2024-03-20', 'YYYY-MM-DD'));

INSERT INTO ASIG_MED (id_asig_med, id_cas, id_pacient, data_emiterii) 
VALUES (seq_asig_med.NEXTVAL, 4, 4, TO_DATE('2024-04-05', 'YYYY-MM-DD'));

INSERT INTO ASIG_MED (id_asig_med, id_cas, id_pacient, data_emiterii) 
VALUES (seq_asig_med.NEXTVAL, 5, 5, TO_DATE('2024-04-25', 'YYYY-MM-DD'));

INSERT INTO ASIG_MED (id_asig_med, id_cas, id_pacient, data_emiterii) 
VALUES (seq_asig_med.NEXTVAL, 6, 6, TO_DATE('2024-05-10', 'YYYY-MM-DD'));

INSERT INTO ASIG_MED (id_asig_med, id_cas, id_pacient, data_emiterii) 
VALUES (seq_asig_med.NEXTVAL, 7, 7, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

INSERT INTO ASIG_MED (id_asig_med, id_cas, id_pacient, data_emiterii) 
VALUES (seq_asig_med.NEXTVAL, 1, 8, TO_DATE('2024-05-20', 'YYYY-MM-DD'));



INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Hipertensiune', 'CRONIC');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Gripa', 'ACUT');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Diabet', 'CRONIC');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Anemie', 'ACUT');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Pneumonie', 'ACUT');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Astm', 'CRONIC');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Artrita', 'CRONIC');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Cistita', 'ACUT');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Migrena', 'ACUT');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Depresie', 'CRONIC');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Ulcer', 'CRONIC');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Angina', 'ACUT');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Osteoporoza', 'CRONIC');

INSERT INTO DIAGNOSTICE (id_diagnostic, nume, tip) 
VALUES (seq_diagnostice.NEXTVAL, 'Gastrita', 'CRONIC');



INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (1, 3);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (2, 5);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (3, 8);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (4, 1);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (5, 4);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (6, 7);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (7, 9);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (8, 2);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (9, 6);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (10, 3);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (1, 7);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (2, 10);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (3, 4);

INSERT INTO PACIENTI_DIAGNOSTICE (id_pacient, id_diagnostic)
VALUES (4, 6);




---6

CREATE OR REPLACE PROCEDURE actualizeaza_stoc_medicamente (
    medicamente_input IN lista_nr,
    cantitati_input   IN lista_nr
) IS
    -- Tabel indexat pentru stocuri
    TYPE tab_ind IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_stocuri tab_ind;

    -- Set de ID-uri deja procesate
    TYPE set_ids IS TABLE OF BOOLEAN INDEX BY PLS_INTEGER;
    v_procesate set_ids;

    -- Vector pentru medicamente actualizate
    TYPE tab_vec IS VARRAY(100) OF VARCHAR2(100);
    v_nume_medicamente tab_vec := tab_vec();

    -- Tablou imbricat pentru cele cu stoc insuficient
    TYPE tab_imbricat IS TABLE OF VARCHAR2(100);
    v_medicamente_indisp tab_imbricat := tab_imbricat();

    v_nume_medicament VARCHAR2(100);
BEGIN
    IF medicamente_input.COUNT != cantitati_input.COUNT THEN
        RAISE_APPLICATION_ERROR(-20001, 'Listele de ID-uri si cantitati au dimensiuni diferite');
    END IF;

    FOR i IN 1 .. medicamente_input.COUNT LOOP
        IF NOT v_procesate.EXISTS(medicamente_input(i)) THEN
            v_procesate(medicamente_input(i)) := TRUE;

            BEGIN
                SELECT nume, stoc
                INTO v_nume_medicament, v_stocuri(i)
                FROM MEDICAMENTE
                WHERE id_medicament = medicamente_input(i);

                IF v_stocuri(i) >= cantitati_input(i) THEN
                    UPDATE MEDICAMENTE
                    SET stoc = stoc - cantitati_input(i)
                    WHERE id_medicament = medicamente_input(i);

                    v_nume_medicamente.EXTEND;
                    v_nume_medicamente(v_nume_medicamente.COUNT) := v_nume_medicament;

                    DBMS_OUTPUT.PUT_LINE('ACTUALIZAT: ' || v_nume_medicament);
                ELSE
                    v_medicamente_indisp.EXTEND;
                    v_medicamente_indisp(v_medicamente_indisp.COUNT) := v_nume_medicament;

                    DBMS_OUTPUT.PUT_LINE('STOC INSUFICIENT: ' || v_nume_medicament);
                END IF;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    v_medicamente_indisp.EXTEND;
                    v_medicamente_indisp(v_medicamente_indisp.COUNT) := 'ID INEXISTENT: ' || medicamente_input(i);
                    DBMS_OUTPUT.PUT_LINE('EROARE: Medicament inexistent cu ID ' || medicamente_input(i));
            END;

        ELSE
            DBMS_OUTPUT.PUT_LINE('IGNORAT: ID duplicat ' || medicamente_input(i));
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- MEDICAMENTE ACTUALIZATE ---');
    FOR i IN 1 .. v_nume_medicamente.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_nume_medicamente(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- MEDICAMENTE NEACTUALIZATE ---');
    FOR i IN 1 .. v_medicamente_indisp.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_medicamente_indisp(i));
    END LOOP;
END;
/


BEGIN
    actualizeaza_stoc_medicamente(
        lista_nr(1, 2, 1, 3,1,22),
        lista_nr(10, 20, 30, 40,10,1)
    );
END;


select * from medicamente;


--7

CREATE OR REPLACE PROCEDURE raport_medici_peste_prag (
    p_data_start IN DATE,
    p_data_end   IN DATE,
    p_prag_presc IN NUMBER
) IS
    TYPE tab_idx_numar IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_nr_prescr_per_medic tab_idx_numar;

    TYPE varray_pacienti IS VARRAY(100) OF VARCHAR2(100);
    v_lista_pacienti varray_pacienti := varray_pacienti();

    CURSOR c_clinici IS
        SELECT id_clinica, nume_sediu, email FROM CLINICI;

    CURSOR c_medici(p_id_clinica NUMBER, p_start DATE, p_end DATE, p_prag NUMBER) IS
        SELECT m.id_pers, pm.nume, pm.prenume, m.specializare, COUNT(pr.id_medicament) AS nr_prescr
        FROM MEDICI m
        JOIN PERSONAL_MED pm ON m.id_pers = pm.id_pers
        JOIN LUCRU l ON l.id_pers = m.id_pers
        JOIN PRESCRIPTII pr ON pr.id_pers = m.id_pers
        WHERE l.id_clinica = p_id_clinica
          AND pr.data_emiterii BETWEEN p_start AND p_end
        GROUP BY m.id_pers, pm.nume, pm.prenume, m.specializare
        HAVING COUNT(pr.id_medicament) > p_prag
        ORDER BY nr_prescr DESC;

    CURSOR c_pacienti(p_id_med NUMBER, p_start DATE, p_end DATE) IS
        SELECT DISTINCT pa.nume || ' ' || pa.prenume AS nume_complet
        FROM PACIENTI pa
        JOIN PRESCRIPTII pr ON pr.id_pacient = pa.id_pacient
        WHERE pr.id_pers = p_id_med
          AND pr.data_emiterii BETWEEN p_start AND p_end
        ORDER BY nume_complet
        FETCH FIRST 3 ROWS ONLY;

BEGIN
    FOR clinica IN c_clinici LOOP
        DBMS_OUTPUT.PUT_LINE('Clinica: ' || clinica.nume_sediu || ' | Email: ' || clinica.email);
        DBMS_OUTPUT.PUT_LINE('Medici cu prescriptii peste pragul ' || p_prag_presc || ':');

        DECLARE
            idx_medici PLS_INTEGER := 0;
        BEGIN
            FOR medic IN c_medici(clinica.id_clinica, p_data_start, p_data_end, p_prag_presc) LOOP
                idx_medici := idx_medici + 1;
                v_nr_prescr_per_medic(idx_medici) := medic.nr_prescr;

                DBMS_OUTPUT.PUT_LINE('  Medic: ' || medic.nume || ' ' || medic.prenume ||
                                     ' (' || medic.specializare || ') - Prescriptii: ' || medic.nr_prescr);

                v_lista_pacienti := varray_pacienti(); 

                FOR pacient IN c_pacienti(medic.id_pers, p_data_start, p_data_end) LOOP
                    IF v_lista_pacienti.COUNT < 100 THEN
                        v_lista_pacienti.EXTEND;
                        v_lista_pacienti(v_lista_pacienti.COUNT) := pacient.nume_complet;
                    END IF;
                END LOOP;

                IF v_lista_pacienti.COUNT = 0 THEN
                    DBMS_OUTPUT.PUT_LINE('    Niciun pacient asociat in interval.');
                ELSE
                    DBMS_OUTPUT.PUT_LINE('    Primii 3 pacienti :');
                    FOR i IN 1 .. v_lista_pacienti.COUNT LOOP
                        DBMS_OUTPUT.PUT_LINE('      - ' || v_lista_pacienti(i));
                    END LOOP;
                END IF;

                DBMS_OUTPUT.PUT_LINE('');
            END LOOP;

            IF idx_medici = 0 THEN
                DBMS_OUTPUT.PUT_LINE('  Niciun medic nu a depasit pragul de prescriptii.');
            END IF;
        END;

        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    END LOOP;
END;
/



----


CREATE OR REPLACE PROCEDURE raport_medici_peste_prag (
    p_data_start IN DATE,
    p_data_end   IN DATE,
    p_prag_presc IN NUMBER
) IS
    TYPE tab_idx_numar IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_nr_prescr_per_medic tab_idx_numar;

    TYPE varray_pacienti IS VARRAY(3) OF VARCHAR2(100);
    v_lista_pacienti varray_pacienti := varray_pacienti();

    CURSOR c_clinici IS
        SELECT id_clinica, nume_sediu, email FROM CLINICI;

    CURSOR c_medici(p_id_clinica NUMBER, p_start DATE, p_end DATE, p_prag NUMBER) IS
        SELECT m.id_pers, pm.nume, pm.prenume, m.specializare, COUNT(pr.id_medicament) AS nr_prescr
        FROM MEDICI m
        JOIN PERSONAL_MED pm ON m.id_pers = pm.id_pers
        JOIN LUCRU l ON l.id_pers = m.id_pers
        JOIN PRESCRIPTII pr ON pr.id_pers = m.id_pers
        WHERE l.id_clinica = p_id_clinica
          AND pr.data_emiterii BETWEEN p_start AND p_end
        GROUP BY m.id_pers, pm.nume, pm.prenume, m.specializare
        HAVING COUNT(pr.id_medicament) > p_prag
        ORDER BY nr_prescr DESC;

    CURSOR c_pacienti(p_id_med NUMBER, p_start DATE, p_end DATE) IS
        SELECT DISTINCT pa.nume || ' ' || pa.prenume AS nume_complet
        FROM PACIENTI pa
        JOIN PRESCRIPTII pr ON pr.id_pacient = pa.id_pacient
        WHERE pr.id_pers = p_id_med
          AND pr.data_emiterii BETWEEN p_start AND p_end
        ORDER BY nume_complet;

    v_total_pacienti INTEGER := 0;

BEGIN
    FOR clinica IN c_clinici LOOP
        DBMS_OUTPUT.PUT_LINE('Clinica: ' || clinica.nume_sediu || ' | Email: ' || clinica.email);
        DBMS_OUTPUT.PUT_LINE('Medici cu prescriptii peste pragul ' || p_prag_presc || ':');

        DECLARE
            idx_medici PLS_INTEGER := 0;
        BEGIN
            FOR medic IN c_medici(clinica.id_clinica, p_data_start, p_data_end, p_prag_presc) LOOP
                idx_medici := idx_medici + 1;
                v_nr_prescr_per_medic(idx_medici) := medic.nr_prescr;

                DBMS_OUTPUT.PUT_LINE('  Medic: ' || medic.nume || ' ' || medic.prenume ||
                                     ' (' || medic.specializare || ') - Prescriptii: ' || medic.nr_prescr);

                v_lista_pacienti := varray_pacienti();
                v_total_pacienti := 0;

                FOR pacient IN c_pacienti(medic.id_pers, p_data_start, p_data_end) LOOP
                    v_total_pacienti := v_total_pacienti + 1;
                    IF v_lista_pacienti.COUNT < 3 THEN
                        v_lista_pacienti.EXTEND;
                        v_lista_pacienti(v_lista_pacienti.COUNT) := pacient.nume_complet;
                    END IF;
                END LOOP;

                IF v_total_pacienti =0 THEN
                    DBMS_OUTPUT.PUT_LINE('    Niciun pacient asociat in interval.');
                ELSE
                    DBMS_OUTPUT.PUT_LINE('Primii 3 pacienti :');
                    FOR i IN 1 .. v_lista_pacienti.COUNT LOOP
                        DBMS_OUTPUT.PUT_LINE('      - ' || v_lista_pacienti(i));
                    END LOOP;
                    IF v_total_pacienti>3 THEN
                        DBMS_OUTPUT.PUT_LINE('Prea muuulti');
                    END IF;
                END IF;

                DBMS_OUTPUT.PUT_LINE('');
            END LOOP;

            IF idx_medici = 0 THEN
                DBMS_OUTPUT.PUT_LINE('  Niciun medic nu a depasit pragul de prescriptii.');
            END IF;
        END;

        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    END LOOP;
END;
/





CREATE OR REPLACE PROCEDURE raport_medici_peste_prag (
    p_data_start IN DATE,
    p_data_end   IN DATE,
    p_prag_presc IN NUMBER
) IS
    TYPE tab_idx_numar IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_nr_prescr_per_medic tab_idx_numar;

    TYPE tab_imbricat_pacienti IS TABLE OF VARCHAR2(100);
    v_lista_pacienti tab_imbricat_pacienti;

    CURSOR c_clinici IS
        SELECT id_clinica, nume_sediu, email FROM CLINICI;

    CURSOR c_medici(p_id_clinica NUMBER, p_start DATE, p_end DATE, p_prag NUMBER) IS
        SELECT m.id_pers, pm.nume, pm.prenume, m.specializare, COUNT(pr.id_medicament) AS nr_prescr
        FROM MEDICI m
        JOIN PERSONAL_MED pm ON m.id_pers = pm.id_pers
        JOIN LUCRU l ON l.id_pers = m.id_pers
        JOIN PRESCRIPTII pr ON pr.id_pers = m.id_pers
        WHERE l.id_clinica = p_id_clinica
          AND pr.data_emiterii BETWEEN p_start AND p_end
        GROUP BY m.id_pers, pm.nume, pm.prenume, m.specializare
        HAVING COUNT(pr.id_medicament) > p_prag
        ORDER BY nr_prescr DESC;

    CURSOR c_pacienti(p_id_med NUMBER, p_start DATE, p_end DATE) IS
        SELECT DISTINCT pa.nume || ' ' || pa.prenume AS nume_complet
        FROM PACIENTI pa
        JOIN PRESCRIPTII pr ON pr.id_pacient = pa.id_pacient
        WHERE pr.id_pers = p_id_med
          AND pr.data_emiterii BETWEEN p_start AND p_end;

    v_clinica c_clinici%ROWTYPE;

BEGIN
    OPEN c_clinici;
    LOOP
        FETCH c_clinici INTO v_clinica;
        EXIT WHEN c_clinici%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Clinica: ' || v_clinica.nume_sediu || ' | Email: ' || v_clinica.email);
        DBMS_OUTPUT.PUT_LINE('Medici cu prescriptii peste pragul ' || p_prag_presc || ':');

        DECLARE
            idx_medici PLS_INTEGER := 0;
        BEGIN
            FOR medic IN c_medici(v_clinica.id_clinica, p_data_start, p_data_end, p_prag_presc) LOOP
                idx_medici := idx_medici + 1;
                v_nr_prescr_per_medic(idx_medici) := medic.nr_prescr;

                DBMS_OUTPUT.PUT_LINE('  Medic: ' || medic.nume || ' ' || medic.prenume ||
                                     ' (' || medic.specializare || ') - Prescriptii: ' || medic.nr_prescr);

                v_lista_pacienti := tab_imbricat_pacienti();
                FOR pacient IN c_pacienti(medic.id_pers, p_data_start, p_data_end) LOOP
                    v_lista_pacienti.EXTEND;
                    v_lista_pacienti(v_lista_pacienti.COUNT) := pacient.nume_complet;
                END LOOP;

                IF v_lista_pacienti.COUNT = 0 THEN
                    DBMS_OUTPUT.PUT_LINE('    Niciun pacient asociat in interval.');
                ELSE
                    DBMS_OUTPUT.PUT_LINE('    Pacienti:');
                    FOR i IN 1 .. v_lista_pacienti.COUNT LOOP
                        DBMS_OUTPUT.PUT_LINE('      - ' || v_lista_pacienti(i));
                    END LOOP;
                END IF;

                DBMS_OUTPUT.PUT_LINE('');
            END LOOP;

            IF idx_medici = 0 THEN
                DBMS_OUTPUT.PUT_LINE('  Niciun medic nu a depasit pragul de prescriptii.');
            END IF;
        END;

        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    END LOOP;
    CLOSE c_clinici;
END;
/





BEGIN
    raport_medici_peste_prag(
        TO_DATE('2024-01-01', 'YYYY-MM-DD'),
        TO_DATE('2024-12-31', 'YYYY-MM-DD'),
        1
    );
END;
/




---8


CREATE OR REPLACE TYPE t_pacienti_tineri AS TABLE OF VARCHAR2(255);
/

CREATE OR REPLACE FUNCTION pacienti_tineri_asigurati(p_limita_varsta NUMBER)
RETURN t_pacienti_tineri
IS
    v_rezultate t_pacienti_tineri := t_pacienti_tineri();
    v_nume_pacient VARCHAR2(10);
    exceptie_varsta_negativa EXCEPTION;
    exceptie_varsta_null EXCEPTION;

BEGIN
    IF p_limita_varsta IS NULL THEN
        RAISE exceptie_varsta_null;
    END IF;

    IF p_limita_varsta < 0 THEN
        RAISE exceptie_varsta_negativa;
    END IF;
    SELECT nume
    into v_nume_pacient
    from pacienti;
    SELECT 'Pacient: ' || p.nume || ' ' || p.prenume ||
           ' | Varsta: ' || p.varsta ||
           ' | ID Asigurare: ' || a.id_asig_med ||
           ' | CAS (judet): ' || c.judet
    BULK COLLECT INTO v_rezultate
    
    
    FROM PACIENTI p
    JOIN ASIG_MED a ON p.id_pacient = a.id_pacient
    JOIN CAS c ON a.id_cas = c.id_cas
    WHERE p.varsta < (
        SELECT AVG(p2.varsta)
        FROM ASIG_MED a2
        JOIN PACIENTI p2 ON a2.id_pacient = p2.id_pacient
        WHERE a2.id_cas = a.id_cas
        GROUP BY a2.id_cas
        HAVING COUNT(*) > 1
    )
    AND p.varsta < p_limita_varsta
    ORDER BY p.varsta ASC;

    IF v_rezultate.COUNT = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

    RETURN v_rezultate;

EXCEPTION
    WHEN exceptie_varsta_null THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Parametrul varstei nu poate fi NULL.');
        RETURN t_pacienti_tineri();

    WHEN exceptie_varsta_negativa THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Varsta introdusa trebuie sa fie pozitiva.');
        RETURN t_pacienti_tineri();

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista pacienti tineri care sa indeplineasca conditiile.');
        RETURN t_pacienti_tineri();

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Interogarea a returnat prea multe randuri.');
        RETURN t_pacienti_tineri();

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare neasteptata: ' || SQLERRM);
        RETURN t_pacienti_tineri();
END pacienti_tineri_asigurati;
/

DECLARE
    v_rezultate t_pacienti_tineri;
BEGIN
    v_rezultate := pacienti_tineri_asigurati(30);

    FOR i IN 1 .. v_rezultate.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_rezultate(i));
    END LOOP;
END;
/





----9
CREATE OR REPLACE PROCEDURE pacienti_diagnosticati_asigurati(
    p_tip_diagnostic IN VARCHAR2,
    p_judet_cas IN VARCHAR2
)
IS
    ex_tip_null EXCEPTION;
    ex_tip_inexistent EXCEPTION;
    ex_judet_invalid EXCEPTION;

    v_count NUMBER := 0;
    v_judet_exists NUMBER := 0;

BEGIN
    IF p_tip_diagnostic IS NULL THEN
        RAISE ex_tip_null;
    END IF;

    SELECT COUNT(*) INTO v_count
    FROM DIAGNOSTICE
    WHERE LOWER(tip) = LOWER(p_tip_diagnostic);

    IF v_count = 0 THEN
        RAISE ex_tip_inexistent;
    END IF;

    SELECT COUNT(*) INTO v_judet_exists
    FROM CAS
    WHERE LOWER(judet) = LOWER(p_judet_cas);
--fara lower
    IF v_judet_exists = 0 THEN
        RAISE ex_judet_invalid;
    END IF;

    v_count := 0;

    FOR rec IN (
        SELECT p.nume || ' ' || p.prenume AS nume_pacient,
               p.varsta,
               c.judet,
               d.nume AS diagnostic
        FROM PACIENTI p
        JOIN ASIG_MED am ON p.id_pacient = am.id_pacient
        JOIN CAS c ON am.id_cas = c.id_cas
        JOIN PACIENTI_DIAGNOSTICE pd ON p.id_pacient = pd.id_pacient
        JOIN DIAGNOSTICE d ON pd.id_diagnostic = d.id_diagnostic
        WHERE LOWER(d.tip) = LOWER(p_tip_diagnostic)
          AND LOWER(c.judet) = LOWER(p_judet_cas)
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Pacient: ' || rec.nume_pacient || 
                             ' | Varsta: ' || rec.varsta ||
                             ' | Diagnostic: ' || rec.diagnostic || 
                             ' | Judet CAS: ' || rec.judet);
        v_count := v_count + 1;
    END LOOP;

    IF v_count = 0 THEN
        RAISE NO_DATA_FOUND;
    END IF;

EXCEPTION
    WHEN ex_tip_null THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Tipul de diagnostic nu poate fi NULL.');

    WHEN ex_tip_inexistent THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Tipul de diagnostic nu exista in sistem.');

    WHEN ex_judet_invalid THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Judetul CAS introdus nu exista.');

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Nu exista pacienti care indeplinesc toate conditiile.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare neasteptata: ' || SQLERRM);
END;
/

BEGIN
    -- Caz valid
    pacienti_diagnosticati_asigurati('acut', 'Dolj');

    -- Caz tip diagnostic inexistent
    pacienti_diagnosticati_asigurati('avansat', 'Cluj');

    -- Caz judet inexistent
    pacienti_diagnosticati_asigurati('cronic', 'Algeria');

    -- Caz fara rezultate (tip diagnostic exista, judet exista, dar nu exista pacient corespunzator)
    pacienti_diagnosticati_asigurati('cronic', 'Dolj');

    -- Caz NULL
    pacienti_diagnosticati_asigurati(NULL, 'Cluj');
END;
/




----10
-- Trigger pentru tabela PERSONAL_MED
CREATE OR REPLACE TRIGGER trg_restrictii_personal_med
BEFORE INSERT OR UPDATE OR DELETE ON PERSONAL_MED
DECLARE
    v_ora NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    v_minut NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    v_zi VARCHAR2(10) := TRIM(TO_CHAR(SYSDATE, 'DAY'));
BEGIN
    IF v_zi IN ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY') AND
       ((v_ora = 7 AND v_minut BETWEEN 30 AND 59) OR
        (v_ora = 12 AND v_minut BETWEEN 0 AND 30)) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Operatiile sunt interzise in timpul mentenantei.');
    END IF;
    IF v_zi IN ('SATURDAY', 'SUNDAY') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Operatiile sunt interzise in weekend.');
    END IF;
END;
/

-- Trigger pentru tabela MEDICI
CREATE OR REPLACE TRIGGER trg_restrictii_medici
BEFORE INSERT OR UPDATE OR DELETE ON MEDICI
DECLARE
    v_ora NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    v_minut NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    v_zi VARCHAR2(10) := TRIM(TO_CHAR(SYSDATE, 'DAY'));
BEGIN
    IF v_zi IN ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY') AND
       ((v_ora = 7 AND v_minut BETWEEN 30 AND 59) OR
        (v_ora = 12 AND v_minut BETWEEN 0 AND 30)) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Operatiile sunt interzise in timpul mentenantei.');
    END IF;
    IF v_zi IN ('SATURDAY', 'SUNDAY') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Operatiile sunt interzise in weekend.');
    END IF;
END;
/

-- Trigger pentru tabela ASISTENTI_MED
CREATE OR REPLACE TRIGGER trg_restrictii_asistenti_med
BEFORE INSERT OR UPDATE OR DELETE ON ASISTENTI_MED
DECLARE
    v_ora NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    v_minut NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    v_zi VARCHAR2(10) := TRIM(TO_CHAR(SYSDATE, 'DAY'));
BEGIN
    IF v_zi IN ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY') AND
       ((v_ora = 7 AND v_minut BETWEEN 30 AND 59) OR
        (v_ora = 12 AND v_minut BETWEEN 0 AND 30)) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Operatiile sunt interzise in timpul mentenantei.');
    END IF;
    IF v_zi IN ('SATURDAY', 'SUNDAY') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Operatiile sunt interzise in weekend.');
    END IF;
END;
/

-- Trigger pentru tabela ANGAJATI_SEC
CREATE OR REPLACE TRIGGER trg_restrictii_angajati_sec
BEFORE INSERT OR UPDATE OR DELETE ON ANGAJATI_SEC
DECLARE
    v_ora NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    v_minut NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    v_zi VARCHAR2(10) := TRIM(TO_CHAR(SYSDATE, 'DAY'));
BEGIN
    IF v_zi IN ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY') AND
       ((v_ora = 7 AND v_minut BETWEEN 30 AND 59) OR
        (v_ora = 12 AND v_minut BETWEEN 0 AND 30)) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Operatiile sunt interzise in timpul mentenantei.');
    END IF;
    IF v_zi IN ('SATURDAY', 'SUNDAY') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Operatiile sunt interzise in weekend.');
    END IF;
END;
/

-- Trigger pentru tabela ANGAJATI_CURAT
CREATE OR REPLACE TRIGGER trg_restrictii_angajati_curat
BEFORE INSERT OR UPDATE OR DELETE ON ANGAJATI_CURAT
DECLARE
    v_ora NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24'));
    v_minut NUMBER := TO_NUMBER(TO_CHAR(SYSDATE, 'MI'));
    v_zi VARCHAR2(10) := TRIM(TO_CHAR(SYSDATE, 'DAY'));
BEGIN
    IF v_zi IN ('MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY') AND
       ((v_ora = 7 AND v_minut BETWEEN 30 AND 59) OR
        (v_ora = 12 AND v_minut BETWEEN 0 AND 30)) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Operatiile sunt interzise in timpul mentenantei.');
    END IF;
    IF v_zi IN ('SATURDAY', 'SUNDAY') THEN
        RAISE_APPLICATION_ERROR(-20004, 'Operatiile sunt interzise in weekend.');
    END IF;
END;
/




INSERT INTO ANGAJATI_CURAT (id_ang_curat, id_firma_curat, cnp, nume, prenume, varsta, data_angajarii)
VALUES (28, 1, '2921212345691', 'Andreescu', 'Daniela', 34, TO_DATE('2016-07-14', 'YYYY-MM-DD'));

select*from angajati_curat

---11



CREATE OR REPLACE PROCEDURE verifica_prescriptie(
    p_id_pers       NUMBER,
    p_id_medicament NUMBER,
    p_id_pacient    NUMBER,
    p_data_emiterii DATE
) IS
    v_stoc NUMBER;
    v_data_angajarii DATE;
    v_count_prescriptii NUMBER;
BEGIN
    -- Verific stocul medicamentului
    SELECT stoc INTO v_stoc FROM MEDICAMENTE WHERE id_medicament = p_id_medicament;
    IF v_stoc <= 0 THEN
        RAISE_APPLICATION_ERROR(-20020, 'Medicamentul cu ID-ul ' || p_id_medicament || ' nu este disponibil in stoc.');
    END IF;

    -- Verific data angajarii medicului
    SELECT data_angajarii INTO v_data_angajarii FROM PERSONAL_MED WHERE id_pers = p_id_pers;
    IF p_data_emiterii < v_data_angajarii THEN
        RAISE_APPLICATION_ERROR(-20021, 'Data emiterii nu poate fi anterioara datei angajarii medicului.');
    END IF;

    -- Verific daca pacientul are deja prescriptie activa pentru acelasi medicament in ultimele 30 zile
    SELECT COUNT(*) INTO v_count_prescriptii
    FROM PRESCRIPTII
    WHERE id_pacient = p_id_pacient
      AND id_medicament = p_id_medicament
      AND data_emiterii >= p_data_emiterii - 30;

    IF v_count_prescriptii > 0 THEN
        RAISE_APPLICATION_ERROR(-20022, 'Pacientul are deja o prescriptie activa pentru acest medicament in ultimele 30 de zile.');
    END IF;

END verifica_prescriptie;
/


CREATE OR REPLACE TRIGGER trg_verifica_prescriptie
BEFORE INSERT ON PRESCRIPTII
FOR EACH ROW
BEGIN
    verifica_prescriptie(:NEW.id_pers, :NEW.id_medicament, :NEW.id_pacient, :NEW.data_emiterii);
END;
/

--trebuie sa pot da insert din select

INSERT INTO PRESCRIPTII (id_pers, id_medicament, id_pacient, data_emiterii)
VALUES (1, 1, 1, TO_DATE('01-01-2020', 'DD-MM-YYYY'));



---12

CREATE TABLE audit_ldd (
    id NUMBER PRIMARY KEY,
    utilizator VARCHAR2(50) NOT NULL,
    nume_bd VARCHAR2(50) NOT NULL,
    eveniment VARCHAR2(10) NOT NULL,
    nume_obiect VARCHAR2(100) NOT NULL,
    data TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);
CREATE SEQUENCE seq_audit_ldd START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER trg_audit_ldd
AFTER DROP OR ALTER
ON SCHEMA
DECLARE
    v_eveniment VARCHAR2(10);
    v_nume_obiect VARCHAR2(100);
    v_utilizator VARCHAR2(50);
    v_nume_bd VARCHAR2(50);
    v_id NUMBER;
BEGIN
    v_eveniment := ora_sysevent;

    v_nume_obiect := ora_dict_obj_name;
    v_utilizator := SYS_CONTEXT('USERENV', 'SESSION_USER');--usernev namespace pt utilizator,sesiune,limba session_user-utiliz care a initiat sesiunea

    SELECT sys_context('userenv','db_name') INTO v_nume_bd FROM dual;

    SELECT seq_audit_ldd.NEXTVAL INTO v_id FROM dual;

    INSERT INTO audit_ldd(id, utilizator, nume_bd, eveniment, nume_obiect, data)
    VALUES (v_id, v_utilizator, v_nume_bd, v_eveniment, v_nume_obiect, SYSTIMESTAMP);
END;
/
ALTER TABLE clinici ADD (adresa VARCHAR2(200));

ALTER TABLE clinici DROP COLUMN adresa;
SELECT id, utilizator, nume_bd, eveniment, nume_obiect, data
FROM audit_ldd
ORDER BY id DESC;





----13

CREATE OR REPLACE PACKAGE pachet_spitale IS

  TYPE pacient_rec IS RECORD (
    cnp      VARCHAR2(13),
    nume     VARCHAR2(50),
    prenume  VARCHAR2(50),
    varsta   NUMBER
  );

  TYPE cas_rec IS RECORD (
    judet VARCHAR2(50)
  );

  TYPE diagnostic_rec IS RECORD (
    nume VARCHAR2(100),
    tip  VARCHAR2(50)
  );

  TYPE refcursor IS REF CURSOR;
  
  TYPE lista_diagnostice IS TABLE OF VARCHAR2(100);
  
  
  FUNCTION pacient_exista(p_cnp VARCHAR2) RETURN BOOLEAN;
  FUNCTION cas_exista(p_judet VARCHAR2) RETURN BOOLEAN;
  FUNCTION diagnostic_exista(p_nume VARCHAR2) RETURN BOOLEAN;
  FUNCTION asig_med_exista(p_id_pacient NUMBER, p_id_cas NUMBER) RETURN BOOLEAN;

  PROCEDURE adauga_pacient(p_pacient IN pacient_rec);
  PROCEDURE adauga_cas(p_cas IN cas_rec);
  PROCEDURE adauga_diagnostic(p_diag IN diagnostic_rec);
  PROCEDURE asigura_pacient_la_cas(p_pacient IN pacient_rec, p_cas IN cas_rec);
  PROCEDURE afiseaza_pacienti_cu_diagnostice_cronice;
  
  FUNCTION pacienti_cu_diagnostic(p_nume_diagnostic VARCHAR2) RETURN refcursor;

END pachet_spitale;
/




CREATE OR REPLACE PACKAGE BODY pachet_spitale IS

  FUNCTION pacient_exista(p_cnp VARCHAR2) RETURN BOOLEAN IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count FROM pacienti WHERE cnp = p_cnp;
    RETURN v_count > 0;
  END pacient_exista;

  FUNCTION cas_exista(p_judet VARCHAR2) RETURN BOOLEAN IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count FROM cas WHERE LOWER(judet) = LOWER(p_judet);
    RETURN v_count > 0;
  END cas_exista;

  FUNCTION diagnostic_exista(p_nume VARCHAR2) RETURN BOOLEAN IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count FROM diagnostice WHERE LOWER(nume) = LOWER(p_nume);
    RETURN v_count > 0;
  END diagnostic_exista;

  FUNCTION asig_med_exista(p_id_pacient NUMBER, p_id_cas NUMBER) RETURN BOOLEAN IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count
    FROM asig_med
    WHERE id_pacient = p_id_pacient AND id_cas = p_id_cas;
    RETURN v_count > 0;
  END asig_med_exista;

  PROCEDURE adauga_pacient(p_pacient IN pacient_rec) IS
    v_id_pacient NUMBER;
  BEGIN
    IF pacient_exista(p_pacient.cnp) THEN
      DBMS_OUTPUT.PUT_LINE('Eroare: Pacient cu CNP-ul ' || p_pacient.cnp || ' exista deja.');
      RETURN;
    END IF;

    SELECT NVL(MAX(id_pacient), 0) + 1 INTO v_id_pacient FROM pacienti;

    INSERT INTO pacienti (id_pacient, cnp, nume, prenume, varsta)
    VALUES (v_id_pacient, p_pacient.cnp, p_pacient.nume, p_pacient.prenume, p_pacient.varsta);

    DBMS_OUTPUT.PUT_LINE('Pacient nou adaugat cu ID: ' || v_id_pacient);

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Eroare la adaugarea pacientului: ' || SQLERRM);
  END adauga_pacient;

  PROCEDURE adauga_cas(p_cas IN cas_rec) IS
    v_id_cas NUMBER;
  BEGIN
    IF cas_exista(p_cas.judet) THEN
      DBMS_OUTPUT.PUT_LINE('Eroare: CAS cu judetul "' || p_cas.judet || '" exista deja.');
      RETURN;
    END IF;

    SELECT NVL(MAX(id_cas), 0) + 1 INTO v_id_cas FROM cas;

    INSERT INTO cas (id_cas, judet)
    VALUES (v_id_cas, p_cas.judet);

    DBMS_OUTPUT.PUT_LINE('CAS nou adaugat cu ID: ' || v_id_cas);

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Eroare la adaugarea CAS: ' || SQLERRM);
  END adauga_cas;

  PROCEDURE adauga_diagnostic(p_diag IN diagnostic_rec) IS
    v_id_diag NUMBER;
  BEGIN
    IF diagnostic_exista(p_diag.nume) THEN
      DBMS_OUTPUT.PUT_LINE('Eroare: Diagnosticul "' || p_diag.nume || '" exista deja.');
      RETURN;
    END IF;

    SELECT NVL(MAX(id_diagnostic), 0) + 1 INTO v_id_diag FROM diagnostice;

    INSERT INTO diagnostice (id_diagnostic, nume, tip)
    VALUES (v_id_diag, p_diag.nume, p_diag.tip);

    DBMS_OUTPUT.PUT_LINE('Diagnostic nou adaugat cu ID: ' || v_id_diag);

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Eroare la adaugarea diagnosticului: ' || SQLERRM);
  END adauga_diagnostic;

  PROCEDURE asigura_pacient_la_cas(p_pacient IN pacient_rec, p_cas IN cas_rec) IS
    v_id_pacient NUMBER;
    v_id_cas NUMBER;
  BEGIN
    IF NOT pacient_exista(p_pacient.cnp) THEN
      adauga_pacient(p_pacient);
    END IF;

    IF NOT cas_exista(p_cas.judet) THEN
      adauga_cas(p_cas);
    END IF;

    BEGIN
      SELECT id_pacient INTO v_id_pacient FROM pacienti WHERE cnp = p_pacient.cnp;
    EXCEPTION
      WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Mai multi pacienti cu acelasi CNP.');
        RETURN;
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Pacientul nu a fost gasit dupa adaugare.');
        RETURN;
    END;

    BEGIN
      SELECT id_cas INTO v_id_cas FROM cas WHERE LOWER(judet) = LOWER(p_cas.judet);
    EXCEPTION
      WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: Mai multe CAS-uri cu acelasi judet.');
        RETURN;
      WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Eroare: CAS-ul nu a fost gasit dupa adaugare.');
        RETURN;
    END;

    IF asig_med_exista(v_id_pacient, v_id_cas) THEN
      DBMS_OUTPUT.PUT_LINE('Pacientul este deja asigurat la CAS-ul specificat.');
      RETURN;
    END IF;

    INSERT INTO asig_med (id_asig_med, id_cas, id_pacient, data_emiterii)
    VALUES (
      (SELECT NVL(MAX(id_asig_med), 0) + 1 FROM asig_med),
      v_id_cas,
      v_id_pacient,
      SYSDATE
    );

    DBMS_OUTPUT.PUT_LINE('Asigurare medicala adaugata cu succes pentru pacientul ' || p_pacient.nume || ' la CAS ' || p_cas.judet);

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Eroare la asigurarea pacientului: ' || SQLERRM);
  END asigura_pacient_la_cas;

  FUNCTION pacienti_cu_diagnostic(p_nume_diagnostic VARCHAR2) RETURN refcursor IS
    v_cursor refcursor;
    v_id_diag diagnostice.id_diagnostic%TYPE;
  BEGIN
    BEGIN
      SELECT id_diagnostic INTO v_id_diag 
      FROM diagnostice 
      WHERE LOWER(nume) = LOWER(p_nume_diagnostic);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        adauga_diagnostic(diagnostic_rec(p_nume_diagnostic, 'Necunoscut'));
        SELECT id_diagnostic INTO v_id_diag 
        FROM diagnostice 
        WHERE LOWER(nume) = LOWER(p_nume_diagnostic);
    END;

    OPEN v_cursor FOR
      SELECT p.id_pacient, p.cnp, p.nume, p.prenume, p.varsta
      FROM pacienti p
      JOIN pacienti_diagnostice pd ON p.id_pacient = pd.id_pacient
      WHERE pd.id_diagnostic = v_id_diag;

    RETURN v_cursor;
  END pacienti_cu_diagnostic;
  
  
  PROCEDURE afiseaza_pacienti_cu_diagnostice_cronice IS
  v_diagnostice lista_diagnostice;
  v_cursor      refcursor;
  v_id          NUMBER;
  v_cnp         VARCHAR2(13);
  v_nume        VARCHAR2(50);
  v_prenume     VARCHAR2(50);
  v_varsta      NUMBER;
BEGIN
  SELECT nume BULK COLLECT INTO v_diagnostice
  FROM diagnostice
  WHERE LOWER(tip) = 'cronic';

  FOR i IN 1 .. v_diagnostice.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('----------------------------');
    DBMS_OUTPUT.PUT_LINE('Diagnostic cronic: ' || v_diagnostice(i));

    v_cursor := pacienti_cu_diagnostic(v_diagnostice(i));

    LOOP
      FETCH v_cursor INTO v_id,v_cnp, v_nume, v_prenume, v_varsta;
      EXIT WHEN v_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(' - ' || v_nume || ' ' || v_prenume || ' | CNP: ' || v_cnp || ' | Varsta: ' || v_varsta);
    END LOOP;

    CLOSE v_cursor;
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Eroare: ' || SQLERRM);
END afiseaza_pacienti_cu_diagnostice_cronice;

END pachet_spitale;
/



BEGIN
  -- TEST pacient_exista
  IF pachet_spitale.pacient_exista('1234567890122') THEN
    DBMS_OUTPUT.PUT_LINE('Pacientul EXISTA.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Pacientul NU exista.');
  END IF;

  -- TEST cas_exista
  IF pachet_spitale.cas_exista('Cluj') THEN
    DBMS_OUTPUT.PUT_LINE('CAS Cluj EXISTA.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('CAS Cluj NU exista.');
  END IF;

  -- TEST diagnostic_exista
  IF pachet_spitale.diagnostic_exista('Gripa') THEN
    DBMS_OUTPUT.PUT_LINE('Diagnosticul Gripa EXISTA.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Diagnosticul Gripa NU exista.');
  END IF;

  -- TEST asig_med_exista
  IF pachet_spitale.asig_med_exista(1, 1) THEN
    DBMS_OUTPUT.PUT_LINE('Asigurarea medicala EXISTA.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Asigurarea medicala NU exista.');
  END IF;
END;

-- Test adauga_pacient

DECLARE
  v_pacient pachet_spitale.pacient_rec;
BEGIN
  v_pacient.cnp := '1234567890126';
  v_pacient.nume := 'Pop';
  v_pacient.prenume := 'Ionut';
  v_pacient.varsta := 57;

  pachet_spitale.adauga_pacient(v_pacient); 
END;


-- Test adauga_cas 

DECLARE
  v_cas pachet_spitale.cas_rec;
BEGIN
  v_cas.judet := 'Bihor';
  pachet_spitale.adauga_cas(v_cas);
END;


-- Test adauga_diagnostic

DECLARE
  v_diag pachet_spitale.diagnostic_rec;
BEGIN
  v_diag.nume := 'Leucemie';
  v_diag.tip := 'CRONIC';
  pachet_spitale.adauga_diagnostic(v_diag); 
END;



-- Test asigura_pacient_la_cas

DECLARE
  v_pacient pachet_spitale.pacient_rec;
  v_cas pachet_spitale.cas_rec;
BEGIN
  v_pacient.cnp := '1234567890123';
  v_pacient.nume := 'Ionescu';
  v_pacient.prenume := 'Valeriu';
  v_pacient.varsta := 25;

  v_cas.judet := 'Olt';

  pachet_spitale.asigura_pacient_la_cas(v_pacient, v_cas); -- asigura pacient la cas, desi nu exista niciuna
  pachet_spitale.asigura_pacient_la_cas(v_pacient, v_cas); -- deja asigurat
END;

-- Test pacienti_cu_diagnostic

DECLARE
  v_cursor pachet_spitale.refcursor;
  v_id NUMBER;
  v_cnp VARCHAR2(13);
  v_nume VARCHAR2(50);
  v_prenume VARCHAR2(50);
  v_varsta NUMBER;
BEGIN
  v_cursor := pachet_spitale.pacienti_cu_diagnostic('Gripa');

  LOOP
    FETCH v_cursor INTO v_id, v_cnp, v_nume, v_prenume, v_varsta;
    EXIT WHEN v_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Pacient: ' || v_nume || ' ' || v_prenume || ', CNP: ' || v_cnp);
  END LOOP;

  CLOSE v_cursor;
END;




--- Test afiseaza_pacienti_cu_diagnostice_cronice


BEGIN
  pachet_spitale.afiseaza_pacienti_cu_diagnostice_cronice;
END;
/


