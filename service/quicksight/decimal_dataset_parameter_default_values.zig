/// The default values of a decimal parameter.
pub const DecimalDatasetParameterDefaultValues = struct {
    /// A list of static default values for a given decimal parameter.
    static_values: ?[]const f64 = null,

    pub const json_field_names = .{
        .static_values = "StaticValues",
    };
};
