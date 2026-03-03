/// The EntitlementValue represents the amount of capacity that the customer is
/// entitled to
/// for the product.
pub const EntitlementValue = struct {
    /// The BooleanValue field will be populated with a boolean value when the
    /// entitlement is a
    /// boolean type. Otherwise, the field will not be set.
    boolean_value: ?bool = null,

    /// The DoubleValue field will be populated with a double value when the
    /// entitlement is a
    /// double type. Otherwise, the field will not be set.
    double_value: ?f64 = null,

    /// The IntegerValue field will be populated with an integer value when the
    /// entitlement is an
    /// integer type. Otherwise, the field will not be set.
    integer_value: ?i32 = null,

    /// The StringValue field will be populated with a string value when the
    /// entitlement is a
    /// string type. Otherwise, the field will not be set.
    string_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .boolean_value = "BooleanValue",
        .double_value = "DoubleValue",
        .integer_value = "IntegerValue",
        .string_value = "StringValue",
    };
};
