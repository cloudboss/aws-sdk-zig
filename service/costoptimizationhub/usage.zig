/// Details about the usage.
pub const Usage = struct {
    /// The operation value.
    operation: ?[]const u8 = null,

    /// The product code.
    product_code: ?[]const u8 = null,

    /// The usage unit.
    unit: ?[]const u8 = null,

    /// The usage amount.
    usage_amount: ?f64 = null,

    /// The usage type.
    usage_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .operation = "operation",
        .product_code = "productCode",
        .unit = "unit",
        .usage_amount = "usageAmount",
        .usage_type = "usageType",
    };
};
