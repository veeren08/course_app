class Api::V1::CoursesController < ApplicationController

	def index
    @courses = Course.includes(:tutors)

    render json: @courses, include: :tutors
  end

  def create
    course_params = params.require(:course).permit(:name, tutors_attributes: [:name])
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  private

	def course_params
    params.require(:course).permit(:name, tutors_attributes: [:name])
  end
end
  