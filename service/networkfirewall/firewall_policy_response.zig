const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const Tag = @import("tag.zig").Tag;

/// The high-level properties of a firewall policy. This, along with the
/// FirewallPolicy, define the policy. You can retrieve all objects for a
/// firewall policy by calling DescribeFirewallPolicy.
pub const FirewallPolicyResponse = struct {
    /// The number of capacity units currently consumed by the policy's stateful
    /// rules.
    consumed_stateful_rule_capacity: ?i32 = null,

    /// The number of capacity units currently consumed by the policy's stateless
    /// rules.
    consumed_stateless_rule_capacity: ?i32 = null,

    /// A description of the firewall policy.
    description: ?[]const u8 = null,

    /// A complex type that contains the Amazon Web Services KMS encryption
    /// configuration settings for your firewall policy.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The Amazon Resource Name (ARN) of the firewall policy.
    ///
    /// If this response is for a create request that had `DryRun` set to
    /// `TRUE`, then this ARN is a placeholder that isn't attached to a valid
    /// resource.
    firewall_policy_arn: []const u8,

    /// The unique identifier for the firewall policy.
    firewall_policy_id: []const u8,

    /// The descriptive name of the firewall policy. You can't change the name of a
    /// firewall policy after you create it.
    firewall_policy_name: []const u8,

    /// The current status of the firewall policy. You can retrieve this for a
    /// firewall policy
    /// by calling DescribeFirewallPolicy and providing the firewall policy's
    /// name or ARN.
    firewall_policy_status: ?ResourceStatus = null,

    /// The last time that the firewall policy was changed.
    last_modified_time: ?i64 = null,

    /// The number of firewalls that are associated with this firewall policy.
    number_of_associations: ?i32 = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .consumed_stateful_rule_capacity = "ConsumedStatefulRuleCapacity",
        .consumed_stateless_rule_capacity = "ConsumedStatelessRuleCapacity",
        .description = "Description",
        .encryption_configuration = "EncryptionConfiguration",
        .firewall_policy_arn = "FirewallPolicyArn",
        .firewall_policy_id = "FirewallPolicyId",
        .firewall_policy_name = "FirewallPolicyName",
        .firewall_policy_status = "FirewallPolicyStatus",
        .last_modified_time = "LastModifiedTime",
        .number_of_associations = "NumberOfAssociations",
        .tags = "Tags",
    };
};
