/// Details about the usage.
pub const Usage = struct {
    /// The operation value.
    operation: ?[]const u8,

    /// The product code.
    product_code: ?[]const u8,

    /// The usage unit.
    unit: ?[]const u8,

    /// The usage amount.
    usage_amount: ?f64,

    /// The usage type.
    usage_type: ?[]const u8,

    pub const json_field_names = .{
        .operation = "operation",
        .product_code = "productCode",
        .unit = "unit",
        .usage_amount = "usageAmount",
        .usage_type = "usageType",
    };
};
