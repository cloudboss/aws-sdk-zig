const AutoApprovalRule = @import("auto_approval_rule.zig").AutoApprovalRule;

/// Configuration for the registry's record approval workflow. Controls whether
/// records submitted for approval require manual review before they become
/// approved and discoverable, or are auto-approved. When no auto-approval rules
/// are configured, submitted records require manual review.
pub const ApprovalConfiguration = struct {
    /// The rules that determine which registry records are automatically approved
    /// on submission. When omitted or empty, submitted records require manual
    /// review.
    auto_approval_rules: ?[]const AutoApprovalRule = null,

    pub const json_field_names = .{
        .auto_approval_rules = "autoApprovalRules",
    };
};
