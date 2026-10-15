--
-- PostgreSQL database dump
--

\restrict 11pCgd55HBNh10JLbRHikfHT1LePa2kbU3XqKeesi9KgpNGpm5MM31TpTYRBUfH

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-10-15 21:16:40

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 252 (class 1259 OID 69804)
-- Name: appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment (
    id_appointment integer NOT NULL,
    id_patient integer NOT NULL,
    id_doctor integer NOT NULL,
    id_service integer NOT NULL,
    date_appointment date NOT NULL,
    time_appointment time without time zone NOT NULL,
    id_cabinet integer NOT NULL,
    id_status integer NOT NULL,
    complaints_appointment text,
    diagnosis_appointment text,
    recommendations_appointment text,
    created_appointment timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.appointment OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 69803)
-- Name: appointment_id_appointment_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_id_appointment_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointment_id_appointment_seq OWNER TO postgres;

--
-- TOC entry 5286 (class 0 OID 0)
-- Dependencies: 251
-- Name: appointment_id_appointment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_id_appointment_seq OWNED BY public.appointment.id_appointment;


--
-- TOC entry 228 (class 1259 OID 69602)
-- Name: appointment_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment_status (
    id_status integer NOT NULL,
    name_status character varying(100) NOT NULL
);


ALTER TABLE public.appointment_status OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 69601)
-- Name: appointment_status_id_status_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_status_id_status_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointment_status_id_status_seq OWNER TO postgres;

--
-- TOC entry 5287 (class 0 OID 0)
-- Dependencies: 227
-- Name: appointment_status_id_status_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_status_id_status_seq OWNED BY public.appointment_status.id_status;


--
-- TOC entry 234 (class 1259 OID 69635)
-- Name: cabinet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cabinet (
    id_cabinet integer NOT NULL,
    number_cabinet character varying(50) NOT NULL,
    id_department integer
);


ALTER TABLE public.cabinet OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 69634)
-- Name: cabinet_id_cabinet_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cabinet_id_cabinet_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cabinet_id_cabinet_seq OWNER TO postgres;

--
-- TOC entry 5288 (class 0 OID 0)
-- Dependencies: 233
-- Name: cabinet_id_cabinet_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cabinet_id_cabinet_seq OWNED BY public.cabinet.id_cabinet;


--
-- TOC entry 222 (class 1259 OID 69571)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id_department integer NOT NULL,
    name_department character varying(200) NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 69570)
-- Name: department_id_department_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_id_department_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_id_department_seq OWNER TO postgres;

--
-- TOC entry 5289 (class 0 OID 0)
-- Dependencies: 221
-- Name: department_id_department_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_id_department_seq OWNED BY public.department.id_department;


--
-- TOC entry 242 (class 1259 OID 69695)
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    id_doctor integer NOT NULL,
    first_name_doctor character varying(100) NOT NULL,
    last_name_doctor character varying(100) NOT NULL,
    middle_name_doctor character varying(100),
    phone_doctor character varying(20),
    id_specialization integer NOT NULL,
    id_department integer NOT NULL,
    id_user integer
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 69694)
-- Name: doctor_id_doctor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doctor_id_doctor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doctor_id_doctor_seq OWNER TO postgres;

--
-- TOC entry 5290 (class 0 OID 0)
-- Dependencies: 241
-- Name: doctor_id_doctor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doctor_id_doctor_seq OWNED BY public.doctor.id_doctor;


--
-- TOC entry 250 (class 1259 OID 69780)
-- Name: doctor_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor_schedule (
    id_doctor_schedule integer NOT NULL,
    id_doctor integer NOT NULL,
    date_schedule date NOT NULL,
    start_time_schedule time without time zone NOT NULL,
    end_time_schedule time without time zone NOT NULL,
    id_cabinet integer NOT NULL,
    is_available_schedule boolean DEFAULT true
);


ALTER TABLE public.doctor_schedule OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 69779)
-- Name: doctor_schedule_id_doctor_schedule_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doctor_schedule_id_doctor_schedule_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.doctor_schedule_id_doctor_schedule_seq OWNER TO postgres;

--
-- TOC entry 5291 (class 0 OID 0)
-- Dependencies: 249
-- Name: doctor_schedule_id_doctor_schedule_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doctor_schedule_id_doctor_schedule_seq OWNED BY public.doctor_schedule.id_doctor_schedule;


--
-- TOC entry 254 (class 1259 OID 69847)
-- Name: examination_result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.examination_result (
    id_examination_result integer NOT NULL,
    id_appointment integer NOT NULL,
    id_lab_research integer NOT NULL,
    result_date_exam timestamp without time zone,
    results_exam text,
    conclusion_exam text
);


ALTER TABLE public.examination_result OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 69846)
-- Name: examination_result_id_examination_result_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.examination_result_id_examination_result_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.examination_result_id_examination_result_seq OWNER TO postgres;

--
-- TOC entry 5292 (class 0 OID 0)
-- Dependencies: 253
-- Name: examination_result_id_examination_result_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.examination_result_id_examination_result_seq OWNED BY public.examination_result.id_examination_result;


--
-- TOC entry 256 (class 1259 OID 69870)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    id_invoice integer NOT NULL,
    id_patient integer NOT NULL,
    id_appointment integer,
    issue_date_invoice timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total_amount_invoice numeric(10,2) NOT NULL,
    discount_invoice numeric(10,2) DEFAULT 0,
    final_amount_invoice numeric(10,2) NOT NULL,
    id_payment_status integer NOT NULL
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 69869)
-- Name: invoice_id_invoice_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_id_invoice_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoice_id_invoice_seq OWNER TO postgres;

--
-- TOC entry 5293 (class 0 OID 0)
-- Dependencies: 255
-- Name: invoice_id_invoice_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_id_invoice_seq OWNED BY public.invoice.id_invoice;


--
-- TOC entry 248 (class 1259 OID 69752)
-- Name: lab_research; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab_research (
    id_lab_research integer NOT NULL,
    name_lab_research character varying(200) NOT NULL,
    cost_lab_research numeric(10,2) NOT NULL
);


ALTER TABLE public.lab_research OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 69751)
-- Name: lab_research_id_lab_research_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lab_research_id_lab_research_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lab_research_id_lab_research_seq OWNER TO postgres;

--
-- TOC entry 5294 (class 0 OID 0)
-- Dependencies: 247
-- Name: lab_research_id_lab_research_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lab_research_id_lab_research_seq OWNED BY public.lab_research.id_lab_research;


--
-- TOC entry 240 (class 1259 OID 69678)
-- Name: medical_card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medical_card (
    id_medical_card integer NOT NULL,
    id_patient integer NOT NULL,
    created_card timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.medical_card OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 69677)
