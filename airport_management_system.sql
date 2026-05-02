-- AIRPORT MANAGEMENT SYSTEM 

-- A) CREATION OF TABLES

CREATE TABLE AIRPORT (
    Code VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100)
);

CREATE TABLE AIRLINES (
    A_Code VARCHAR(10) PRIMARY KEY,
    Airline_Name VARCHAR(100),
    Rating INT
);

CREATE TABLE AIRPLANE (
    Reg_No VARCHAR(20) PRIMARY KEY,
    Model VARCHAR(50),
    Seats INT,
    Available_Status VARCHAR(20),
    Owned_By VARCHAR(10),
    FOREIGN KEY (Owned_By) REFERENCES AIRLINES(A_Code)
);

CREATE TABLE ROUTE (
    Route_ID INT PRIMARY KEY,
    Distance INT
);

CREATE TABLE FLIGHT (
    Flight_ID INT PRIMARY KEY,
    Source VARCHAR(10),
    Destination VARCHAR(10),
    Time_On DATE,
    Uses VARCHAR(20),
    FOREIGN KEY (Source) REFERENCES AIRPORT(Code),
    FOREIGN KEY (Destination) REFERENCES AIRPORT(Code),
    FOREIGN KEY (Uses) REFERENCES AIRPLANE(Reg_No)
);

CREATE TABLE FARE (
    Amount DECIMAL(10, 2),
    Charges DECIMAL(10, 2),
    Flight_ID INT,
    FOREIGN KEY (Flight_ID) REFERENCES FLIGHT(Flight_ID)
);

CREATE TABLE PASSENGER (
    PID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender CHAR(1),
    Age INT,
    Email VARCHAR(100),
    Contact VARCHAR(15)
);

CREATE TABLE TICKET (
    Ticket_ID INT PRIMARY KEY,
    Flight_ID INT,
    PID INT,
    Booking_Date DATE,
    Mode_of_Booking VARCHAR(50),
    FOREIGN KEY (Flight_ID) REFERENCES FLIGHT(Flight_ID),
    FOREIGN KEY (PID) REFERENCES PASSENGER(PID)
);

CREATE TABLE GATE (
    Gate_ID INT PRIMARY KEY,
    Terminal VARCHAR(10),
    Location_Code VARCHAR(10),
    FOREIGN KEY (Location_Code) REFERENCES AIRPORT(Code)
);

CREATE TABLE STAFF (
    Staff_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender CHAR(1),
    Job_Title VARCHAR(50),
    Salary DECIMAL(12, 2),
    Works_For VARCHAR(10),
    FOREIGN KEY (Works_For) REFERENCES AIRPORT(Code)
);

CREATE TABLE TRANSACTION (
    Trans_ID INT PRIMARY KEY,
    Trip_Date DATE,
    Flight_ID INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (Flight_ID) REFERENCES FLIGHT(Flight_ID)
);

CREATE TABLE FEEDBACK (
    Fbk_ID INT PRIMARY KEY,
    PID INT,
    Message VARCHAR(200),
    Email VARCHAR(100),
    Emp_ID INT,
    Flight_ID INT,
    FOREIGN KEY (PID) REFERENCES PASSENGER(PID),
    FOREIGN KEY (Flight_ID) REFERENCES FLIGHT(Flight_ID),
    FOREIGN KEY (Emp_ID) REFERENCES STAFF(Staff_ID)
);

CREATE TABLE LUGGAGE (
    Luggage_ID INT PRIMARY KEY,
    Ticket_ID INT,
    Weight DECIMAL(6,2),
    Type VARCHAR(50),
    FOREIGN KEY (Ticket_ID) REFERENCES TICKET(Ticket_ID)
);

CREATE TABLE CREW (
    Crew_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Job_Title VARCHAR(50),
    Experience INT,
    Contact VARCHAR(15),
    Salary DECIMAL(12,2),
    Works_For VARCHAR(10),
    FOREIGN KEY (Works_For) REFERENCES AIRLINES(A_Code)
);


-- B) INSERTION INTO TABLES

