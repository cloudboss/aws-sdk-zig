const ShareStatus = @import("share_status.zig").ShareStatus;

/// Minimal high-level information for a firewall rule group. The action
/// ListFirewallRuleGroups returns an array of these objects.
///
/// To retrieve full information for a firewall rule group, call
/// GetFirewallRuleGroup and ListFirewallRules.
pub const FirewallRuleGroupMetadata = struct {
    /// The ARN (Amazon Resource Name) of the rule group.
    arn: ?[]const u8 = null,

    /// A unique string defined by you to identify the request. This allows you to
    /// retry failed
    /// requests without the risk of running the operation twice. This can be any
    /// unique string,
    /// for example, a timestamp.
    creator_request_id: ?[]const u8 = null,

    /// The ID of the rule group.
    id: ?[]const u8 = null,

    /// The name of the rule group.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID for the account that created the rule
    /// group. When a rule group is shared with your account,
    /// this is the account that has shared the rule group with you.
    owner_id: ?[]const u8 = null,

    /// Whether the rule group is shared with other Amazon Web Services accounts, or
    /// was shared with the current account by another
    /// Amazon Web Services account. Sharing is configured through Resource Access
    /// Manager (RAM).
    share_status: ?ShareStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creator_request_id = "CreatorRequestId",
        .id = "Id",
        .name = "Name",
        .owner_id = "OwnerId",
        .share_status = "ShareStatus",
    };
};
