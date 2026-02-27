/// Represents the data for a typed attribute. You can set one, and only one, of
/// the
/// elements. Each attribute in an item is a name-value pair. Attributes have a
/// single
/// value.
pub const TypedAttributeValue = union(enum) {
    /// A binary data value.
    binary_value: ?[]const u8,
    /// A Boolean data value.
    boolean_value: ?bool,
    /// A date and time value.
    datetime_value: ?i64,
    /// A number data value.
    number_value: ?[]const u8,
    /// A string data value.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .binary_value = "BinaryValue",
        .boolean_value = "BooleanValue",
        .datetime_value = "DatetimeValue",
        .number_value = "NumberValue",
        .string_value = "StringValue",
    };
};