-- Name: medical_card_id_medical_card_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medical_card_id_medical_card_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medical_card_id_medical_card_seq OWNER TO postgres;

--
-- TOC entry 5295 (class 0 OID 0)
-- Dependencies: 239
-- Name: medical_card_id_medical_card_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medical_card_id_medical_card_seq OWNED BY public.medical_card.id_medical_card;


--
-- TOC entry 246 (class 1259 OID 69743)
-- Name: medication; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medication (
    id_medication integer NOT NULL,
    name_medication character varying(200) NOT NULL
);


ALTER TABLE public.medication OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 69742)
-- Name: medication_id_medication_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medication_id_medication_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medication_id_medication_seq OWNER TO postgres;

--
-- TOC entry 5296 (class 0 OID 0)
-- Dependencies: 245
-- Name: medication_id_medication_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medication_id_medication_seq OWNED BY public.medication.id_medication;


--
-- TOC entry 258 (class 1259 OID 69930)
-- Name: medication_prescription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medication_prescription (
    id_prescription integer NOT NULL,
    id_appointment integer NOT NULL,
    id_medication integer NOT NULL,
    dosage_prescription character varying(200) NOT NULL,
    duration_days_prescription integer,
    instructions_prescription text
);


ALTER TABLE public.medication_prescription OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 69929)
-- Name: medication_prescription_id_prescription_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medication_prescription_id_prescription_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medication_prescription_id_prescription_seq OWNER TO postgres;

--
-- TOC entry 5297 (class 0 OID 0)
-- Dependencies: 257
-- Name: medication_prescription_id_prescription_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medication_prescription_id_prescription_seq OWNED BY public.medication_prescription.id_prescription;


--
-- TOC entry 238 (class 1259 OID 69667)
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    id_patient integer NOT NULL,
    first_name_patient character varying(100) NOT NULL,
    last_name_patient character varying(100) NOT NULL,
    middle_name_patient character varying(100),
    phone_patient character varying(20),
    birth_date_patient date,
    created_patient timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 69666)
-- Name: patient_id_patient_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patient_id_patient_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patient_id_patient_seq OWNER TO postgres;

--
-- TOC entry 5298 (class 0 OID 0)
-- Dependencies: 237
-- Name: patient_id_patient_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patient_id_patient_seq OWNED BY public.patient.id_patient;


--
-- TOC entry 230 (class 1259 OID 69613)
-- Name: payment_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_status (
    id_payment_status integer NOT NULL,
    name_payment_status character varying(100) NOT NULL
);


ALTER TABLE public.payment_status OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 69612)
-- Name: payment_status_id_payment_status_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_status_id_payment_status_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_status_id_payment_status_seq OWNER TO postgres;

--
-- TOC entry 5299 (class 0 OID 0)
-- Dependencies: 229
-- Name: payment_status_id_payment_status_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_status_id_payment_status_seq OWNED BY public.payment_status.id_payment_status;


--
-- TOC entry 232 (class 1259 OID 69624)
-- Name: payment_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_type (
    id_payment_type integer NOT NULL,
    name_payment_type character varying(100) NOT NULL
);


ALTER TABLE public.payment_type OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 69623)
-- Name: payment_type_id_payment_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_type_id_payment_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_type_id_payment_type_seq OWNER TO postgres;

--
-- TOC entry 5300 (class 0 OID 0)
-- Dependencies: 231
-- Name: payment_type_id_payment_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_type_id_payment_type_seq OWNED BY public.payment_type.id_payment_type;


--
-- TOC entry 260 (class 1259 OID 69953)
-- Name: research_referral; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.research_referral (
    id_referral integer NOT NULL,
    id_appointment integer NOT NULL,
    id_lab_research integer NOT NULL,
    referral_date_referral timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.research_referral OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 69952)
-- Name: research_referral_id_referral_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.research_referral_id_referral_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.research_referral_id_referral_seq OWNER TO postgres;

--
-- TOC entry 5301 (class 0 OID 0)
-- Dependencies: 259
-- Name: research_referral_id_referral_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.research_referral_id_referral_seq OWNED BY public.research_referral.id_referral;


--
-- TOC entry 264 (class 1259 OID 69991)
-- Name: review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.review (
    id_review integer NOT NULL,
    id_appointment integer NOT NULL,
    id_patient integer NOT NULL,
    id_doctor integer NOT NULL,
    rating_review integer NOT NULL,
    comment_review text,
    created_review timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.review OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 69990)
-- Name: review_id_review_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.review_id_review_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.review_id_review_seq OWNER TO postgres;

--
-- TOC entry 5302 (class 0 OID 0)
-- Dependencies: 263
-- Name: review_id_review_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.review_id_review_seq OWNED BY public.review.id_review;


--
-- TOC entry 220 (class 1259 OID 69560)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id_role integer NOT NULL,
    name_role character varying(100) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 69559)
-- Name: role_id_role_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_role_seq OWNER TO postgres;

--
-- TOC entry 5303 (class 0 OID 0)
-- Dependencies: 219
-- Name: role_id_role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_role_seq OWNED BY public.role.id_role;


--
-- TOC entry 244 (class 1259 OID 69724)
-- Name: service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service (
    id_service integer NOT NULL,
    name_service character varying(200) NOT NULL,
    cost_service numeric(10,2) NOT NULL,
    duration_minutes_service integer NOT NULL,
    requirements_service text,
    id_service_type integer NOT NULL
);


ALTER TABLE public.service OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 69723)
-- Name: service_id_service_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_id_service_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_id_service_seq OWNER TO postgres;

--
-- TOC entry 5304 (class 0 OID 0)
-- Dependencies: 243
-- Name: service_id_service_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_id_service_seq OWNED BY public.service.id_service;


--
-- TOC entry 226 (class 1259 OID 69591)
-- Name: service_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_type (
    id_service_type integer NOT NULL,
    name_service_type character varying(200) NOT NULL
);


ALTER TABLE public.service_type OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 69590)
-- Name: service_type_id_service_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_type_id_service_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_type_id_service_type_seq OWNER TO postgres;

--
-- TOC entry 5305 (class 0 OID 0)
-- Dependencies: 225
-- Name: service_type_id_service_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_type_id_service_type_seq OWNED BY public.service_type.id_service_type;


--
-- TOC entry 262 (class 1259 OID 69974)
-- Name: specialist_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialist_schedule (
    id_specialist_schedule integer NOT NULL,
    id_doctor integer NOT NULL,
    day_of_week_schedule integer NOT NULL,
    start_time_schedule time without time zone NOT NULL,
    end_time_schedule time without time zone NOT NULL
);


