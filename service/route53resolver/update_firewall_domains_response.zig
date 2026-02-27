const FirewallDomainListStatus = @import("firewall_domain_list_status.zig").FirewallDomainListStatus;

pub const UpdateFirewallDomainsResponse = struct {
    /// The ID of the firewall domain list that DNS Firewall just updated.
    id: ?[]const u8,

    /// The name of the domain list.
    name: ?[]const u8,

    /// Status of the `UpdateFirewallDomains` request.
    status: ?FirewallDomainListStatus,

    /// Additional information about the status of the list, if available.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
