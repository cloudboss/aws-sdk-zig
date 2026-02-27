/// A structure that contains the configuration settings for an issue detection
/// task.
pub const IssueDetectionConfiguration = struct {
    /// The name of the issue detection rule.
    rule_name: []const u8,

    pub const json_field_names = .{
        .rule_name = "RuleName",
    };
};
