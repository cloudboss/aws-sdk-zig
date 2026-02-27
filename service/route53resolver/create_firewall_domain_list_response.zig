const FirewallDomainList = @import("firewall_domain_list.zig").FirewallDomainList;

pub const CreateFirewallDomainListResponse = struct {
    /// The domain list that you just created.
    firewall_domain_list: ?FirewallDomainList,

    pub const json_field_names = .{
        .firewall_domain_list = "FirewallDomainList",
    };
};
