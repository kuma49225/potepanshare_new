module ApplicationHelper
    def custom_form_with(**args, &block)
      form_with(**args.merge(builder: CustomFormBuilder), &block)
    end
  end
  