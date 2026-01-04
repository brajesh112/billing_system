# Billing System – Ruby on Rails

This project is a **Billing System** built using **Ruby on Rails 8**, created as part of a mini task assignment.

The application allows creating bills for customers, calculating taxes, handling cash denominations, sending invoices asynchronously via email, and viewing previous purchase history.

---

## ✨ Features

### Product Management
- Products have:
  - Name
  - Product Code (unique business identifier)
  - Available stock
  - Unit price
  - Tax percentage
- Products are pre-seeded for testing

### Billing Page (Page 1)
- Enter customer email
- Add multiple products dynamically (Product ID + Quantity)
- Enter available denominations
- Enter paid amount
- Generate bill

### Billing Calculation
- Product validation using product code
- Stock availability check
- Tax calculation per item
- Total and rounded amount calculation
- Balance calculation

### Balance Denomination Calculation
- Uses highest denomination first
- Respects available count
- Implements greedy cash return logic

### Invoice Summary (Page 2)
- Displays:
  - Customer email
  - Purchased items
  - Tax breakdown
  - Totals
  - Balance payable
  - Balance denominations

### Async Invoice Email
- Invoice email sent to customer
- Sent asynchronously using `deliver_later`
- Uses `letter_opener` in development

### Purchase History
- View previous purchases using customer email
- Drill down into individual purchase invoices

---

## 🛠 Tech Stack

- Ruby **3.3.5**
- Ruby on Rails **8.0.4**
- PostgreSQL
- ActiveJob
- ActionMailer
- Stimulus
- Turbo
- Letter Opener (development)

---

## ⚙️ Background Jobs & Caching (Important)

### Development Environment
- Uses Rails built-in `:async` job adapter
- Uses in-memory cache (`:memory_store`)
- Keeps local setup simple and fast

### Production Configuration
- Uses Rails 8 default **Solid adapters**:
  - Solid Cache
  - Solid Queue
  - Solid Cable
- These adapters are **database-backed**
- No Redis or Sidekiq is required

This setup follows Rails 8 defaults while keeping development lightweight.

---

## 📁 Important Project Structure

```
app/
├── controllers/
├── models/
├── services/
│   ├── billing_calculation_service.rb
│   ├── purchase_persistence_service.rb
│   └── balance_denomination_service.rb
├── forms/
│   └── billing_form.rb
├── mailers/
└── views/
```

---

## 🚀 Setup & Run Instructions (For Evaluation)

### 1. Prerequisites
Ensure the following are installed:
- Ruby **3.3.5**
- Bundler (>= 2.4)
- PostgreSQL (>= 13)

### 2. Install Dependencies
All Ruby dependencies are managed using **Bundler**.

```bash
bundle install
```

### 3. Database Setup
Update PostgreSQL credentials in `config/database.yml`, then run:

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

**Note:** Solid Queue / Cache schemas are part of the Rails 8 setup and do not require custom migrations.

### 4. Run the Application

```bash
bin/rails s
```

Open in browser: [http://localhost:3000](http://localhost:3000)

---

## 📧 Email Configuration

- Invoice emails are sent asynchronously using `deliver_later`
- In development, emails open in the browser using `letter_opener`
- No real emails are sent in development

---

## 🧪 Testing the Application

1. Open the billing page
2. Enter a customer email
3. Add product codes from seeded products
4. Enter quantities
5. Enter paid amount
6. Generate bill
7. View invoice summary
8. Check invoice email preview
9. View purchase history using customer email

---

## 📄 About `requirements.txt`

The assignment requires a `requirements.txt` file.

Since this project is built using Ruby on Rails, dependencies are managed using Bundler via `Gemfile` and `Gemfile.lock`.

The `requirements.txt` file lists:
- Required system dependencies
- Required Ruby gems
- Rails 8 default Solid adapters used in production

Dependencies are installed using:

```bash
bundle install
```

---

## 📝 Assumptions

- Product code is used as the business identifier
- Prices and taxes are stored as decimals
- Rounded total uses floor rounding
- Email uniquely identifies a customer
- Denominations are predefined
- Stock is updated only after successful billing
- Email delivery is asynchronous