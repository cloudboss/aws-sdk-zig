const CapabilityIssueCode = @import("capability_issue_code.zig").CapabilityIssueCode;

/// An issue affecting a capability's health or operation.
pub const CapabilityIssue = struct {
    /// A code identifying the type of issue. This can be used to programmatically
    /// handle specific issue types.
    code: ?CapabilityIssueCode = null,

    /// A human-readable message describing the issue and potential remediation
    /// steps.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