ALTER TABLE public.specialist_schedule OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 69973)
-- Name: specialist_schedule_id_specialist_schedule_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.specialist_schedule_id_specialist_schedule_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.specialist_schedule_id_specialist_schedule_seq OWNER TO postgres;

--
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 261
-- Name: specialist_schedule_id_specialist_schedule_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.specialist_schedule_id_specialist_schedule_seq OWNED BY public.specialist_schedule.id_specialist_schedule;


--
-- TOC entry 224 (class 1259 OID 69580)
-- Name: specialization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialization (
    id_specialization integer NOT NULL,
    name_specialization character varying(200) NOT NULL
);


ALTER TABLE public.specialization OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 69579)
-- Name: specialization_id_specialization_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.specialization_id_specialization_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.specialization_id_specialization_seq OWNER TO postgres;

--
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 223
-- Name: specialization_id_specialization_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.specialization_id_specialization_seq OWNED BY public.specialization.id_specialization;


--
-- TOC entry 236 (class 1259 OID 69649)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id_user integer NOT NULL,
    login_user character varying(100) NOT NULL,
    password_user character varying(255) NOT NULL,
    id_role integer NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 69648)
-- Name: user_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_user_seq OWNER TO postgres;

--
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 235
-- Name: user_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_user_seq OWNED BY public."user".id_user;


--
-- TOC entry 4985 (class 2604 OID 69807)
-- Name: appointment id_appointment; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment ALTER COLUMN id_appointment SET DEFAULT nextval('public.appointment_id_appointment_seq'::regclass);


--
-- TOC entry 4970 (class 2604 OID 69605)
-- Name: appointment_status id_status; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_status ALTER COLUMN id_status SET DEFAULT nextval('public.appointment_status_id_status_seq'::regclass);


--
-- TOC entry 4973 (class 2604 OID 69638)
-- Name: cabinet id_cabinet; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinet ALTER COLUMN id_cabinet SET DEFAULT nextval('public.cabinet_id_cabinet_seq'::regclass);


--
-- TOC entry 4967 (class 2604 OID 69574)
-- Name: department id_department; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN id_department SET DEFAULT nextval('public.department_id_department_seq'::regclass);


--
-- TOC entry 4979 (class 2604 OID 69698)
-- Name: doctor id_doctor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor ALTER COLUMN id_doctor SET DEFAULT nextval('public.doctor_id_doctor_seq'::regclass);


--
-- TOC entry 4983 (class 2604 OID 69783)
-- Name: doctor_schedule id_doctor_schedule; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_schedule ALTER COLUMN id_doctor_schedule SET DEFAULT nextval('public.doctor_schedule_id_doctor_schedule_seq'::regclass);


