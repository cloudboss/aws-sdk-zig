const EmptyFieldValue = @import("empty_field_value.zig").EmptyFieldValue;

/// Object to store union of Field values.
///
/// The `Summary` system field accepts 3000 characters while all other fields
/// accept 500 characters.
pub const FieldValueUnion = union(enum) {
    /// Can be either null, or have a Boolean value type. Only one value can be
    /// provided.
    boolean_value: ?bool,
    /// Can be either null, or have a Double number value type. Only one value can
    /// be provided.
    double_value: ?f64,
    /// An empty value.
    empty_value: ?EmptyFieldValue,
    /// String value type.
    string_value: ?[]const u8,
    /// Represents the user that performed the audit.
    user_arn_value: ?[]const u8,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .empty_value = "emptyValue",
        .string_value = "stringValue",
        .user_arn_value = "userArnValue",
    };
};
