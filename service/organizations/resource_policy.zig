const ResourcePolicySummary = @import("resource_policy_summary.zig").ResourcePolicySummary;

/// A structure that contains details about a resource policy.
pub const ResourcePolicy = struct {
    /// The policy text of the resource policy.
    content: ?[]const u8,

    /// A structure that contains resource policy ID and Amazon Resource Name (ARN).
    resource_policy_summary: ?ResourcePolicySummary,

    pub const json_field_names = .{
        .content = "Content",
        .resource_policy_summary = "ResourcePolicySummary",
    };
};
