/// Information about targets that resolved during the Automation execution.
pub const ResolvedTargets = struct {
    /// A list of parameter values sent to targets that resolved during the
    /// Automation
    /// execution.
    parameter_values: ?[]const []const u8,

    /// A boolean value indicating whether the resolved target list is truncated.
    truncated: ?bool,

    pub const json_field_names = .{
        .parameter_values = "ParameterValues",
        .truncated = "Truncated",
    };
};
