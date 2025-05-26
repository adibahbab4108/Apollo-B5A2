# Apollo-B5A2

## 1 What is PostgreSQL?

**PostgreSQL** হচ্ছে Advance Relational Database system যা relational model use করে ডাটা স্টোর এবং ম্যানেজ করে। এখানে ডাটাগুলো Table আকারে সাজানো থাকে এবং Foreign Key এর মাধ্যমে বিভিন্ন টেবিলের মধ্যে সম্পর্ক তৈরি করা যায়। ফলে Integrity, scalability এবং performance ensure বজায় থাকে।

## 2 What is the purpose of a database schema in PostgreSQL?

**PostgreSQL**-এর Database Schema হলো এক ধরনের logical structure, যা tables, views, indexes, functions, data types ইত্যাদি organize করতে সাহায্য করে।

- বিভিন্ন related tables এবং functions একসাথে group করা যায়, যাতে database structured ও manageable হয়।
- একই database-এ multiple objects একই নামে থাকতে পারে ফলে conflicts avoid করা যায়। অর্থাৎ different schema তৈরি করে একই ধরনের ডাটা রাখলেও কোন ঝামেলা হবেনা।
- একাধিক user এক database-এ কাজ করতে পারে without interfering with each other।
- Schema level-এ permissions define করে restricted access দেওয়া যায়।
- Database-এর specific parts সহজেই backup & restore করা যায়।

By default, PostgreSQL public schema create করে, but users চাইলে custom schemas define করতে পারে better organization এর জন্য

## 3 Explain the Primary Key and Foreign Key concepts in PostgreSQL.
**Primary** Key হলো একটি বা একাধিক column, যা প্রতিটি row কে uniquely identify করে। 
তাছাড়া
- Unique values থাকতে হবে (অন্য কোনো row-এর সাথে মিলবে না)
- NULL values থাকতে পারবে না
- একটি table-এর শুধু একটিই Primary Key থাকতে পারে

আবার Foreign Key এমন একটি column যা অন্য table-এর Primary Key কে reference করে, ফলে Different tables-এর মধ্যে relation তৈরি করা যায় এবং data consistency বজায় থাকে।

## 4 What is the difference between the VARCHAR and CHAR data types?
**VARCHAR** এবং **CHAR** দুটোই chareceter/string type data রাখতে ব্যবহৃত হয়। তবে এদের মধ্যে কিছু পার্থক্য আছে। যেমনঃ
- VARCHAR Extra spaces সংরক্ষণ করে না, শুধুমাত্র actual data store করে।
- CHAR fixed-length data store করে। যদি data length কম হয়, তাহলে extra spaces দিয়ে পূরণ করা হয়। যদিও Faster perform করে এবং fixed size থাকায় retrieval দ্রুত হয়।