const IsraelCustomerType = @import("israel_customer_type.zig").IsraelCustomerType;
const IsraelDealerType = @import("israel_dealer_type.zig").IsraelDealerType;

/// Additional tax information associated with your TRN in Israel.
pub const IsraelAdditionalInfo = struct {
    /// Customer type for your TRN in Israel. The value can be `Business` or
    /// `Individual`. Use `Business`for entities such as not-for-profit and
    /// financial institutions.
    customer_type: IsraelCustomerType,

    /// Dealer type for your TRN in Israel. If you're not a local authorized dealer
    /// with an
    /// Israeli VAT ID, specify your tax identification number so that Amazon Web
    /// Services can send you
    /// a compliant tax invoice.
    dealer_type: IsraelDealerType,

    pub const json_field_names = .{
        .customer_type = "customerType",
        .dealer_type = "dealerType",
    };
};
