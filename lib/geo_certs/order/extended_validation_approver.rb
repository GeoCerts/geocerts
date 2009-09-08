module GeoCerts
  class Order < ApiObject
    
    class ExtendedValidationApprover < Contact
      
      def to_geocerts_hash
        {
          :ev_approver_first_name   => self.first_name,
          :ev_approver_last_name    => self.last_name,
          :ev_approver_title        => self.title,
          :ev_approver_phone        => self.phone,
          :ev_approver_email        => self.email
        }
      end
      
    end
    
  end
end
