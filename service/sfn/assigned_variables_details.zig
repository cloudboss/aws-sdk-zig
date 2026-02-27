/// Provides details about assigned variables in an execution history event.
pub const AssignedVariablesDetails = struct {
    /// Indicates whether assigned variables were truncated in the response. Always
    /// `false`
    /// for API calls. In CloudWatch logs, the value will be true if the data is
    /// truncated due to size limits.
    truncated: bool = false,

    pub const json_field_names = .{
        .truncated = "truncated",
    };
};
