module GeoCerts
  class Order < ApiObject
    
    ##
    # Used for setting or retrieving the required approver information when using extended 
    # validation certificates in a GeoCerts::Order.
    # 
    class ExtendedValidationApprover < Contact
      
      def to_geocerts_hash #:nodoc:
        {
          :ev_approver_first_name   => GeoCerts.escape(self.first_name),
          :ev_approver_last_name    => GeoCerts.escape(self.last_name),
          :ev_approver_title        => GeoCerts.escape(self.title),
          :ev_approver_phone        => GeoCerts.escape(self.phone),
          :ev_approver_email        => GeoCerts.escape(self.email)
        }
      end
      
    end
    
  end
end