-- 1. AIRPORT
INSERT INTO AIRPORT VALUES ('DEL', 'Indira Gandhi ', 'New Delhi');
INSERT INTO AIRPORT VALUES ('BOM', 'Chhatrapati Shivaji ', 'Mumbai');
INSERT INTO AIRPORT VALUES ('BLR', 'Banglore', 'Bengaluru');
INSERT INTO AIRPORT VALUES ('MAA', 'Chennai International', 'Chennai');
INSERT INTO AIRPORT VALUES ('HYD', 'Rajiv Gandhi International', 'Hyderabad');
INSERT INTO AIRPORT VALUES ('CCU', 'Netaji Subhas Chandra International', 'Kolkata');
INSERT INTO AIRPORT VALUES ('PNQ', 'Pune Airport', 'Pune');
INSERT INTO AIRPORT VALUES ('GOI', 'Dabolim Airport', 'Goa');
INSERT INTO AIRPORT VALUES ('AMD', 'Vallabhbhai Patel International', 'Ahmedabad');
INSERT INTO AIRPORT VALUES ('JAI', 'Jaipur International', 'Jaipur');

-- 2. AIRLINES
INSERT INTO AIRLINES VALUES ('AI', 'Air India', 5);
INSERT INTO AIRLINES VALUES ('IG', 'IndiGo', 4);
INSERT INTO AIRLINES VALUES ('SJ', 'SpiceJet', 4);
INSERT INTO AIRLINES VALUES ('VI', 'Vistara', 5);
INSERT INTO AIRLINES VALUES ('AK', 'AirAsia India', 3);
INSERT INTO AIRLINES VALUES ('GO', 'Go First', 3);
INSERT INTO AIRLINES VALUES ('BL', 'Blue Dart Aviation', 2);
INSERT INTO AIRLINES VALUES ('TD', 'TruJet', 3);
INSERT INTO AIRLINES VALUES ('AKX', 'Akasa Air', 4);
INSERT INTO AIRLINES VALUES ('SJX', 'StarJet Express', 4);

-- 3. AIRPLANE
INSERT INTO AIRPLANE VALUES ('A1001', 'Boeing 737', 180, 'Available', 'AI');
INSERT INTO AIRPLANE VALUES ('A2002', 'Airbus A320', 160, 'Available', 'IG');
INSERT INTO AIRPLANE VALUES ('A3003', 'Boeing 787', 250, 'Maintenance', 'VI');
INSERT INTO AIRPLANE VALUES ('A4004', 'Airbus A320', 70, 'Available', 'SJ');
INSERT INTO AIRPLANE VALUES ('A5005', 'Airbus A321', 200, 'Available', 'AK');
INSERT INTO AIRPLANE VALUES ('A6006', 'Boeing 777', 300, 'Maintenance', 'GO');
INSERT INTO AIRPLANE VALUES ('A7007', 'Boeing 737 MAX', 12, 'Available', 'BL');
INSERT INTO AIRPLANE VALUES ('A8008', 'Airbus A320', 100, 'Available', 'TD');
INSERT INTO AIRPLANE VALUES ('A9009', 'Airbus A319', 144, 'Available', 'AKX');
INSERT INTO AIRPLANE VALUES ('A1010', 'Boeing 737 MAX', 190, 'Available', 'SJX');

-- 4. ROUTE
INSERT INTO ROUTE VALUES (1, 1200);
INSERT INTO ROUTE VALUES (2, 1500);
INSERT INTO ROUTE VALUES (3, 900);
INSERT INTO ROUTE VALUES (4, 1100);
INSERT INTO ROUTE VALUES (5, 800);
INSERT INTO ROUTE VALUES (6, 1800);
INSERT INTO ROUTE VALUES (7, 950);
INSERT INTO ROUTE VALUES (8, 1600);
INSERT INTO ROUTE VALUES (9, 1400);
INSERT INTO ROUTE VALUES (10, 1700);

