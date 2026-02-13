/// Defines the values for a task parameter.
pub const MaintenanceWindowTaskParameterValueExpression = struct {
    /// This field contains an array of 0 or more strings, each 1 to 255 characters
    /// in
    /// length.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .values = "Values",
    };
};