--
-- TOC entry 4987 (class 2604 OID 69850)
-- Name: examination_result id_examination_result; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examination_result ALTER COLUMN id_examination_result SET DEFAULT nextval('public.examination_result_id_examination_result_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 69873)
-- Name: invoice id_invoice; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice ALTER COLUMN id_invoice SET DEFAULT nextval('public.invoice_id_invoice_seq'::regclass);


--
-- TOC entry 4982 (class 2604 OID 69755)
-- Name: lab_research id_lab_research; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_research ALTER COLUMN id_lab_research SET DEFAULT nextval('public.lab_research_id_lab_research_seq'::regclass);


--
-- TOC entry 4977 (class 2604 OID 69681)
-- Name: medical_card id_medical_card; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_card ALTER COLUMN id_medical_card SET DEFAULT nextval('public.medical_card_id_medical_card_seq'::regclass);


--
-- TOC entry 4981 (class 2604 OID 69746)
-- Name: medication id_medication; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication ALTER COLUMN id_medication SET DEFAULT nextval('public.medication_id_medication_seq'::regclass);


--
-- TOC entry 4991 (class 2604 OID 69933)
-- Name: medication_prescription id_prescription; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_prescription ALTER COLUMN id_prescription SET DEFAULT nextval('public.medication_prescription_id_prescription_seq'::regclass);


--
-- TOC entry 4975 (class 2604 OID 69670)
-- Name: patient id_patient; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient ALTER COLUMN id_patient SET DEFAULT nextval('public.patient_id_patient_seq'::regclass);


--
-- TOC entry 4971 (class 2604 OID 69616)
-- Name: payment_status id_payment_status; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_status ALTER COLUMN id_payment_status SET DEFAULT nextval('public.payment_status_id_payment_status_seq'::regclass);


--
-- TOC entry 4972 (class 2604 OID 69627)
-- Name: payment_type id_payment_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_type ALTER COLUMN id_payment_type SET DEFAULT nextval('public.payment_type_id_payment_type_seq'::regclass);


--
-- TOC entry 4992 (class 2604 OID 69956)
-- Name: research_referral id_referral; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_referral ALTER COLUMN id_referral SET DEFAULT nextval('public.research_referral_id_referral_seq'::regclass);


--
-- TOC entry 4995 (class 2604 OID 69994)
-- Name: review id_review; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review ALTER COLUMN id_review SET DEFAULT nextval('public.review_id_review_seq'::regclass);


--
-- TOC entry 4966 (class 2604 OID 69563)
-- Name: role id_role; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id_role SET DEFAULT nextval('public.role_id_role_seq'::regclass);


--
-- TOC entry 4980 (class 2604 OID 69727)
-- Name: service id_service; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service ALTER COLUMN id_service SET DEFAULT nextval('public.service_id_service_seq'::regclass);


--
-- TOC entry 4969 (class 2604 OID 69594)
-- Name: service_type id_service_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_type ALTER COLUMN id_service_type SET DEFAULT nextval('public.service_type_id_service_type_seq'::regclass);


--
-- TOC entry 4994 (class 2604 OID 69977)
-- Name: specialist_schedule id_specialist_schedule; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialist_schedule ALTER COLUMN id_specialist_schedule SET DEFAULT nextval('public.specialist_schedule_id_specialist_schedule_seq'::regclass);


--
-- TOC entry 4968 (class 2604 OID 69583)
-- Name: specialization id_specialization; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialization ALTER COLUMN id_specialization SET DEFAULT nextval('public.specialization_id_specialization_seq'::regclass);


--
-- TOC entry 4974 (class 2604 OID 69652)
-- Name: user id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id_user SET DEFAULT nextval('public.user_id_user_seq'::regclass);


--
-- TOC entry 5268 (class 0 OID 69804)
-- Dependencies: 252
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment (id_appointment, id_patient, id_doctor, id_service, date_appointment, time_appointment, id_cabinet, id_status, complaints_appointment, diagnosis_appointment, recommendations_appointment, created_appointment) FROM stdin;
1	1	1	1	2025-01-15	09:00:00	1	3	Головная боль, слабость	ОРВИ	Обильное питьё, покой	2026-09-25 15:32:26.00001
2	2	2	3	2025-01-16	10:30:00	3	3	Боли в сердце, одышка	Гипертоническая болезнь	ЭКГ, консультация	2026-09-25 15:32:26.00001
3	3	3	4	2025-01-17	11:00:00	5	3	Головные боли, головокружение	Остеохондроз	МРТ, массаж	2026-09-25 15:32:26.00001
4	4	4	5	2025-01-18	14:00:00	6	3	Сыпь на коже	Атопический дерматит	Диета, мази	2026-09-25 15:32:26.00001
5	5	1	2	2025-01-20	09:30:00	2	3	Повторный приём	ОРВИ (контроль)	Продолжить лечение	2026-09-25 15:32:26.00001
6	1	2	3	2025-01-22	15:00:00	3	2	Повторная консультация	\N	\N	2026-09-25 15:32:26.00001
7	6	1	1	2025-01-23	10:00:00	1	1	Профилактический осмотр	\N	\N	2026-09-25 15:32:26.00001
8	7	3	4	2025-01-24	12:00:00	5	4	Отмена по болезни	\N	\N	2026-09-25 15:32:26.00001
9	8	4	5	2025-01-25	16:00:00	6	5	Не явилась	\N	\N	2026-09-25 15:32:26.00001
11	10	2	11	2026-10-28	10:11:00	5	4	\N	\N	\N	2026-09-28 20:11:52.782065
10	9	4	1	2025-01-27	11:30:00	2	1	Повышенное давление	\N	\N	2026-09-25 15:32:26.00001
83	1	1	1	2025-01-15	09:00:00	1	3	Температура 38.5, кашель	ОРВИ	Постельный режим, парацетамол	2026-10-02 16:15:38.769117
84	5	1	2	2025-01-20	09:30:00	2	3	Контрольный осмотр	Выздоровление	Продолжать лечение	2026-10-02 16:15:38.769117
85	6	1	1	2025-01-23	10:00:00	1	2	Боль в горле	Фарингит	Полоскание, спрей	2026-10-02 16:15:38.769117
86	7	1	1	2025-01-27	11:00:00	1	1	Головная боль	Мигрень	Обезболивающее	2026-10-02 16:15:38.769117
87	8	1	2	2025-01-29	14:00:00	2	1	Повторный приём	Наблюдение	Анализы	2026-10-02 16:15:38.769117
88	2	1	1	2025-02-03	09:00:00	1	1	Насморк, слабость	ОРЗ	Лечение	2026-10-02 16:15:38.769117
89	3	1	2	2025-02-05	10:30:00	2	1	Контроль давления	Гипертония	Таблетки	2026-10-02 16:15:38.769117
90	9	1	1	2025-02-07	11:30:00	1	1	Боль в спине	Остеохондроз	Массаж, ЛФК	2026-10-02 16:15:38.769117
91	10	1	1	2025-02-10	14:30:00	1	1	Кашель	Бронхит	Антибиотики	2026-10-02 16:15:38.769117
92	11	1	2	2025-02-12	15:30:00	2	1	Повторный приём	Наблюдение	Продолжить	2026-10-02 16:15:38.769117
93	12	1	1	2025-02-14	09:00:00	1	1	Температура	Грипп	Лечение	2026-10-02 16:15:38.769117
94	14	1	1	2025-02-17	10:00:00	1	1	Боль в животе	Гастрит	Диета	2026-10-02 16:15:38.769117
95	15	1	2	2025-02-19	11:00:00	2	1	Контроль	Улучшение	Наблюдение	2026-10-02 16:15:38.769117
96	16	1	1	2025-02-21	14:00:00	1	1	Головокружение	ВСД	Спазмолитики	2026-10-02 16:15:38.769117
\.


--
-- TOC entry 5244 (class 0 OID 69602)
-- Dependencies: 228
-- Data for Name: appointment_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment_status (id_status, name_status) FROM stdin;
1	Запланирована
2	Подтверждена
3	Завершена
4	Отменена
5	Не явился
\.


--
-- TOC entry 5250 (class 0 OID 69635)
-- Dependencies: 234
-- Data for Name: cabinet; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cabinet (id_cabinet, number_cabinet, id_department) FROM stdin;
1	101	1
2	102	1
3	201	2
4	202	2
5	301	3
6	302	4
\.


--
-- TOC entry 5238 (class 0 OID 69571)
-- Dependencies: 222
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id_department, name_department) FROM stdin;
1	Терапия
2	Кардиология
3	Неврология
4	Дерматология
\.


--
-- TOC entry 5258 (class 0 OID 69695)
-- Dependencies: 242
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor (id_doctor, first_name_doctor, last_name_doctor, middle_name_doctor, phone_doctor, id_specialization, id_department, id_user) FROM stdin;
1	Мария	Иванова	Сергеевна	+79001111111	1	1	2
2	Алексей	Петров	Владимирович	+79002222222	2	2	4
3	Елена	Сидорова	Александровна	+79003333333	3	3	5
4	Ольга	Козлова	Дмитриевна	+79004444444	4	4	6
\.


--
-- TOC entry 5266 (class 0 OID 69780)
-- Dependencies: 250
-- Data for Name: doctor_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor_schedule (id_doctor_schedule, id_doctor, date_schedule, start_time_schedule, end_time_schedule, id_cabinet, is_available_schedule) FROM stdin;
1	1	2025-01-27	09:00:00	10:00:00	1	t
2	1	2025-01-27	10:00:00	11:00:00	1	t
3	1	2025-01-27	11:00:00	12:00:00	1	f
4	2	2025-01-27	10:00:00	11:00:00	3	t
5	2	2025-01-27	11:00:00	12:00:00	3	t
6	3	2025-01-28	09:00:00	10:00:00	5	t
7	4	2025-01-28	11:00:00	12:00:00	6	t
\.


--
-- TOC entry 5270 (class 0 OID 69847)
-- Dependencies: 254
-- Data for Name: examination_result; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.examination_result (id_examination_result, id_appointment, id_lab_research, result_date_exam, results_exam, conclusion_exam) FROM stdin;
\.


