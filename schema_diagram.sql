/* CREATE TABLES FOR DIAGRAM */

-- patients
CREATE TABLE patients (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  PRIMARY KEY(id)
);

-- medical history
CREATE TABLE medical_histories (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id INT NOT NULL,
  status VARCHAR(250) NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patients(id);
  PRIMARY KEY(id)
);

-- treatments
CREATE TABLE treatments (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(250) NOT NULL,
  name VARCHAR(250) NOT NULL,
  PRIMARY KEY(id)
);

-- invoices
CREATE TABLE invoices (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  total_amount FLOAT(2) NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

-- invoice_items
CREATE TABLE invoice_items (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  unit_price FLOAT(2) NOT NULL,
  quantity INT NOT NULL,
  total_price FLOAT(2) NOT NULL,
  invoice_id INT NOT NULL,
  treatment_id INT NOT NULL,
  FOREIGN KEY (invoice_id) REFERENCES invoice(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id),
  PRIMARY KEY(id)
);

-- join many to many 
CREATE TABLE join_history_treatment (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  history_id_fk INT NOT NULL,
  treatment_id_fk INT NOT NULL,
  FOREIGN KEY (history_id_fk) REFERENCES medical_histories(id),
  FOREIGN KEY (treatment_id_fk) REFERENCES treatments(id),
  PRIMARY KEY(id)
);