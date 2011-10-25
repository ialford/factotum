class AcquisitionMailer < ActionMailer::Base
  default :from => "monoacqorder@library.nd.edu"
  
  def monographic_submission(order)
    @order = order
    add_paperclip_attachment(@order.attachment)
    mail :to => monographic_submission_recipient(), :subject => "Monographic Order Form: #{order.title}"
  end
  
  def monographic_confirmation(order, user)
    @order = order
    add_paperclip_attachment(@order.attachment)
    mail :to => user.email, :subject => "Monographic Order Form Confirmation: #{order.title}"
  end
  
  private
    def monographic_submission_recipient
      if Rails.env == "production"
        "monoacqorder@library.nd.edu"
      else
        "jkennel@nd.edu"
      end
    end
    
    def add_paperclip_attachment(paperclip_attachment)
      if paperclip_attachment.present?
        desired_content_type = paperclip_attachment.content_type
        if desired_content_type =~ /^text\/(plain|html)$/
          desired_content_type = "application/octet-stream"
        end
        attachments[paperclip_attachment.original_filename] = {
          :mime_type => desired_content_type,
          :content => File.read(paperclip_attachment.path)
        }
      end
    end
end