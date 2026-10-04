/// A high-level remediation summary returned in the detail response.
pub const RemediationSummary = struct {
    /// A short imperative statement of the recommended action.
    recommendation: []const u8,

    /// High-level steps to implement the fix.
    steps: []const []const u8,

    pub const json_field_names = .{
        .recommendation = "recommendation",
        .steps = "steps",
    };
};
