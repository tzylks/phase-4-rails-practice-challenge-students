class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :error_record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
    
    def index
        students = Student.all
        render json: students
    end

    def show
        student = find_inst
        render json: student
    end

    def update
        student = find_inst
        student.update!(instructor_params)
        render json: student
    end

    def create
        new = Student.create!(instructor_params)
        render json: new
    end

    def destroy
        die = find_inst
        die.destroy
        head :no_content
    end

    private

    def render_not_found
        render json: { error: "Student not found" }, status: :not_found
    end

    def error_record_invalid(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

    def find_inst
        Student.find(params[:id])
    end

    def instructor_params
        params.permit(:name, :major, :age, :instructor_id)
    end

end
