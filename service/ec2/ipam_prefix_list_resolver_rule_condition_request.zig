const IpamPrefixListResolverRuleConditionOperation = @import("ipam_prefix_list_resolver_rule_condition_operation.zig").IpamPrefixListResolverRuleConditionOperation;
const RequestIpamResourceTag = @import("request_ipam_resource_tag.zig").RequestIpamResourceTag;

/// Describes a condition used when creating or modifying resolver rules.
///
/// CIDR selection rules define the business logic for selecting CIDRs from
/// IPAM. If a CIDR matches any of the rules, it will be included. If a rule has
/// multiple conditions, the CIDR has to match every condition of that rule. You
/// can create a prefix list resolver without any CIDR selection rules, but it
/// will generate empty versions (containing no CIDRs) until you add rules.
///
/// There are three rule types. Only 2 of the 3 rule types support conditions -
/// **IPAM pool CIDR** and **Scope resource CIDR**. **Static CIDR** rules cannot
/// have conditions.
///
/// * **Static CIDR**: A fixed list of CIDRs that do not change (like a manual
///   list replicated across Regions)
///
/// * **IPAM pool CIDR**: CIDRs from specific IPAM pools (like all CIDRs from
///   your IPAM production pool)
///
/// If you choose this option, choose the following:
///
/// * **IPAM scope**: Select the IPAM scope to search for resources
///
/// * **Conditions:**
///
/// * **Property**
///
/// * **IPAM pool ID**: Select an IPAM pool that contains the resources
///
/// * **CIDR** (like 10.24.34.0/23)
///
/// * **Operation**: Equals/Not equals
///
/// * **Value**: The value on which to match the condition
///
/// * **Scope resource CIDR**: CIDRs from Amazon Web Services resources like
///   VPCs, subnets, EIPs within an IPAM scope
///
/// If you choose this option, choose the following:
///
/// * **IPAM scope**: Select the IPAM scope to search for resources
///
/// * **Resource type**: Select a resource, like a VPC or subnet.
///
/// * **Conditions**:
///
/// * **Property**:
///
/// * Resource ID: The unique ID of a resource (like vpc-1234567890abcdef0)
///
/// * Resource owner (like 111122223333)
///
/// * Resource region (like us-east-1)
///
/// * Resource tag (like key: name, value: dev-vpc-1)
///
/// * CIDR (like 10.24.34.0/23)
///
/// * **Operation**: Equals/Not equals
///
/// * **Value**: The value on which to match the condition
pub const IpamPrefixListResolverRuleConditionRequest = struct {
    /// A CIDR block to match against. This condition selects CIDRs that fall within
    /// or match the specified CIDR range.
    cidr: ?[]const u8,

    /// The ID of the IPAM pool to match against. This condition selects CIDRs that
    /// belong to the specified IPAM pool.
    ipam_pool_id: ?[]const u8,

    /// The operation to perform when evaluating this condition.
    operation: IpamPrefixListResolverRuleConditionOperation,

    /// The ID of the Amazon Web Services resource to match against. This condition
    /// selects CIDRs associated with the specified resource.
    resource_id: ?[]const u8,

    /// The Amazon Web Services account ID that owns the resources to match against.
    /// This condition selects CIDRs from resources owned by the specified account.
    resource_owner: ?[]const u8,

    /// The Amazon Web Services Region where the resources are located. This
    /// condition selects CIDRs from resources in the specified Region.
    resource_region: ?[]const u8,

    /// A tag key-value pair to match against. This condition selects CIDRs from
    /// resources that have the specified tag.
    resource_tag: ?RequestIpamResourceTag,
};
