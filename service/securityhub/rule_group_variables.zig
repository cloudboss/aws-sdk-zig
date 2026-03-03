const RuleGroupVariablesIpSetsDetails = @import("rule_group_variables_ip_sets_details.zig").RuleGroupVariablesIpSetsDetails;
const RuleGroupVariablesPortSetsDetails = @import("rule_group_variables_port_sets_details.zig").RuleGroupVariablesPortSetsDetails;

/// Additional settings to use in the specified rules.
pub const RuleGroupVariables = struct {
    /// A list of IP addresses and address ranges, in CIDR notation.
    ip_sets: ?RuleGroupVariablesIpSetsDetails = null,

    /// A list of port ranges.
    port_sets: ?RuleGroupVariablesPortSetsDetails = null,

    pub const json_field_names = .{
        .ip_sets = "IpSets",
        .port_sets = "PortSets",
    };
};
