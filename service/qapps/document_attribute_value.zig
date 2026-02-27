/// The value of a document attribute. You can only provide one value for a
/// document attribute.
pub const DocumentAttributeValue = union(enum) {
    /// A date expressed as an ISO 8601 string.
    ///
    /// It's important for the time zone to be included in the *ISO 8601 date-time*
    /// format. For example, 2012-03-25T12:30:10+01:00 is the ISO 8601 date-time
    /// format for March 25th 2012 at 12:30PM (plus 10 seconds) in Central European
    /// Time.
    date_value: ?i64,
    /// A long integer value.
    long_value: ?i64,
    /// A list of strings.
    string_list_value: ?[]const []const u8,
    /// A string.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .date_value = "dateValue",
        .long_value = "longValue",
        .string_list_value = "stringListValue",
        .string_value = "stringValue",
    };
};
