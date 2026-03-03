const aws = @import("aws");

const IPSet = @import("ip_set.zig").IPSet;
const PortSet = @import("port_set.zig").PortSet;

/// Settings that are available for use in the rules in the RuleGroup
/// where this is defined. See CreateRuleGroup or UpdateRuleGroup for usage.
pub const RuleVariables = struct {
    /// A list of IP addresses and address ranges, in CIDR notation.
    ip_sets: ?[]const aws.map.MapEntry(IPSet) = null,

    /// A list of port ranges.
    port_sets: ?[]const aws.map.MapEntry(PortSet) = null,

    pub const json_field_names = .{
        .ip_sets = "IPSets",
        .port_sets = "PortSets",
    };
};
