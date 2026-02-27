const EmptyFieldValue = @import("empty_field_value.zig").EmptyFieldValue;

/// Object to store union of Field values.
pub const AuditEventFieldValueUnion = union(enum) {
    /// Can be either null, or have a Boolean value type. Only one value can be
    /// provided.
    boolean_value: ?bool,
    /// Can be either null, or have a Double value type. Only one value can be
    /// provided.
    double_value: ?f64,
    empty_value: ?EmptyFieldValue,
    /// Can be either null, or have a String value type. Only one value can be
    /// provided.
    string_value: ?[]const u8,
    /// Can be either null, or have a String value type formatted as an ARN. Only
    /// one value can be provided.
    user_arn_value: ?[]const u8,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .empty_value = "emptyValue",
        .string_value = "stringValue",
        .user_arn_value = "userArnValue",
    };
};
