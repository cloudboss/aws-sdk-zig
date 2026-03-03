const CapabilityIssue = @import("capability_issue.zig").CapabilityIssue;

/// Health information for a capability, including any issues that may be
/// affecting its operation.
pub const CapabilityHealth = struct {
    /// A list of issues affecting the capability. If this list is empty, the
    /// capability is healthy.
    issues: ?[]const CapabilityIssue = null,

    pub const json_field_names = .{
        .issues = "issues",
    };
};