-- 5. FLIGHT
INSERT INTO FLIGHT VALUES (101, 'DEL', 'BOM', TO_DATE('2024-06-01','YYYY-MM-DD'), 'A1001');
INSERT INTO FLIGHT VALUES (102, 'BOM', 'BLR', TO_DATE('2024-06-02','YYYY-MM-DD'), 'A2002');
INSERT INTO FLIGHT VALUES (103, 'MAA', 'HYD', TO_DATE('2024-06-03','YYYY-MM-DD'), 'A3003');
INSERT INTO FLIGHT VALUES (104, 'CCU', 'DEL', TO_DATE('2024-06-04','YYYY-MM-DD'), 'A4004');
INSERT INTO FLIGHT VALUES (105, 'GOI', 'PNQ', TO_DATE('2024-06-05','YYYY-MM-DD'), 'A5005');
INSERT INTO FLIGHT VALUES (106, 'JAI', 'MAA', TO_DATE('2024-06-06','YYYY-MM-DD'), 'A6006');
INSERT INTO FLIGHT VALUES (107, 'PNQ', 'CCU', TO_DATE('2024-06-07','YYYY-MM-DD'), 'A7007');
INSERT INTO FLIGHT VALUES (108, 'AMD', 'DEL', TO_DATE('2024-06-08','YYYY-MM-DD'), 'A8008');
INSERT INTO FLIGHT VALUES (109, 'HYD', 'BOM', TO_DATE('2024-06-09','YYYY-MM-DD'), 'A9009');
INSERT INTO FLIGHT VALUES (110, 'DEL', 'GOI', TO_DATE('2024-06-10','YYYY-MM-DD'), 'A1010');

-- 6. FARE
INSERT INTO FARE VALUES (5000, 600, 101);
INSERT INTO FARE VALUES (5500, 650, 102);
INSERT INTO FARE VALUES (6000, 700, 103);
INSERT INTO FARE VALUES (5200, 550, 104);
INSERT INTO FARE VALUES (4800, 500, 105);
INSERT INTO FARE VALUES (5300, 600, 106);
INSERT INTO FARE VALUES (4900, 580, 107);
INSERT INTO FARE VALUES (5700, 620, 108);
INSERT INTO FARE VALUES (6100, 700, 109);
INSERT INTO FARE VALUES (6200, 750, 110);

-- 7. PASSENGER
INSERT INTO PASSENGER VALUES (1, 'Armaan Garg', 'M', 30, 'armaangarg@gmail.com', '9876543210');
INSERT INTO PASSENGER VALUES (2, 'Suyash Gupta', 'M', 28, 'suyashgupta@yahoo.com', '9876543211');
INSERT INTO PASSENGER VALUES (3, 'Manas goyal', 'M', 35, 'manas@gmail.com', '9876543212');
INSERT INTO PASSENGER VALUES (4, 'Saksham panwar', 'M', 26, 'sakshamp@gmail.com', '9876543213');
INSERT INTO PASSENGER VALUES (5, 'Subhendu Sharma', 'M', 32, 'subhendus@outlook.com', '9876543214');
INSERT INTO PASSENGER VALUES (6, 'Dhruv Bansal', 'M', 29, 'dhruva@gmail.com', '9876543215');
INSERT INTO PASSENGER VALUES (7, 'Sakshi', 'F', 40, 'sakshigupta@gmail.com', '9876543216');
INSERT INTO PASSENGER VALUES (8, 'ANushka Sharma', 'F', 33, 'sharmaanushka@gmail.com', '9876543217');
INSERT INTO PASSENGER VALUES (9, 'Virat kohli', 'M', 38, 'vkbhai@gmail.com', '9876543218');
INSERT INTO PASSENGER VALUES (10, 'M.S Dhoni', 'M', 27, '7paglu@gmail.com', '9876543219');

