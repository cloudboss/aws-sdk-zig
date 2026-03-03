/// The configuration that overrides the existing default values for a dataset
/// parameter that is inherited from another dataset.
pub const NewDefaultValues = struct {
    /// A list of static default values for a given date time parameter.
    date_time_static_values: ?[]const i64 = null,

    /// A list of static default values for a given decimal parameter.
    decimal_static_values: ?[]const f64 = null,

    /// A list of static default values for a given integer parameter.
    integer_static_values: ?[]const i64 = null,

    /// A list of static default values for a given string parameter.
    string_static_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .date_time_static_values = "DateTimeStaticValues",
        .decimal_static_values = "DecimalStaticValues",
        .integer_static_values = "IntegerStaticValues",
        .string_static_values = "StringStaticValues",
    };
};
