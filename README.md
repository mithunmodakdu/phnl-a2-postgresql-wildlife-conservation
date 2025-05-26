## What is PostgreSQL?
PostgreSQL হচ্ছে একটি  রিলেশনাল ডেটাবেজ ম্যানেজমেন্ট সিস্টেম (RDBMS), যা ডেটা সংরক্ষণ ও ব্যবস্থাপনার জন্য ব্যবহৃত হয়। এটি এমন একটি ডেটাবেজ সফটওয়্যার, যেখানে আমরা ডেটা সংরক্ষণ, খুঁজে পাওয়া, আপডেট ও মুছে ফেলার মতো কাজ করতে পারি। এখানে কাজ করার জন্য আমাদেরকে SQL (Structured Query Language) ব্যবহার করতে হয়। এটি ওপেন সোর্স এবং ফ্রি। যেকোনো ছোট থেকে বড় প্রকল্পে ব্যবহার করার জন্য এটি খুবই নির্ভরযোগ্য, নিরাপদ। এটি জটিল কুয়েরি সাপোর্ট করে এবং একাধিক ইউজারের কাজ ঠিকভাবে পরিচালনা করতে পারে।


## What is the purpose of a database schema in PostgreSQL?
Schema হলো PostgreSQL ডেটাবেসের ভিতরে একটি লজিক্যাল বিভাগ যা একধরনের ফোল্ডারের মতো কাজ করে যেখানে ডেটাবেসের অবজেক্টগুলোকে আলাদাভাবে রাখা যায়।

**স্কিমার উদ্দেশ্যসমূহ:**
1. স্কিমা ব্যবহার করে বড় ডেটাবেসকে ছোট ছোট অংশে ভাগ করা যায়। যেমন:
    - Schema: hr      → employees, salaries টেবিল
    - Schema: sales   → orders, customers টেবিল
    - Schema: public  → default টেবিল

2. Name Conflict এড়ানো যায় । আমরা দুইটি স্কিমাতে একই নামে টেবিল রাখতে পারি। যেমন:
    - hr.employees
    - sales.employees

3. স্কিমাভিত্তিক প্রবেশাধিকার (privileges) দেওয়ার মাধ্যমে অ্যাক্সেস নিয়ন্ত্রণ করা যায়।
    যেমন: একটি স্কিমা শুধুমাত্র নির্দিষ্ট ইউজারই ব্যবহার করতে পারবে।


## Explain the Primary Key and Foreign Key concepts in PostgreSQL

**Primary Key:**

Primary Key হলো একটি টেবিলের এমন একটি কলাম বা কলামগুলোর নামের সমষ্টি, যা প্রতিটি রো বা রেকর্ডকে ইউনিকভাবে চিহ্নিত করে। এর প্রতিটি মান অবশ্যই ইউনিক হতে হবে। এর মান কখনোই NULL হতে পারবে না। একটি টেবিলে মাত্র একটি Primary Key থাকতে পারে।

উদাহরণ:
<pre>
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(50),
    dateOfBirth DATE
); </pre>
এখানে student_id কলামটি Primary Key । প্রতিটি ছাত্রের একটি আলাদা student_id থাকবে।

**Foreign Key:**

Foreign Key হলো এমন একটি কলাম, যা অন্য একটি টেবিলের Primary Key-কে রেফারেন্স হিসেবে ব্যবহার করে। এটি দুইটি টেবিলের মধ্যে relationship তৈরি করে। একটি টেবিলে একাধিক Foreign Key থাকতে পারে।

উদাহরণ:
<pre>
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
); </pre>

এখানে enrollments টেবিলের student_id একটি Foreign Key, যা students টেবিলের student_id কে রেফারেন্স করছে। আবার course_id ও একটি Foreign Key, যা courses টেবিলের course_id কে রেফারেন্স করছে।
