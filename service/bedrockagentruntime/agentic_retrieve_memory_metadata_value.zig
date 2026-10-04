/// A metadata value that a filter expression compares against. Set exactly one
/// member.
pub const AgenticRetrieveMemoryMetadataValue = union(enum) {
    /// A timestamp value in ISO 8601 UTC format.
    date_time_value: ?i64,
    /// A numeric value.
    number_value: ?f64,
    /// A list of string values.
    string_list_value: ?[]const []const u8,
    /// A string value.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .date_time_value = "dateTimeValue",
        .number_value = "numberValue",
        .string_list_value = "stringListValue",
        .string_value = "stringValue",
    };
};
