/// The default values of a string parameter.
pub const StringDatasetParameterDefaultValues = struct {
    /// A list of static default values for a given string parameter.
    static_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .static_values = "StaticValues",
    };
};
