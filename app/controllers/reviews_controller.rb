class ReviewsController < ApplicationController
    def create 
        #byebug
        @idea = Idea.find params[:idea_id]
        
        @review = Review.new review_params
        @review.user=current_user
        @review.idea = @idea 
      
        if @review.save
    
            redirect_to idea_path(@idea)
        else 

            @ideas = @idea.reviews.order(created_at: :desc)
            render 'ideas/show'
        end
    end

    def destroy
       
        @review = Review.find params[:id]
       
            @review.destroy 
            redirect_to idea_path(@review.idea)
    end

    private

    def review_params 
        params.require(:review).permit(:body)
    end
end