--
-- TOC entry 5272 (class 0 OID 69870)
-- Dependencies: 256
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice (id_invoice, id_patient, id_appointment, issue_date_invoice, total_amount_invoice, discount_invoice, final_amount_invoice, id_payment_status) FROM stdin;
1	1	1	2026-09-25 15:35:29.84368	1500.00	0.00	1500.00	3
2	2	2	2026-09-25 15:35:29.84368	2800.00	0.00	2800.00	3
3	3	3	2026-09-25 15:35:29.84368	1800.00	0.00	1800.00	3
5	5	5	2026-09-25 15:35:29.84368	1000.00	0.00	1000.00	2
6	1	6	2026-09-25 15:35:29.84368	2000.00	0.00	2000.00	1
7	6	7	2026-09-25 15:35:29.84368	1500.00	0.00	1500.00	1
4	4	4	2026-09-25 15:35:29.84368	1700.00	17.00	1683.00	3
\.


--
-- TOC entry 5264 (class 0 OID 69752)
-- Dependencies: 248
-- Data for Name: lab_research; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lab_research (id_lab_research, name_lab_research, cost_lab_research) FROM stdin;
1	Общий анализ крови	500.00
2	Биохимический анализ крови	1200.00
3	Общий анализ мочи	400.00
4	Анализ на глюкозу	350.00
5	Липидограмма	1500.00
6	Гормоны щитовидной железы	2000.00
7	Анализ на аллергены	2500.00
8	Коагулограмма	1800.00
\.


--
-- TOC entry 5256 (class 0 OID 69678)
-- Dependencies: 240
-- Data for Name: medical_card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medical_card (id_medical_card, id_patient, created_card) FROM stdin;
1	1	2026-09-25 15:31:39.613636
2	2	2026-09-25 15:31:39.613636
3	3	2026-09-25 15:31:39.613636
4	4	2026-09-25 15:31:39.613636
5	5	2026-09-25 15:31:39.613636
6	6	2026-09-25 15:31:39.613636
7	7	2026-09-25 15:31:39.613636
8	8	2026-09-25 15:31:39.613636
9	9	2026-09-25 15:31:39.613636
10	10	2026-09-25 15:31:39.613636
\.


--
-- TOC entry 5262 (class 0 OID 69743)
-- Dependencies: 246
-- Data for Name: medication; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medication (id_medication, name_medication) FROM stdin;
1	Аспирин
2	Ибупрофен
3	Парацетамол
4	Амоксициллин
5	Метопролол
6	Эналаприл
7	Диклофенак
8	Цетиризин
9	Омепразол
10	Витамин D3
\.


--
-- TOC entry 5274 (class 0 OID 69930)
-- Dependencies: 258
-- Data for Name: medication_prescription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medication_prescription (id_prescription, id_appointment, id_medication, dosage_prescription, duration_days_prescription, instructions_prescription) FROM stdin;
1	1	3	500 мг	5	3 раза в день после еды
3	2	5	50 мг	30	2 раза в день
4	2	6	10 мг	30	1 раз в день утром
5	3	7	50 мг	10	2 раза в день после еды
6	4	8	10 мг	14	1 раз в день
7	7	4	1000МЕ	10	12
2	5	10	1000 МЕ	30	1 раз в день утром
8	1	1	500мг 3 раза в день	7	После еды
9	1	8	500мг при температуре	3	Не более 4 раз в день
10	2	6	50мг 2 раза в день	30	Утром и вечером
11	2	7	20мг 1 раз в день	14	За 30 минут до еды
12	3	4	75мг 2 раза в день	10	После еды, запивать водой
13	4	9	10мг 1 раз в день	14	Вечером перед сном
14	5	2	100мг 1 раз в день	7	После завтрака
15	6	3	1000 МЕ 1 раз в день	30	Утром с едой
16	7	5	200мг 3 раза в день	5	При боли
17	8	10	10мг 1 раз в день	30	Утром
18	1	8	500мг 3 раза в день	5	При температуре
19	1	1	250мг 3 раза в день	7	После еды
20	3	4	50мг 2 раза в день	10	После еды
21	5	3	1000 МЕ 1 раз в день	30	Утром
22	6	5	200мг при боли	3	По необходимости
23	8	6	50мг 1 раз в день	14	Утром
24	10	7	20мг 1 раз в день	14	До еды
\.


--
-- TOC entry 5254 (class 0 OID 69667)
-- Dependencies: 238
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient (id_patient, first_name_patient, last_name_patient, middle_name_patient, phone_patient, birth_date_patient, created_patient) FROM stdin;
1	Иван	Смирнов	Петрович	+79271234567	1985-03-15	2026-09-25 15:20:06.990736
3	Дмитрий	Попов	Иванович	+79373456789	1978-11-08	2026-09-25 15:20:06.990736
5	Александр	Соколов	Дмитриевич	+79275678901	2000-05-12	2026-09-25 15:20:06.990736
8	Наталья	Новикова	Павловна	+79278901234	1993-04-18	2026-09-25 15:20:06.990736
9	Сергей	Морозов	Николаевич	+79279012345	1980-08-07	2026-09-25 15:20:06.990736
4	Екатерина	Васильева	Сергеевна	+79274567890	\N	2026-09-25 15:20:06.990736
7	Андрей	Козлов	Владимирович	+79377890123	1972-12-03	2026-09-25 15:20:06.990736
6	Мария	Лебедева	Александровна	+79376789012	1988-09-25	2026-09-25 15:20:06.990736
11	Мария	Осипова	Александровна	+79375859210	1999-09-28	2026-09-28 18:53:26.067428
2	Ольга	Кузнецова	Андреевна	+79872345678	1990-07-22	2026-09-25 15:20:06.990736
10	Татьянка	Волкова	Игоревн23	+79370123453	2005-02-14	2026-09-25 15:20:06.990736
14	Дмитрий	Волков	Сергеевич	+79162222222	1992-11-20	2026-10-02 15:59:25.823538
15	Елена	Григорьева	Павловна	+79163333333	1980-03-08	2026-10-02 15:59:25.823538
16	Иван	Дмитриев	Александрович	+79164444444	1995-09-12	2026-10-02 15:59:25.823538
17	Ксения	Егорова	Михайловна	+79165555555	1988-12-25	2026-10-02 15:59:25.823538
18	Михаил	Жуков	Владимирович	+79166666666	1975-07-30	2026-10-02 15:59:25.823538
19	Наталья	Зайцева	Дмитриевна	+79167777777	1993-04-18	2026-10-02 15:59:25.823538
20	Олег	Иванов	Николаевич	+79168888888	1982-08-05	2026-10-02 15:59:25.823538
21	Полина	Ковалева	Андреевна	+79169999999	1990-01-22	2026-10-02 15:59:25.823538
22	Роман	Лебедев	Игоревич	+79160000000	1985-05-14	2026-10-02 15:59:25.823538
12	Анна	Белова	Ивановна	+79161111111	1987-06-15	2026-10-02 15:59:25.823538
23	Имя	Фамилия	Отчество	57875847857495	\N	2026-10-04 13:49:30.575507
\.


