const RevenueModel = @import("revenue_model.zig").RevenueModel;
const MonetaryValue = @import("monetary_value.zig").MonetaryValue;

/// Specifies a customer's procurement terms details. Required only for partners
/// in eligible programs.
pub const SoftwareRevenue = struct {
    /// Specifies the customer's intended payment type agreement or procurement
    /// method to acquire the solution or service outlined in the `Opportunity`.
    delivery_model: ?RevenueModel = null,

    /// Specifies the `Opportunity`'s customer engagement start date for the
    /// contract's effectiveness.
    effective_date: ?[]const u8 = null,

    /// Specifies the expiration date for the contract between the customer and
    /// Amazon Web Services partner. It signifies the termination date of the
    /// agreed-upon engagement period between both parties.
    expiration_date: ?[]const u8 = null,

    /// Specifies the payment value (amount and currency).
    value: ?MonetaryValue = null,

    pub const json_field_names = .{
        .delivery_model = "DeliveryModel",
        .effective_date = "EffectiveDate",
        .expiration_date = "ExpirationDate",
        .value = "Value",
    };
};
