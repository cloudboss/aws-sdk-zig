const RuleGroupsNamespaceStatusCode = @import("rule_groups_namespace_status_code.zig").RuleGroupsNamespaceStatusCode;

/// The status information about a rule groups namespace.
pub const RuleGroupsNamespaceStatus = struct {
    /// The current status of the namespace.
    status_code: RuleGroupsNamespaceStatusCode,

    /// The reason for the failure, if any.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