--
-- TOC entry 5246 (class 0 OID 69613)
-- Dependencies: 230
-- Data for Name: payment_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_status (id_payment_status, name_payment_status) FROM stdin;
1	Не оплачен
2	Частично оплачен
3	Оплачен
\.


--
-- TOC entry 5248 (class 0 OID 69624)
-- Dependencies: 232
-- Data for Name: payment_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_type (id_payment_type, name_payment_type) FROM stdin;
1	Наличные
2	Банковская карта
\.


--
-- TOC entry 5276 (class 0 OID 69953)
-- Dependencies: 260
-- Data for Name: research_referral; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.research_referral (id_referral, id_appointment, id_lab_research, referral_date_referral) FROM stdin;
1	2	1	2026-09-25 15:37:05.942458
2	2	5	2026-09-25 15:37:05.942458
3	3	2	2026-09-25 15:37:05.942458
4	6	1	2026-09-25 15:37:05.942458
5	6	4	2026-09-25 15:37:05.942458
6	1	8	2026-10-01 09:05:53.001261
7	1	4	2026-10-01 13:00:06.750319
9	1	1	2026-10-02 15:59:37.126387
10	2	2	2026-10-02 15:59:37.126387
11	3	1	2026-10-02 15:59:37.126387
12	4	3	2026-10-02 15:59:37.126387
13	5	2	2026-10-02 15:59:37.126387
14	6	1	2026-10-02 15:59:37.126387
35	1	1	2026-10-02 16:17:41.540292
36	2	2	2026-10-02 16:17:41.540292
37	5	1	2026-10-02 16:17:41.540292
38	7	3	2026-10-02 16:17:41.540292
39	10	1	2026-10-02 16:17:41.540292
40	11	2	2026-10-02 16:17:41.540292
\.


--
-- TOC entry 5280 (class 0 OID 69991)
-- Dependencies: 264
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.review (id_review, id_appointment, id_patient, id_doctor, rating_review, comment_review, created_review) FROM stdin;
1	1	1	1	5	Отличный врач, всё подробно объяснила	2026-09-25 15:35:44.4033
2	2	2	2	4	Хороший специалист, но долго ждала	2026-09-25 15:35:44.4033
3	3	3	3	5	Очень внимательный доктор, помогла	2026-09-25 15:35:44.4033
4	4	4	4	4	Профессионально, рекомендую	2026-09-25 15:35:44.4033
5	5	5	1	5	Быстро и качественно	2026-09-25 15:35:44.4033
6	2	2	2	5	Повторный приём прошёл отлично	2026-09-25 15:35:44.4033
\.


--
-- TOC entry 5236 (class 0 OID 69560)
-- Dependencies: 220
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id_role, name_role) FROM stdin;
1	Администратор
2	Врач
3	Руководитель
\.


--
-- TOC entry 5260 (class 0 OID 69724)
-- Dependencies: 244
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service (id_service, name_service, cost_service, duration_minutes_service, requirements_service, id_service_type) FROM stdin;
1	Первичный приём терапевта	1500.00	30	Иметь при себе результаты предыдущих обследований	1
2	Повторный приём терапевта	1000.00	20	Иметь при себе медицинскую карту	1
3	Консультация кардиолога	2000.00	40	ЭКГ, результаты анализов	1
4	Консультация невролога	1800.00	35	МРТ/КТ при наличии	1
5	Консультация дерматолога	1700.00	30	Без косметики	1
6	ЭКГ	800.00	15	Без физических нагрузок за час до процедуры	2
7	УЗИ органов брюшной полости	2500.00	30	Натощак 8 часов	2
8	Общий анализ крови	500.00	10	Натощак	3
9	Биохимический анализ крови	1200.00	10	Натощак 12 часов	3
10	Массаж лечебный	1500.00	45	Сменная обувь	4
11	Физиотерапия	900.00	20	Без металлических украшений	4
\.


--
-- TOC entry 5242 (class 0 OID 69591)
-- Dependencies: 226
-- Data for Name: service_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_type (id_service_type, name_service_type) FROM stdin;
1	Консультация
2	Диагностика
3	Лабораторное исследование
4	Процедура
\.


--
-- TOC entry 5278 (class 0 OID 69974)
-- Dependencies: 262
-- Data for Name: specialist_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specialist_schedule (id_specialist_schedule, id_doctor, day_of_week_schedule, start_time_schedule, end_time_schedule) FROM stdin;
1	1	1	09:00:00	17:00:00
2	1	2	09:00:00	17:00:00
3	1	3	09:00:00	17:00:00
4	2	1	10:00:00	18:00:00
5	2	3	10:00:00	18:00:00
6	2	5	10:00:00	18:00:00
7	3	2	09:00:00	16:00:00
8	3	4	09:00:00	16:00:00
9	4	1	11:00:00	19:00:00
10	4	3	11:00:00	19:00:00
\.


--
-- TOC entry 5240 (class 0 OID 69580)
-- Dependencies: 224
-- Data for Name: specialization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specialization (id_specialization, name_specialization) FROM stdin;
1	Терапевт
2	Кардиолог
3	Невролог
4	Дерматолог
\.


--
-- TOC entry 5252 (class 0 OID 69649)
-- Dependencies: 236
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id_user, login_user, password_user, id_role) FROM stdin;
1	admin123	123	1
2	doctorIvanov	123	2
3	head	123	3
4	doctorPetrov	123	2
5	doctorSidorov	123	2
6	doctorKozlova	123	2
7	1	1	1
8	2	2	2
9	3	3	3
\.


--
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 251
-- Name: appointment_id_appointment_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_id_appointment_seq', 96, true);


--
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 227
-- Name: appointment_status_id_status_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_status_id_status_seq', 5, true);


--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 233
-- Name: cabinet_id_cabinet_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cabinet_id_cabinet_seq', 6, true);


--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 221
-- Name: department_id_department_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_id_department_seq', 4, true);


--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 241
-- Name: doctor_id_doctor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doctor_id_doctor_seq', 4, true);


--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 249
-- Name: doctor_schedule_id_doctor_schedule_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doctor_schedule_id_doctor_schedule_seq', 7, true);


--
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 253
-- Name: examination_result_id_examination_result_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.examination_result_id_examination_result_seq', 1, false);


--
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 255
-- Name: invoice_id_invoice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_id_invoice_seq', 7, true);


