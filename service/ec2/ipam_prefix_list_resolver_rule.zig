const IpamPrefixListResolverRuleCondition = @import("ipam_prefix_list_resolver_rule_condition.zig").IpamPrefixListResolverRuleCondition;
const IpamResourceType = @import("ipam_resource_type.zig").IpamResourceType;
const IpamPrefixListResolverRuleType = @import("ipam_prefix_list_resolver_rule_type.zig").IpamPrefixListResolverRuleType;

/// Describes a CIDR selection rule.
///
/// CIDR selection rules define the business logic for selecting CIDRs from
/// IPAM. If a CIDR matches any of the rules, it will be included. If a rule has
/// multiple conditions, the CIDR has to match every condition of that rule. You
/// can create a prefix list resolver without any CIDR selection rules, but it
/// will generate empty versions (containing no CIDRs) until you add rules.
pub const IpamPrefixListResolverRule = struct {
    /// The conditions that determine which CIDRs are selected by this rule.
    /// Conditions specify criteria such as resource type, tags, account IDs, and
    /// Regions.
    conditions: ?[]const IpamPrefixListResolverRuleCondition,

    /// The ID of the IPAM scope from which to select CIDRs. This determines whether
    /// to select from public or private IP address space.
    ipam_scope_id: ?[]const u8,

    /// For rules of type `ipam-resource-cidr`, this is the resource type.
    resource_type: ?IpamResourceType,

    /// The type of CIDR selection rule. Valid values include `include` for
    /// selecting CIDRs that match the conditions, and `exclude` for excluding CIDRs
    /// that match the conditions.
    rule_type: ?IpamPrefixListResolverRuleType,

    /// A fixed list of CIDRs that do not change (like a manual list replicated
    /// across Regions).
    static_cidr: ?[]const u8,
};
