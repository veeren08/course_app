require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :controller do
  describe 'GET index' do
    it 'returns a list of courses with tutors' do
      course1 = create(:course)
      tutor1 = create(:tutor, course: course1)
      tutor2 = create(:tutor, course: course1)
      course2 = create(:course)
      tutor3 = create(:tutor, course: course2)

      get :index
      expect(response).to have_http_status(:ok)

      courses = JSON.parse(response.body)

      expect(courses.size).to eq(2)
      expect(courses.first['name']).to eq(course1.name)
      expect(courses.first['tutors'].size).to eq(2)
      expect(courses.last['name']).to eq(course2.name)
      expect(courses.last['tutors'].size).to eq(1)
    end
  end

  describe 'POST create' do
    it 'creates a new course with tutors' do
      course_params = {
        course: {
          name: 'Math Course',
          tutors_attributes: [
            { name: 'Tutor A' },
            { name: 'Tutor B' }
          ]
        }
      }

      post :create, params: course_params
      expect(response).to have_http_status(:created)
      
      course = Course.last
      expect(course.name).to eq('Math Course')
      expect(course.tutors.size).to eq(2)
      expect(course.tutors.pluck(:name)).to match_array(['Tutor A', 'Tutor B'])
    end

    it 'returns unprocessable_entity status when course creation fails' do
      course_params = {
        course: {
          name: nil,
          tutors_attributes: [
            { name: 'Tutor A' }
          ]
        }
      }

      post :create, params: course_params
      expect(response).to have_http_status(:unprocessable_entity)
      errors = JSON.parse(response.body)
      expect(errors['name']).to include("can't be blank")
    end
  end
end
