const FirewallDomainList = @import("firewall_domain_list.zig").FirewallDomainList;

pub const GetFirewallDomainListResponse = struct {
    /// The domain list that you requested.
    firewall_domain_list: ?FirewallDomainList = null,

    pub const json_field_names = .{
        .firewall_domain_list = "FirewallDomainList",
    };
};
