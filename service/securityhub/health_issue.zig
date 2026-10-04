const HealthIssueCode = @import("health_issue_code.zig").HealthIssueCode;

/// Represents a specific health issue detected for a connector.
pub const HealthIssue = struct {
    /// The error code that identifies the type of health issue.
    code: HealthIssueCode,

    /// A human-readable message that describes the health issue.
    message: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
