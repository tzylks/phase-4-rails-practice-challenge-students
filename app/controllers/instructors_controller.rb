class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :error_record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :error_not_found
    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
        instructor = find_inst
        render json: instructor, status: :ok
    end

    def update
        instructor = find_inst
        instructor.update!(instructor_params)
        render json: instructor, status: :accepted
    end

    def create
        new = Instructor.create!(instructor_params)
        render json: new, status: :created
    end

    def destroy
        die = find_inst
        die.destroy
        head :no_content
    end

    private

    def error_not_found
        errors.add(errors: "not found")
    end

    def error_record_invalid(invalid)
        errors.add(errors. invalid.record.errors.full_message)
    end

    def find_inst
        Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

end
