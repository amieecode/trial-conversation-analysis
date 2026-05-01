# Trial Activation & Conversion Analysis

### Splendor Analytics Case Study

---

## Project Overview

At Splendor Analytics, organisations are given a 30-day free trial of a workforce management platform covering scheduling, time tracking, payroll, and team communication.
Despite a ~20% conversion rate, the product team lacks clarity on:
* What defines a “successful” trial
* Which user behaviours lead to conversion
* When and how to intervene during onboarding

This project aims to:

1. Identify behavioural patterns linked to conversion
2. Define **Trial Goals** representing core product value
3. Establish a data-driven definition of **Trial Activation**
4. Build SQL models to track activation at scale
5. Generate actionable product insights

---

## Dataset Description

The dataset contains behavioural event logs for organisations that started trials between January and March.

| Column          | Description                             |
| --------------- | --------------------------------------- |
| organization_id | Unique identifier for each organisation |
| activity_name   | Action performed in the product         |
| timestamp       | Time of activity                        |
| converted       | Whether the organisation converted      |
| converted_at    | Time of conversion                      |
| trial_start     | Trial start date                        |
| trial_end       | Trial end date                          |


## Data Cleaning & Preparation

The dataset was processed using Python to ensure quality and usability:

* Parsed timestamps into datetime format
* Removed duplicates and handled missing values
* Created derived features:

  * `days_since_trial_start`
  * `week_of_trial`
  * `is_first_week`
* Filtered **Week 1 activity** to focus on early engagement

These steps ensured accurate analysis and reliable feature engineering.

---

## Exploratory Data Analysis

### Key Observations

* Conversion rate is highest in **Week 1 (~23%)**
* Engagement declines after early trial stages
* User activity is highly skewed:

  * Some organisations show very high usage
  * Most exhibit low engagement

---

## Conversion Driver Analysis

Multiple approaches were used:
### 1. Engagement Analysis

* Converters perform more actions in Week 1 (~38 vs ~33 events)
* Active days are nearly identical (~1.65 vs ~1.68)

Insight:
**Intensity of usage matters more than frequency**

---

### 2. Statistical Testing

* Chi-square tests showed weak relationships between individual features and conversion

---

### 3. Machine Learning (Random Forest)

* Model trained on Week 1 features
* ROC-AUC ≈ **0.71** (moderate predictive power)

#### Top Drivers:

* Total events (dominant)
* Active days (secondary)
* Specific feature usage (minimal impact)

---

### 4. Funnel Analysis

* Progression through product stages does not strongly differentiate converters
* No single step guarantees conversion

---

## Trial Goals Definition

Trial Goals represent meaningful product interactions:

* Create a shift
* View schedule
* Engage team (communication)
* Use punch clock
* Perform admin actions (approvals)

### Validation Findings

* Completing ~3 goals yields highest conversion (~25%)
* No consistent upward trend beyond this point

Insight:
**More actions ≠ guaranteed conversion**

---

## Trial Activation Definition

An organisation is considered **Activated** if it meets:

* ≥ 15 events in Week 1
* ≥ 2 active days
* ≥ 3 trial goals completed

---

## SQL Models (Marts Layer)

Two SQL models were created to simulate a production data warehouse:

### 1. `trial_goals.sql`
* Aggregates behavioural data to organisation level
* Includes engagement metrics and goal completion flags

### 2. `trial_activation.sql`
* Builds on `trial_goals`
* Calculates:

  * `goals_completed`
  * `activated` (binary flag)

> These models assume a cleaned `events` table and represent the marts layer in a typical analytics workflow.

---

## Key Metrics

* **Conversion Rate:** ~20%
* **Activation Rate:** ~16%
* **Activation → Conversion Lift:** Small (~21% → ~23%)

---

## Key Insights

### 1. Early Engagement Matters — But Moderately

Converters are more active in Week 1, but the difference is not large.

---

### 2. Frequency of Use Is Not Important

Active days show almost no difference between converters and non-converters.

---

### 3. No Single Feature Drives Conversion

Individual actions have weak predictive power.

---

### 4. Activation Has Limited Impact

Even activated users only convert slightly more than non-activated users.

---

### 5. Most Users Do Not Activate

Only ~16% of organisations reach meaningful engagement.

---

## Core Insight

> Conversion is not driven by isolated actions or simple thresholds. Instead, it depends on a combination of engagement quality, behavioural patterns, and potentially external organisational factors.

---

## Recommendations

### 1. Improve Early Onboarding
Focus on driving meaningful engagement within the first 7 days.

---

### 2. Encourage Deep Engagement
Prioritise quality of interaction over frequency of use.

---

### 3. Promote Multi-Feature Usage
Expose users to multiple core features early in the trial.

---

### 4. Reduce Product Friction
Simplify workflows to improve activation rates.

---

### 5. Use Activation as a Supporting KPI
Track activation as a directional metric, not a definitive predictor.

---

## Tech Stack

* Python (Pandas, Scikit-learn, Seaborn)
* SQL (MySQL-style modeling)
* Jupyter Notebook

---

## Conclusion

This analysis demonstrates that while early engagement is important, it is not sufficient to explain conversion outcomes fully. Improving activation remains a key opportunity, but a deeper understanding of user context and behaviour is required to drive meaningful improvements in conversion rates.

---

## Author

**Data Analyst Project Submission**
Twitter/X: *(databykaka)*
