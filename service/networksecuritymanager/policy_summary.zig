const PolicyFirewallType = @import("policy_firewall_type.zig").PolicyFirewallType;
const EntityStatus = @import("entity_status.zig").EntityStatus;

/// Summary information about a policy.
pub const PolicySummary = struct {
    /// The firewall type associated with the resource.
    firewall_type: ?PolicyFirewallType = null,

    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: []const u8,

    /// The service-generated id of the policy.
    policy_id: []const u8,

    /// The name of the policy.
    policy_name: ?[]const u8 = null,

    /// The priority of the resource. A lower number indicates a higher priority.
    priority: ?i32 = null,

    /// The current status of the resource: `DRAFT` (unpublished, editable) or
    /// `ACTIVE` (published, in use).
    status: ?EntityStatus = null,

    /// The time when the resource was last updated. For a snapshot, this is the
    /// time when the snapshot was created.
    updated_at: ?i64 = null,

    /// The version of the resource.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_type = "firewallType",
        .has_published_version = "hasPublishedVersion",
        .policy_arn = "policyArn",
        .policy_id = "policyId",
        .policy_name = "policyName",
        .priority = "priority",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
