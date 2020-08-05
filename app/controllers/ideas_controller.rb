class IdeasController < ApplicationController
    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    # before_action is a controller hook provided by rails
    # 1 - it accepts a method name
    # 2 - options hash
    before_action :authenticate_user!, except: [:index, :show]
    # will call authenticate_user! before every method except :index, and :show
    before_action :authorize!, only: [:edit, :update, :destroy]
    
    def index
        #if params[:tag]
          #  @tag = Tag.find_or_initialize_by(name: params[:tag])
          #  @questions = @tag.questions.all_with_answer_counts.order('updated_at DESC')
        #else
            @ideas = Idea.all
       # end
    end

    def new
        @idea = Idea.new
    end
    def create

        @idea = Idea.new idea_params 
        @idea.user = current_user
        if @idea.save
            flash[:notice] = 'Idea created successfully'
            # if question is saved successfully, redirect to question show page with that question
            redirect_to idea_path(@idea)
        else 
            # render views/questions/new.html.erb
            render :new 
        end
    end

    def show
       
        @review = Review.new
       

        @reviews = @idea.reviews.order(created_at: :desc)

        #@like = @question.likes.find_by(user: current_user)
    end

    def index
        #if params[:tag]
          #  @tag = Tag.find_or_initialize_by(name: params[:tag])
          #  @questions = @tag.questions.all_with_answer_counts.order('updated_at DESC')
        #else
            @ideas = Idea.all
       # end
    end

    def edit
    end 

    def update
       
        if @idea.update idea_params
            redirect_to idea_path(@idea)
        else
            render :edit
        end

    end

    def destroy 
        flash[:notice] = "Idea destroyed!"
        @idea.destroy 
        redirect_to ideas_path
    end

    #def liked 
        # all the question that this particular logged in user has liked
       # @questions = current_user.liked_questions.all_with_answer_counts.order(created_at: :desc)
   # end

    private 

    def idea_params
         
        params.require(:idea).permit(:title, :description)
    end

    def find_idea
        # get the Question with the id that's requested
        @idea = Idea.find params[:id]
    end

    def authorize! 
       redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @idea)
    end


end
