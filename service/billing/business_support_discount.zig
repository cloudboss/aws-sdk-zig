/// A discount applied to a Business Support account charge, including the
/// discount amount, percentage, type, and source.
pub const BusinessSupportDiscount = struct {
    /// The discount amount applied to the Business Support charge. This value is
    /// negative, representing a reduction in the charge.
    discount_amount: ?[]const u8 = null,

    /// The discount percentage applied to the Business Support charge, expressed as
    /// a decimal (for example, `0.12` for a 12% discount).
    discount_percentage: ?[]const u8 = null,

    /// The source or program through which the discount was applied.
    discount_source: ?[]const u8 = null,

    /// The type of discount applied. Valid values: `Distributor_Discount` (a
    /// discount applied through a distributor arrangement), `SPP_Discount` (a
    /// discount applied through the Solution Provider Program).
    discount_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .discount_amount = "discountAmount",
        .discount_percentage = "discountPercentage",
        .discount_source = "discountSource",
        .discount_type = "discountType",
    };
};
