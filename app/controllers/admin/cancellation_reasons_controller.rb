module Admin
  class CancellationReasonsController < BaseController

    include Pagy::Backend

    before_action :load_cancellation_reason, only:  [ :show, :edit, :update, :destroy ]

    def index
      @pagy, @cancellation_reasons = pagy(CancellationReason.order(:name), limit: 6)
    end

    def new
      @cancellation_reason = CancellationReason.new
    end

    def show; end

    def edit; end

    def create
      @cancellation_reason = CancellationReason.new(cancellation_reason_params)
      if @cancellation_reason.save
        redirect_to admin_cancellation_reasons_path, notice: "cancellation_reason successfully created"
      else
        render 'new', status: :unprocessable_entity
      end
    end

    def update
      if @cancellation_reason.update(cancellation_reason_params)
        redirect_to admin_cancellation_reasons_path, notice: "cancellation_reason was successfully updated"
      else
        render 'edit', status: :unprocessable_entity
      end
    end

    def destroy
      if @cancellation_reason.destroy
        redirect_to cancellation_reasons_url, notice: 'cancellation_reason was successfully deleted.'
      else
        redirect_to cancellation_reasons_url, error: 'Something went wrong'
      end
    end

    private

    def load_cancellation_reason
      @cancellation_reason = CancellationReason.find(params[:id])
    end

    def cancellation_reason_params
      params.require(:cancellation_reason).permit(:name, :description)
    end
  end
end