-- 8. TICKET
INSERT INTO TICKET VALUES (201, 101, 1, TO_DATE('2024-05-10','YYYY-MM-DD'), 'Online');
INSERT INTO TICKET VALUES (202, 102, 2, TO_DATE('2024-05-11','YYYY-MM-DD'), 'Mobile App');
INSERT INTO TICKET VALUES (203, 103, 3, TO_DATE('2024-05-12','YYYY-MM-DD'), 'Travel Agent');
INSERT INTO TICKET VALUES (204, 104, 4, TO_DATE('2024-05-13','YYYY-MM-DD'), 'Counter');
INSERT INTO TICKET VALUES (205, 105, 5, TO_DATE('2024-05-14','YYYY-MM-DD'), 'Online');
INSERT INTO TICKET VALUES (206, 106, 6, TO_DATE('2024-05-15','YYYY-MM-DD'), 'Mobile App');
INSERT INTO TICKET VALUES (207, 107, 7, TO_DATE('2024-05-16','YYYY-MM-DD'), 'Counter');
INSERT INTO TICKET VALUES (208, 108, 8, TO_DATE('2024-05-17','YYYY-MM-DD'), 'Online');
INSERT INTO TICKET VALUES (209, 109, 9, TO_DATE('2024-05-18','YYYY-MM-DD'), 'Travel Agent');
INSERT INTO TICKET VALUES (210, 110, 10, TO_DATE('2024-05-19','YYYY-MM-DD'), 'Mobile App');

-- 9. GATE
INSERT INTO GATE VALUES (1, 'T1', 'DEL');
INSERT INTO GATE VALUES (2, 'T2', 'BOM');
INSERT INTO GATE VALUES (3, 'T1', 'BLR');
INSERT INTO GATE VALUES (4, 'T3', 'MAA');
INSERT INTO GATE VALUES (5, 'T2', 'HYD');
INSERT INTO GATE VALUES (6, 'T1', 'CCU');
INSERT INTO GATE VALUES (7, 'T3', 'PNQ');
INSERT INTO GATE VALUES (8, 'T2', 'GOI');
INSERT INTO GATE VALUES (9, 'T3', 'AMD');
INSERT INTO GATE VALUES (10, 'T1', 'JAI');

-- 10. STAFF
INSERT INTO STAFF VALUES (301, 'Anita Roy', 'F', 'Pilot', 150000, 'DEL');
INSERT INTO STAFF VALUES (302, 'Ravi Patel', 'M', 'Ground Staff', 50000, 'BOM');
INSERT INTO STAFF VALUES (303, 'Meena Iyer', 'F', 'Cabin Crew', 60000, 'BLR');
INSERT INTO STAFF VALUES (304, 'Alok Tiwari', 'M', 'Pilot', 155000, 'MAA');
INSERT INTO STAFF VALUES (305, 'Divya Nair', 'F', 'Ticket Agent', 45000, 'HYD');
INSERT INTO STAFF VALUES (306, 'Suresh Menon', 'M', 'Technician', 70000, 'CCU');
INSERT INTO STAFF VALUES (307, 'Ankita Bose', 'F', 'Cabin Crew', 62000, 'PNQ');
INSERT INTO STAFF VALUES (308, 'Kiran Rao', 'M', 'Security', 40000, 'GOI');
INSERT INTO STAFF VALUES (309, 'Namrata Shah', 'F', 'Pilot', 160000, 'AMD');
INSERT INTO STAFF VALUES (310, 'Aditya Deshmukh', 'M', 'Technician', 72000, 'JAI');

-- 11. TRANSACTION
INSERT INTO TRANSACTION VALUES (401, TO_DATE('2024-06-01','YYYY-MM-DD'), 101, 5600.00);
INSERT INTO TRANSACTION VALUES (402, TO_DATE('2024-06-02','YYYY-MM-DD'), 102, 6500.00);
INSERT INTO TRANSACTION VALUES (403, TO_DATE('2024-06-03','YYYY-MM-DD'), 103, 7300.00);
INSERT INTO TRANSACTION VALUES (404, TO_DATE('2024-06-04','YYYY-MM-DD'), 104, 5200.00);
INSERT INTO TRANSACTION VALUES (405, TO_DATE('2024-06-05','YYYY-MM-DD'), 105, 6100.00);
INSERT INTO TRANSACTION VALUES (406, TO_DATE('2024-06-06','YYYY-MM-DD'), 106, 6800.00);
INSERT INTO TRANSACTION VALUES (407, TO_DATE('2024-06-07','YYYY-MM-DD'), 107, 7000.00);
INSERT INTO TRANSACTION VALUES (408, TO_DATE('2024-06-08','YYYY-MM-DD'), 108, 7500.00);
INSERT INTO TRANSACTION VALUES (409, TO_DATE('2024-06-09','YYYY-MM-DD'), 109, 7900.00);
INSERT INTO TRANSACTION VALUES (410, TO_DATE('2024-06-10','YYYY-MM-DD'), 110, 8200.00);

