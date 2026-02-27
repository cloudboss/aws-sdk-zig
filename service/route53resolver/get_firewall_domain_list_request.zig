pub const GetFirewallDomainListRequest = struct {
    /// The ID of the domain list.
    firewall_domain_list_id: []const u8,

    pub const json_field_names = .{
        .firewall_domain_list_id = "FirewallDomainListId",
    };
};
