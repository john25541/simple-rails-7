class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update destroy]

  def index
    @jobs = Job.all
    @job = Job.new
  end

  def show; end

  def create
    @job = Job.new(job_params)
    if @job.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to jobs_path }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { render :new }
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    if @job.update(job_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to jobs_path }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("job_form", partial: "jobs/form", locals: { job: @job }) }
        format.html { render :edit }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to jobs_path }
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description)
  end
end
