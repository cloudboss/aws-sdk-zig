pub const DeleteFirewallDomainListRequest = struct {
    /// The ID of the domain list that you want to delete.
    firewall_domain_list_id: []const u8,

    pub const json_field_names = .{
        .firewall_domain_list_id = "FirewallDomainListId",
    };
};
