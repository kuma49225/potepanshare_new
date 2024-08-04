class CustomFormBuilder < ActionView::Helpers::FormBuilder
    include ActionView::Helpers::TagHelper
  
    def text_field(method, options = {})
      field_with_errors(method) do
        super(method, options.merge(class: "form-control"))
      end
    end
  
    def date_field(method, options = {})
      field_with_errors(method) do
        super(method, options.merge(class: "form-control"))
      end
    end
  
    def number_field(method, options = {})
      field_with_errors(method) do
        super(method, options.merge(class: "form-control"))
      end
    end
  
    private
  
    def field_with_errors(method)
      error_messages = object.errors.full_messages_for(method).map do |msg|
        @template.content_tag(:div, msg, class: 'text-danger error-messages')
      end.join.html_safe
  
      @template.content_tag(:div, class: 'form-group custom-form-group') do
        yield + error_messages
      end
    end
  end
  