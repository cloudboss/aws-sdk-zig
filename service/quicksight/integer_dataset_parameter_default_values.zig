/// The default values of an integer parameter.
pub const IntegerDatasetParameterDefaultValues = struct {
    /// A list of static default values for a given integer parameter.
    static_values: ?[]const i64,

    pub const json_field_names = .{
        .static_values = "StaticValues",
    };
};
