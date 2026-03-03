const PropertyValueNullValue = @import("property_value_null_value.zig").PropertyValueNullValue;

/// Contains an asset property value (of a single type only).
pub const Variant = struct {
    /// Asset property data of type Boolean (true or false).
    boolean_value: ?bool = null,

    /// Asset property data of type double (floating point number). The min value is
    /// -10^10. The
    /// max value is 10^10. Double.NaN is allowed.
    double_value: ?f64 = null,

    /// Asset property data of type integer (whole number).
    integer_value: ?i32 = null,

    /// The type of null asset property data with BAD and UNCERTAIN qualities.
    null_value: ?PropertyValueNullValue = null,

    /// Asset property data of type string (sequence of characters). The allowed
    /// pattern:
    /// "^$|[^\u0000-\u001F\u007F]+". The max length is 1024.
    string_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .integer_value = "integerValue",
        .null_value = "nullValue",
        .string_value = "stringValue",
    };
};
