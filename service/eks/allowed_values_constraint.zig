/// A constraint specifying the allowed values for a parameter.
pub const AllowedValuesConstraint = struct {
    /// The list of allowed values.
    allowed_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
    };
};
