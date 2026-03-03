const PolicySummary = @import("policy_summary.zig").PolicySummary;

/// Contains rules to be applied to the affected accounts. Policies can be
/// attached
/// directly to accounts, or to roots and OUs to affect all accounts in those
/// hierarchies.
pub const Policy = struct {
    /// The text content of the policy.
    content: ?[]const u8 = null,

    /// A structure that contains additional details about the policy.
    policy_summary: ?PolicySummary = null,

    pub const json_field_names = .{
        .content = "Content",
        .policy_summary = "PolicySummary",
    };
};
