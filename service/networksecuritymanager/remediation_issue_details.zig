/// Details about a remediation issue for a firewall type.
pub const RemediationIssueDetails = struct {
    /// A recommended action for resolving the remediation issue.
    corrective_action: ?[]const u8 = null,

    /// The type of remediation issue.
    issue_type: ?[]const u8 = null,

    /// A human-readable description of the remediation issue.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .corrective_action = "correctiveAction",
        .issue_type = "issueType",
        .message = "message",
    };
};