--
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 247
-- Name: lab_research_id_lab_research_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lab_research_id_lab_research_seq', 8, true);


--
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 239
-- Name: medical_card_id_medical_card_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medical_card_id_medical_card_seq', 10, true);


--
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 245
-- Name: medication_id_medication_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medication_id_medication_seq', 10, true);


--
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 257
-- Name: medication_prescription_id_prescription_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medication_prescription_id_prescription_seq', 24, true);


--
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 237
-- Name: patient_id_patient_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patient_id_patient_seq', 23, true);


--
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 229
-- Name: payment_status_id_payment_status_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_status_id_payment_status_seq', 3, true);


--
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 231
-- Name: payment_type_id_payment_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_type_id_payment_type_seq', 2, true);


--
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 259
-- Name: research_referral_id_referral_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.research_referral_id_referral_seq', 40, true);


--
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 263
-- Name: review_id_review_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.review_id_review_seq', 6, true);


--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 219
-- Name: role_id_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_role_seq', 3, true);


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 243
-- Name: service_id_service_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_id_service_seq', 11, true);


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 225
-- Name: service_type_id_service_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_type_id_service_type_seq', 4, true);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 261
-- Name: specialist_schedule_id_specialist_schedule_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.specialist_schedule_id_specialist_schedule_seq', 10, true);


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 223
-- Name: specialization_id_specialization_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.specialization_id_specialization_seq', 4, true);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 235
-- Name: user_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_user_seq', 10, true);


--
-- TOC entry 5048 (class 2606 OID 69820)
-- Name: appointment appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (id_appointment);


--
-- TOC entry 5012 (class 2606 OID 69611)
-- Name: appointment_status appointment_status_name_status_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_status
    ADD CONSTRAINT appointment_status_name_status_key UNIQUE (name_status);


--
-- TOC entry 5014 (class 2606 OID 69609)
-- Name: appointment_status appointment_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_status
    ADD CONSTRAINT appointment_status_pkey PRIMARY KEY (id_status);


--
-- TOC entry 5024 (class 2606 OID 69642)
-- Name: cabinet cabinet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinet
    ADD CONSTRAINT cabinet_pkey PRIMARY KEY (id_cabinet);


--
-- TOC entry 5002 (class 2606 OID 69578)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (id_department);


--
-- TOC entry 5036 (class 2606 OID 69707)
-- Name: doctor doctor_id_user_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_id_user_key UNIQUE (id_user);


--
-- TOC entry 5038 (class 2606 OID 69705)
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (id_doctor);


--
-- TOC entry 5046 (class 2606 OID 69792)
-- Name: doctor_schedule doctor_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_schedule
    ADD CONSTRAINT doctor_schedule_pkey PRIMARY KEY (id_doctor_schedule);


--
-- TOC entry 5050 (class 2606 OID 69857)
-- Name: examination_result examination_result_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examination_result
    ADD CONSTRAINT examination_result_pkey PRIMARY KEY (id_examination_result);


--
-- TOC entry 5052 (class 2606 OID 69882)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id_invoice);


--
-- TOC entry 5044 (class 2606 OID 69760)
-- Name: lab_research lab_research_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_research
    ADD CONSTRAINT lab_research_pkey PRIMARY KEY (id_lab_research);


--
-- TOC entry 5032 (class 2606 OID 69688)
-- Name: medical_card medical_card_id_patient_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_card
    ADD CONSTRAINT medical_card_id_patient_key UNIQUE (id_patient);


--
-- TOC entry 5034 (class 2606 OID 69686)
-- Name: medical_card medical_card_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_card
    ADD CONSTRAINT medical_card_pkey PRIMARY KEY (id_medical_card);


--
-- TOC entry 5042 (class 2606 OID 69750)
-- Name: medication medication_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication
    ADD CONSTRAINT medication_pkey PRIMARY KEY (id_medication);


--
-- TOC entry 5054 (class 2606 OID 69941)
-- Name: medication_prescription medication_prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_prescription
    ADD CONSTRAINT medication_prescription_pkey PRIMARY KEY (id_prescription);


--
-- TOC entry 5030 (class 2606 OID 69676)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id_patient);


--
-- TOC entry 5016 (class 2606 OID 69622)
-- Name: payment_status payment_status_name_payment_status_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_status
    ADD CONSTRAINT payment_status_name_payment_status_key UNIQUE (name_payment_status);


--
-- TOC entry 5018 (class 2606 OID 69620)
-- Name: payment_status payment_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_status
    ADD CONSTRAINT payment_status_pkey PRIMARY KEY (id_payment_status);


--
-- TOC entry 5020 (class 2606 OID 69633)
-- Name: payment_type payment_type_name_payment_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_type
    ADD CONSTRAINT payment_type_name_payment_type_key UNIQUE (name_payment_type);


--
-- TOC entry 5022 (class 2606 OID 69631)
-- Name: payment_type payment_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_type
    ADD CONSTRAINT payment_type_pkey PRIMARY KEY (id_payment_type);


--
-- TOC entry 5056 (class 2606 OID 69962)
-- Name: research_referral research_referral_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_referral
    ADD CONSTRAINT research_referral_pkey PRIMARY KEY (id_referral);


--
-- TOC entry 5060 (class 2606 OID 70004)
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (id_review);


--
-- TOC entry 4998 (class 2606 OID 69569)
-- Name: role role_name_role_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_role_key UNIQUE (name_role);


--
-- TOC entry 5000 (class 2606 OID 69567)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id_role);


--
-- TOC entry 5040 (class 2606 OID 69736)
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id_service);


--
-- TOC entry 5008 (class 2606 OID 69600)
-- Name: service_type service_type_name_service_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_type
    ADD CONSTRAINT service_type_name_service_type_key UNIQUE (name_service_type);


--
-- TOC entry 5010 (class 2606 OID 69598)
-- Name: service_type service_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_type
    ADD CONSTRAINT service_type_pkey PRIMARY KEY (id_service_type);


--
-- TOC entry 5058 (class 2606 OID 69984)
-- Name: specialist_schedule specialist_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialist_schedule
    ADD CONSTRAINT specialist_schedule_pkey PRIMARY KEY (id_specialist_schedule);


--
-- TOC entry 5004 (class 2606 OID 69589)
-- Name: specialization specialization_name_specialization_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialization
    ADD CONSTRAINT specialization_name_specialization_key UNIQUE (name_specialization);


--
-- TOC entry 5006 (class 2606 OID 69587)
-- Name: specialization specialization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialization
    ADD CONSTRAINT specialization_pkey PRIMARY KEY (id_specialization);


