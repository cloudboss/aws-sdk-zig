const FirewallDomainListStatus = @import("firewall_domain_list_status.zig").FirewallDomainListStatus;

pub const ImportFirewallDomainsResponse = struct {
    /// The Id of the firewall domain list that DNS Firewall just updated.
    id: ?[]const u8 = null,

    /// The name of the domain list.
    name: ?[]const u8 = null,

    /// Status of the import request.
    status: ?FirewallDomainListStatus = null,

    /// Additional information about the status of the list, if available.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