-- 12. FEEDBACK
INSERT INTO FEEDBACK VALUES (501, 1, 'FRIENDLY STAFF HAI!', 'armaangarg@gmail.com', 301, 101);
INSERT INTO FEEDBACK VALUES (502, 2, 'Flight was delayed but staff was helpful.', 'suyashgupta@yahoo.com', 302, 102);
INSERT INTO FEEDBACK VALUES (503, 3, 'Clean aircraft and smooth take-off.', 'manas@gmail.com', 303, 103);
INSERT INTO FEEDBACK VALUES (504, 4, 'KHANA Bohot badiya tha.', 'sakshamp@gmail.com', 304, 104);
INSERT INTO FEEDBACK VALUES (505, 5, 'Cabin Crew was very rude and unprofessional.', 'subhendus@outlook.com', 305, 105);
INSERT INTO FEEDBACK VALUES (506, 6, 'Would love to fly again.', 'dhruva@gmail.com', 306, 106);
INSERT INTO FEEDBACK VALUES (507, 7, 'Seats were comfortable.', 'sakshigupta@gmail.com', 307, 107);
INSERT INTO FEEDBACK VALUES (508, 8, 'Cabin crew was very professional.', 'sharmaanushka@gmail.com', 308, 108);
INSERT INTO FEEDBACK VALUES (509, 9, 'Boarding was quick and smooth.', 'vkbhai@gmail.com', 309, 109);
INSERT INTO FEEDBACK VALUES (510, 10, 'Good experience overall.', '7paglu@gmail.com', 310, 110);

-- 13. LUGGAGE
INSERT INTO LUGGAGE VALUES (601, 201, 15.5, 'Checked');
INSERT INTO LUGGAGE VALUES (602, 202, 18.0, 'Checked');
INSERT INTO LUGGAGE VALUES (603, 203, 10.0, 'Cabin');
INSERT INTO LUGGAGE VALUES (604, 204, 12.5, 'Cabin');
INSERT INTO LUGGAGE VALUES (605, 205, 20.0, 'Checked');
INSERT INTO LUGGAGE VALUES (606, 206, 16.0, 'Checked');
INSERT INTO LUGGAGE VALUES (607, 207, 11.0, 'Cabin');
INSERT INTO LUGGAGE VALUES (608, 208, 17.5, 'Checked');
INSERT INTO LUGGAGE VALUES (609, 209, 14.0, 'Cabin');
INSERT INTO LUGGAGE VALUES (610, 210, 19.0, 'Checked');

-- 14. CREW
INSERT INTO CREW VALUES (101, 'Rajesh Mehra', 'Pilot', 12, '9876543210', 250000.00, 'AI');
INSERT INTO CREW VALUES (102, 'Neha Sharma', 'Cabin Crew', 6, '9988776655', 75000.00, 'IG');
INSERT INTO CREW VALUES (103, 'Arjun Nair', 'Co-Pilot', 8, '9123456780', 180000.00, 'SJ');
INSERT INTO CREW VALUES (104, 'Pooja Iyer', 'Cabin Crew', 5, '9876501234', 72000.00, 'VI');
INSERT INTO CREW VALUES (105, 'Vikram Deshmukh', 'Pilot', 15, '9090909090', 270000.00, 'AK');
INSERT INTO CREW VALUES (106, 'Simran Kaur', 'Cabin Supervisor', 10, '9812345678', 90000.00, 'GO');
INSERT INTO CREW VALUES (107, 'Ravi Verma', 'Engineer', 9, '9765432109', 120000.00, 'BL');
INSERT INTO CREW VALUES (108, 'Anjali Menon', 'Cabin Crew', 4, '9911223344', 68000.00, 'TD');
INSERT INTO CREW VALUES (109, 'Manish Rathi', 'Ground Engineer', 11, '9823456781', 110000.00, 'AKX');
INSERT INTO CREW VALUES (110, 'Swati Kulkarni', 'Co-Pilot', 7, '9734567812', 170000.00, 'SJX');


