const IpamPrefixListResolverRuleConditionRequest = @import("ipam_prefix_list_resolver_rule_condition_request.zig").IpamPrefixListResolverRuleConditionRequest;
const IpamResourceType = @import("ipam_resource_type.zig").IpamResourceType;
const IpamPrefixListResolverRuleType = @import("ipam_prefix_list_resolver_rule_type.zig").IpamPrefixListResolverRuleType;

/// Describes a CIDR selection rule to include in a request. This is used when
/// creating or modifying resolver rules.
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
pub const IpamPrefixListResolverRuleRequest = struct {
    /// The conditions that determine which CIDRs are selected by this rule.
    /// Conditions specify criteria such as resource type, tags, account IDs, and
    /// Regions.
    conditions: ?[]const IpamPrefixListResolverRuleConditionRequest,

    /// The ID of the IPAM scope from which to select CIDRs. This determines whether
    /// to select from public or private IP address space.
    ipam_scope_id: ?[]const u8,

    /// For rules of type `ipam-resource-cidr`, this is the resource type.
    resource_type: ?IpamResourceType,

    /// The type of CIDR selection rule. Valid values include `include` for
    /// selecting CIDRs that match the conditions, and `exclude` for excluding CIDRs
    /// that match the conditions.
    rule_type: IpamPrefixListResolverRuleType,

    /// A fixed list of CIDRs that do not change (like a manual list replicated
    /// across Regions).
    static_cidr: ?[]const u8,
};
