class WelcomeController < ApplicationController
  def import
    importer = Importer.new(import_options)
    importer.process
    render text: 'Import successful.'
  end

  private

  def import_options
    params.permit(:csv)
  end
end