-- C) TRIGGERS

CREATE OR REPLACE TRIGGER trg_log_flight_insert
AFTER INSERT ON FLIGHT
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('New flight added: Flight ID = ' || :NEW.Flight_ID || ', From ' || :NEW.Source || ' to ' || :NEW.Destination);
END;
/

CREATE OR REPLACE TRIGGER trg_check_luggage_weight
BEFORE INSERT OR UPDATE ON LUGGAGE
FOR EACH ROW
BEGIN
    IF :NEW.Weight > 32 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Luggage exceeds weight limit of 32 kg.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_unique_flight_booking
BEFORE INSERT ON TICKET
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM TICKET
    WHERE PID = :NEW.PID AND Flight_ID = :NEW.Flight_ID;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Passenger already booked this flight.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_validate_flight_route
BEFORE INSERT OR UPDATE ON FLIGHT
FOR EACH ROW
BEGIN
    IF :NEW.Source = :NEW.Destination THEN
        RAISE_APPLICATION_ERROR(-20003, 'Source and Destination cannot be the same.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_autofill_feedback_email
BEFORE INSERT ON FEEDBACK
FOR EACH ROW
DECLARE
    v_email VARCHAR2(100);
BEGIN
    IF :NEW.Email IS NULL THEN
        SELECT Email INTO v_email FROM PASSENGER WHERE PID = :NEW.PID;
        :NEW.Email := v_email;
    END IF;
END;
/


-- D) PROCEDURES

CREATE OR REPLACE PROCEDURE get_flights_between_airports(
    p_source_code IN VARCHAR2,
    p_dest_code IN VARCHAR2
) IS
BEGIN
    FOR flight_rec IN (
        SELECT Flight_ID, Time_On, Uses
        FROM FLIGHT
        WHERE Source = p_source_code AND Destination = p_dest_code
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Flight ID: ' || flight_rec.Flight_ID ||
                             ', Time: ' || flight_rec.Time_On ||
                             ', Airplane: ' || flight_rec.Uses);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE passenger_ticket_summary(
    p_pid IN INT
) IS
BEGIN
    FOR tkt IN (
        SELECT T.Ticket_ID, F.Source, F.Destination, T.Booking_Date
        FROM TICKET T
        JOIN FLIGHT F ON T.Flight_ID = F.Flight_ID
        WHERE T.PID = p_pid
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Ticket ID: ' || tkt.Ticket_ID ||
                             ', From: ' || tkt.Source ||
                             ', To: ' || tkt.Destination ||
                             ', Booking Date: ' || tkt.Booking_Date);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE airline_summary(p_airline_code IN VARCHAR2) IS
    v_name VARCHAR2(100);
    v_rating INT;
    v_avg_salary NUMBER;
BEGIN
    SELECT Airline_Name, Rating INTO v_name, v_rating
    FROM AIRLINES
    WHERE A_Code = p_airline_code;

    DBMS_OUTPUT.PUT_LINE('Airline: ' || v_name || ' (Rating: ' || v_rating || ')');

    DBMS_OUTPUT.PUT_LINE('Airplanes Owned:');
    FOR plane IN (
        SELECT Reg_No, Model FROM AIRPLANE
        WHERE Owned_By = p_airline_code
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('- ' || plane.Reg_No || ' (' || plane.Model || ')');
    END LOOP;

    SELECT AVG(Salary) INTO v_avg_salary
    FROM STAFF
    WHERE Works_For = p_airline_code;

    DBMS_OUTPUT.PUT_LINE('Average Staff Salary: ' || v_avg_salary);
END;
/


-- E) FUNCTIONS

