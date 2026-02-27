const RuleGroupSourceStatelessRuleMatchAttributesDestinationPorts = @import("rule_group_source_stateless_rule_match_attributes_destination_ports.zig").RuleGroupSourceStatelessRuleMatchAttributesDestinationPorts;
const RuleGroupSourceStatelessRuleMatchAttributesDestinations = @import("rule_group_source_stateless_rule_match_attributes_destinations.zig").RuleGroupSourceStatelessRuleMatchAttributesDestinations;
const RuleGroupSourceStatelessRuleMatchAttributesSourcePorts = @import("rule_group_source_stateless_rule_match_attributes_source_ports.zig").RuleGroupSourceStatelessRuleMatchAttributesSourcePorts;
const RuleGroupSourceStatelessRuleMatchAttributesSources = @import("rule_group_source_stateless_rule_match_attributes_sources.zig").RuleGroupSourceStatelessRuleMatchAttributesSources;
const RuleGroupSourceStatelessRuleMatchAttributesTcpFlags = @import("rule_group_source_stateless_rule_match_attributes_tcp_flags.zig").RuleGroupSourceStatelessRuleMatchAttributesTcpFlags;

/// Criteria for the stateless rule.
pub const RuleGroupSourceStatelessRuleMatchAttributes = struct {
    /// A list of port ranges to specify the destination ports to inspect for.
    destination_ports: ?[]const RuleGroupSourceStatelessRuleMatchAttributesDestinationPorts,

    /// The destination IP addresses and address ranges to inspect for, in CIDR
    /// notation.
    destinations: ?[]const RuleGroupSourceStatelessRuleMatchAttributesDestinations,

    /// The protocols to inspect for.
    protocols: ?[]const i32,

    /// A list of port ranges to specify the source ports to inspect for.
    source_ports: ?[]const RuleGroupSourceStatelessRuleMatchAttributesSourcePorts,

    /// The source IP addresses and address ranges to inspect for, in CIDR notation.
    sources: ?[]const RuleGroupSourceStatelessRuleMatchAttributesSources,

    /// The TCP flags and masks to inspect for.
    tcp_flags: ?[]const RuleGroupSourceStatelessRuleMatchAttributesTcpFlags,

    pub const json_field_names = .{
        .destination_ports = "DestinationPorts",
        .destinations = "Destinations",
        .protocols = "Protocols",
        .source_ports = "SourcePorts",
        .sources = "Sources",
        .tcp_flags = "TcpFlags",
    };
};
