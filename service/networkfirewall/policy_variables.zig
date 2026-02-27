const aws = @import("aws");

const IPSet = @import("ip_set.zig").IPSet;

/// Contains variables that you can use to override default Suricata settings in
/// your firewall policy.
pub const PolicyVariables = struct {
    /// The IPv4 or IPv6 addresses in CIDR notation to use for the Suricata
    /// `HOME_NET` variable. If your firewall uses an inspection VPC, you might want
    /// to override the `HOME_NET` variable with the CIDRs of your home networks. If
    /// you don't override `HOME_NET` with your own CIDRs, Network Firewall by
    /// default uses the CIDR of your inspection VPC.
    rule_variables: ?[]const aws.map.MapEntry(IPSet),

    pub const json_field_names = .{
        .rule_variables = "RuleVariables",
    };
};