CREATE OR REPLACE FUNCTION get_total_fare(p_flight_id IN INT)
RETURN DECIMAL
IS
    v_total_fare DECIMAL(10,2);
BEGIN
    SELECT (Amount + Charges) INTO v_total_fare
    FROM FARE
    WHERE Flight_ID = p_flight_id;

    RETURN v_total_fare;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

CREATE OR REPLACE FUNCTION count_passengers(p_flight_id IN INT)
RETURN NUMBER
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM TICKET
    WHERE Flight_ID = p_flight_id;

    RETURN v_count;
END;
/

CREATE OR REPLACE FUNCTION is_top_rated_airline(p_airline_code IN VARCHAR2)
RETURN VARCHAR2
IS
    v_rating INT;
BEGIN
    SELECT Rating INTO v_rating
    FROM AIRLINES
    WHERE A_Code = p_airline_code;

    IF v_rating > 4 THEN
        RETURN 'Yes';
    ELSE
        RETURN 'No';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Not Found';
END;
/

CREATE OR REPLACE FUNCTION get_flight_revenue(p_flight_id IN INT)
RETURN DECIMAL
IS
    v_total_revenue DECIMAL(12,2);
BEGIN
    SELECT NVL(SUM(Amount + Charges), 0)
    INTO v_total_revenue
    FROM FARE
    WHERE Flight_ID = p_flight_id;

    RETURN v_total_revenue;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/


-- F) CURSORS

-- Cursor 1: Flight Revenue
DECLARE
    CURSOR cur_flight_revenue IS
        SELECT F.Flight_ID, SUM(FARE.Amount + FARE.Charges) AS Total_Revenue
        FROM FLIGHT F
        JOIN FARE ON F.Flight_ID = FARE.Flight_ID
        GROUP BY F.Flight_ID;

    v_flight_id FLIGHT.Flight_ID%TYPE;
    v_revenue   DECIMAL(10,2);
BEGIN
    OPEN cur_flight_revenue;
    LOOP
        FETCH cur_flight_revenue INTO v_flight_id, v_revenue;
        EXIT WHEN cur_flight_revenue%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Flight ID: ' || v_flight_id || ' | Total Revenue: ' || v_revenue);
    END LOOP;
    CLOSE cur_flight_revenue;
END;
/

-- Cursor 2: Today's Flights
DECLARE
    CURSOR cur_today_flights IS
        SELECT Flight_ID, Source, Destination, Time_On
        FROM FLIGHT
        WHERE TRUNC(Time_On) = TRUNC(SYSDATE);

    v_flight_id FLIGHT.Flight_ID%TYPE;
    v_source    FLIGHT.Source%TYPE;
    v_dest      FLIGHT.Destination%TYPE;
    v_time      FLIGHT.Time_On%TYPE;
BEGIN
    OPEN cur_today_flights;
    LOOP
        FETCH cur_today_flights INTO v_flight_id, v_source, v_dest, v_time;
        EXIT WHEN cur_today_flights%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Flight ID: ' || v_flight_id || ', From ' || v_source || ' To ' || v_dest || ', Time: ' || v_time);
    END LOOP;
    CLOSE cur_today_flights;
END;
/

-- Cursor 3: Staff and Airline
DECLARE
    CURSOR cur_staff_airline IS
        SELECT S.Name, S.Job_Title, S.Gender, A.Airline_Name
        FROM STAFF S
        JOIN AIRLINES A ON S.Works_For = A.A_Code;

    v_name         STAFF.Name%TYPE;
    v_job_title    STAFF.Job_Title%TYPE;
    v_gender       STAFF.Gender%TYPE;
    v_airline_name AIRLINES.Airline_Name%TYPE;
BEGIN
    OPEN cur_staff_airline;
    LOOP
        FETCH cur_staff_airline INTO v_name, v_job_title, v_gender, v_airline_name;
        EXIT WHEN cur_staff_airline%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Staff: ' || v_name || ' | Role: ' || v_job_title ||
                             ' | Gender: ' || v_gender || ' | Airline: ' || v_airline_name);
    END LOOP;
    CLOSE cur_staff_airline;
