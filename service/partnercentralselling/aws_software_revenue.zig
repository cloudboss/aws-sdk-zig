const MonetaryValue = @import("monetary_value.zig").MonetaryValue;

/// Seller-provided PARC deal terms for the opportunity, including commitment
/// value, discount percentage, and contract dates.
pub const AwsSoftwareRevenue = struct {
    /// Discount percentage offered on the software revenue. Percent convention:
    /// 15.00 means 15%.
    discount: ?[]const u8 = null,

    /// Contract effective (start) date in YYYY-MM-DD format.
    effective_date: ?[]const u8 = null,

    /// Contract expiration (end) date in YYYY-MM-DD format.
    expiration_date: ?[]const u8 = null,

    value: ?MonetaryValue = null,

    pub const json_field_names = .{
        .discount = "Discount",
        .effective_date = "EffectiveDate",
        .expiration_date = "ExpirationDate",
        .value = "Value",
    };
};