--
-- TOC entry 5026 (class 2606 OID 69660)
-- Name: user user_login_user_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_login_user_key UNIQUE (login_user);


--
-- TOC entry 5028 (class 2606 OID 69658)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id_user);


--
-- TOC entry 5070 (class 2606 OID 69836)
-- Name: appointment appointment_id_cabinet_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_id_cabinet_fkey FOREIGN KEY (id_cabinet) REFERENCES public.cabinet(id_cabinet);


--
-- TOC entry 5071 (class 2606 OID 69826)
-- Name: appointment appointment_id_doctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_id_doctor_fkey FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);


--
-- TOC entry 5072 (class 2606 OID 69821)
-- Name: appointment appointment_id_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_id_patient_fkey FOREIGN KEY (id_patient) REFERENCES public.patient(id_patient);


--
-- TOC entry 5073 (class 2606 OID 69831)
-- Name: appointment appointment_id_service_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_id_service_fkey FOREIGN KEY (id_service) REFERENCES public.service(id_service);


--
-- TOC entry 5074 (class 2606 OID 69841)
-- Name: appointment appointment_id_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_id_status_fkey FOREIGN KEY (id_status) REFERENCES public.appointment_status(id_status);


--
-- TOC entry 5061 (class 2606 OID 69643)
-- Name: cabinet cabinet_id_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cabinet
    ADD CONSTRAINT cabinet_id_department_fkey FOREIGN KEY (id_department) REFERENCES public.department(id_department);


--
-- TOC entry 5064 (class 2606 OID 69713)
-- Name: doctor doctor_id_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_id_department_fkey FOREIGN KEY (id_department) REFERENCES public.department(id_department);


--
-- TOC entry 5065 (class 2606 OID 69708)
-- Name: doctor doctor_id_specialization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_id_specialization_fkey FOREIGN KEY (id_specialization) REFERENCES public.specialization(id_specialization);


--
-- TOC entry 5066 (class 2606 OID 69718)
-- Name: doctor doctor_id_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_id_user_fkey FOREIGN KEY (id_user) REFERENCES public."user"(id_user);


--
-- TOC entry 5068 (class 2606 OID 69798)
-- Name: doctor_schedule doctor_schedule_id_cabinet_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_schedule
    ADD CONSTRAINT doctor_schedule_id_cabinet_fkey FOREIGN KEY (id_cabinet) REFERENCES public.cabinet(id_cabinet);


--
-- TOC entry 5069 (class 2606 OID 69793)
-- Name: doctor_schedule doctor_schedule_id_doctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor_schedule
    ADD CONSTRAINT doctor_schedule_id_doctor_fkey FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);


--
-- TOC entry 5075 (class 2606 OID 69858)
-- Name: examination_result examination_result_id_appointment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examination_result
    ADD CONSTRAINT examination_result_id_appointment_fkey FOREIGN KEY (id_appointment) REFERENCES public.appointment(id_appointment);


--
-- TOC entry 5076 (class 2606 OID 69863)
-- Name: examination_result examination_result_id_lab_research_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examination_result
    ADD CONSTRAINT examination_result_id_lab_research_fkey FOREIGN KEY (id_lab_research) REFERENCES public.lab_research(id_lab_research);


--
-- TOC entry 5077 (class 2606 OID 69888)
-- Name: invoice invoice_id_appointment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_id_appointment_fkey FOREIGN KEY (id_appointment) REFERENCES public.appointment(id_appointment);


--
-- TOC entry 5078 (class 2606 OID 69883)
-- Name: invoice invoice_id_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_id_patient_fkey FOREIGN KEY (id_patient) REFERENCES public.patient(id_patient);


--
-- TOC entry 5079 (class 2606 OID 69893)
-- Name: invoice invoice_id_payment_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_id_payment_status_fkey FOREIGN KEY (id_payment_status) REFERENCES public.payment_status(id_payment_status);


--
-- TOC entry 5063 (class 2606 OID 69689)
-- Name: medical_card medical_card_id_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medical_card
    ADD CONSTRAINT medical_card_id_patient_fkey FOREIGN KEY (id_patient) REFERENCES public.patient(id_patient);


--
-- TOC entry 5080 (class 2606 OID 69942)
-- Name: medication_prescription medication_prescription_id_appointment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_prescription
    ADD CONSTRAINT medication_prescription_id_appointment_fkey FOREIGN KEY (id_appointment) REFERENCES public.appointment(id_appointment);


--
-- TOC entry 5081 (class 2606 OID 69947)
-- Name: medication_prescription medication_prescription_id_medication_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_prescription
    ADD CONSTRAINT medication_prescription_id_medication_fkey FOREIGN KEY (id_medication) REFERENCES public.medication(id_medication);


--
-- TOC entry 5082 (class 2606 OID 69963)
-- Name: research_referral research_referral_id_appointment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_referral
    ADD CONSTRAINT research_referral_id_appointment_fkey FOREIGN KEY (id_appointment) REFERENCES public.appointment(id_appointment);


--
-- TOC entry 5083 (class 2606 OID 69968)
-- Name: research_referral research_referral_id_lab_research_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.research_referral
    ADD CONSTRAINT research_referral_id_lab_research_fkey FOREIGN KEY (id_lab_research) REFERENCES public.lab_research(id_lab_research);


--
-- TOC entry 5085 (class 2606 OID 70005)
-- Name: review review_id_appointment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_id_appointment_fkey FOREIGN KEY (id_appointment) REFERENCES public.appointment(id_appointment);


--
-- TOC entry 5086 (class 2606 OID 70015)
-- Name: review review_id_doctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_id_doctor_fkey FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);


--
-- TOC entry 5087 (class 2606 OID 70010)
-- Name: review review_id_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_id_patient_fkey FOREIGN KEY (id_patient) REFERENCES public.patient(id_patient);


--
-- TOC entry 5067 (class 2606 OID 69737)
-- Name: service service_id_service_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_id_service_type_fkey FOREIGN KEY (id_service_type) REFERENCES public.service_type(id_service_type);


--
-- TOC entry 5084 (class 2606 OID 69985)
-- Name: specialist_schedule specialist_schedule_id_doctor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialist_schedule
    ADD CONSTRAINT specialist_schedule_id_doctor_fkey FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);


--
-- TOC entry 5062 (class 2606 OID 69661)
-- Name: user user_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.role(id_role);


-- Completed on 2026-10-15 21:16:41

--
-- PostgreSQL database dump complete
--

\unrestrict 11pCgd55HBNh10JLbRHikfHT1LePa2kbU3XqKeesi9KgpNGpm5MM31TpTYRBUfH

