/// The default values of a date time parameter.
pub const DateTimeDatasetParameterDefaultValues = struct {
    /// A list of static default values for a given date time parameter.
    static_values: ?[]const i64,

    pub const json_field_names = .{
        .static_values = "StaticValues",
    };
};
