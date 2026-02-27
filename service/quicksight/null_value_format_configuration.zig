/// The options that determine the null value format configuration.
pub const NullValueFormatConfiguration = struct {
    /// Determines the null string of null values.
    null_string: []const u8,

    pub const json_field_names = .{
        .null_string = "NullString",
    };
};
