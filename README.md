# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
3.2.1

* How to run the test suite
rspec

* In this application we have only one API http://localhost:3000/api/v1/courses to create course and it's tutors
* 
Example of json body

{
  "course": {
    "name": "Math Course",
    "tutors_attributes": [
      { "name": "Tutor A" },w
      { "name": "Tutor B" }
    ] 
  }
}
