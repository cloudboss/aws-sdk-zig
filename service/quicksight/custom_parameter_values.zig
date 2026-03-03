/// The customized parameter values.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const CustomParameterValues = struct {
    /// A list of datetime-type parameter values.
    date_time_values: ?[]const i64 = null,

    /// A list of decimal-type parameter values.
    decimal_values: ?[]const f64 = null,

    /// A list of integer-type parameter values.
    integer_values: ?[]const i64 = null,

    /// A list of string-type parameter values.
    string_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .date_time_values = "DateTimeValues",
        .decimal_values = "DecimalValues",
        .integer_values = "IntegerValues",
        .string_values = "StringValues",
    };
};