END;
/

-- Cursor 4: Feedback by Flight
DECLARE
    v_flight_id INT := 2001; -- Change to any Flight ID you want to check

    CURSOR cur_feedback_by_flight IS
        SELECT Fbk_ID, PID, Message, Email
        FROM FEEDBACK
        WHERE Flight_ID = v_flight_id;

    v_fbk_id FEEDBACK.Fbk_ID%TYPE;
    v_pid    FEEDBACK.PID%TYPE;
    v_msg    FEEDBACK.Message%TYPE;
    v_email  FEEDBACK.Email%TYPE;
BEGIN
    OPEN cur_feedback_by_flight;
    LOOP
        FETCH cur_feedback_by_flight INTO v_fbk_id, v_pid, v_msg, v_email;
        EXIT WHEN cur_feedback_by_flight%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Feedback ID: ' || v_fbk_id ||
                             ' | Passenger: ' || v_pid ||
                             ' | Email: ' || v_email ||
                             ' | Message: "' || v_msg || '"');
    END LOOP;
    CLOSE cur_feedback_by_flight;
END;
/


-- G) QUERIES

-- List All Staff with Salaries Above Average in Their Airline
SELECT
    S.Name,
    S.Job_Title,
    S.Salary,
    S.Works_For,
    (SELECT AVG(S2.Salary)
     FROM STAFF S2
     WHERE S2.Works_For = S.Works_For) AS Airline_Avg_Salary
FROM STAFF S
ORDER BY S.Works_For, S.Salary DESC;

-- Upcoming Flights with Subquery to Show Seat Availability
SELECT
    F.Flight_ID,
    F.Time_On,
    GET_FLIGHT_REVENUE(F.Flight_ID) AS Total_Revenue
FROM FLIGHT F
ORDER BY Total_Revenue DESC;

-- Passengers With At Least 1 Booking
SELECT
    P.PID,
    P.Name,
    COUNT(T.Ticket_ID) AS Total_Bookings
FROM PASSENGER P
JOIN TICKET T ON P.PID = T.PID
GROUP BY P.PID, P.Name
HAVING COUNT(T.Ticket_ID) >= 1
ORDER BY Total_Bookings DESC;

-- Flight Revenue Summary Using Function
SELECT
    F.Flight_ID,
    F.Source,
    F.Destination,
    GET_FLIGHT_REVENUE(F.Flight_ID) AS Total_Revenue
FROM FLIGHT F
ORDER BY Total_Revenue DESC;

-- List of Flights with Airplane Model and Availability
SELECT
    F.Flight_ID,
    F.Source,
    F.Destination,
    A.Model,
    A.Available_Status
FROM FLIGHT F
JOIN AIRPLANE A ON F.Uses = A.Reg_No
ORDER BY F.Flight_ID;

-- H) MySQL Constraint Extensions
USE airport_management_system;

ALTER TABLE TICKET
  ADD UNIQUE KEY uq_ticket_passenger_flight (PID, Flight_ID);

DELIMITER $$
CREATE TRIGGER trg_before_ticket_insert
BEFORE INSERT ON TICKET
FOR EACH ROW
BEGIN
  DECLARE airplane_reg VARCHAR(20);
  DECLARE remaining_seats INT;

  SELECT Uses INTO airplane_reg
  FROM FLIGHT
  WHERE Flight_ID = NEW.Flight_ID;

  IF airplane_reg IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid flight for booking';
  END IF;

  SELECT Seats INTO remaining_seats
  FROM AIRPLANE
  WHERE Reg_No = airplane_reg
  FOR UPDATE;

  IF remaining_seats IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Airplane not found for flight';
  ELSEIF remaining_seats <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No seats available';
  ELSE
    UPDATE AIRPLANE
    SET Seats = Seats - 1
    WHERE Reg_No = airplane_reg;
  END IF;
END$$
DELIMITER ;
