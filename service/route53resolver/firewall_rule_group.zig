const ShareStatus = @import("share_status.zig").ShareStatus;
const FirewallRuleGroupStatus = @import("firewall_rule_group_status.zig").FirewallRuleGroupStatus;

/// High-level information for a firewall rule group. A firewall rule group is a
/// collection of rules that DNS Firewall uses to filter DNS network traffic for
/// a VPC. To retrieve the rules for the rule group, call ListFirewallRules.
pub const FirewallRuleGroup = struct {
    /// The ARN (Amazon Resource Name) of the rule group.
    arn: ?[]const u8,

    /// The date and time that the rule group was created, in Unix time format and
    /// Coordinated Universal Time (UTC).
    creation_time: ?[]const u8,

    /// A unique string defined by you to identify the request. This allows you to
    /// retry failed
    /// requests without the risk of running the operation twice. This can be any
    /// unique string,
    /// for example, a timestamp.
    creator_request_id: ?[]const u8,

    /// The ID of the rule group.
    id: ?[]const u8,

    /// The date and time that the rule group was last modified, in Unix time format
    /// and Coordinated Universal Time (UTC).
    modification_time: ?[]const u8,

    /// The name of the rule group.
    name: ?[]const u8,

    /// The Amazon Web Services account ID for the account that created the rule
    /// group. When a rule group is shared with your account,
    /// this is the account that has shared the rule group with you.
    owner_id: ?[]const u8,

    /// The number of rules in the rule group.
    rule_count: ?i32,

    /// Whether the rule group is shared with other Amazon Web Services accounts, or
    /// was shared with the current account by another
    /// Amazon Web Services account. Sharing is configured through Resource Access
    /// Manager (RAM).
    share_status: ?ShareStatus,

    /// The status of the domain list.
    status: ?FirewallRuleGroupStatus,

    /// Additional information about the status of the rule group, if available.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .id = "Id",
        .modification_time = "ModificationTime",
        .name = "Name",
        .owner_id = "OwnerId",
        .rule_count = "RuleCount",
        .share_status = "ShareStatus",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
