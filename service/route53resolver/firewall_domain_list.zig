const FirewallDomainListStatus = @import("firewall_domain_list_status.zig").FirewallDomainListStatus;

/// High-level information about a list of firewall domains for use in a
/// FirewallRule. This is returned by GetFirewallDomainList.
///
/// To retrieve the domains that are defined for this domain list, call
/// ListFirewallDomains.
pub const FirewallDomainList = struct {
    /// The Amazon Resource Name (ARN) of the firewall domain list.
    arn: ?[]const u8,

    /// The date and time that the domain list was created, in Unix time format and
    /// Coordinated Universal Time (UTC).
    creation_time: ?[]const u8,

    /// A unique string defined by you to identify the request. This allows you to
    /// retry failed
    /// requests without the risk of running the operation twice. This can be any
    /// unique string,
    /// for example, a timestamp.
    creator_request_id: ?[]const u8,

    /// The number of domain names that are specified in the domain list.
    domain_count: ?i32,

    /// The ID of the domain list.
    id: ?[]const u8,

    /// The owner of the list, used only for lists that are not managed by you. For
    /// example, the managed domain list `AWSManagedDomainsMalwareDomainList` has
    /// the managed owner name `Route 53 Resolver DNS Firewall`.
    managed_owner_name: ?[]const u8,

    /// The date and time that the domain list was last modified, in Unix time
    /// format and Coordinated Universal Time (UTC).
    modification_time: ?[]const u8,

    /// The name of the domain list.
    name: ?[]const u8,

    /// The status of the domain list.
    status: ?FirewallDomainListStatus,

    /// Additional information about the status of the list, if available.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .creator_request_id = "CreatorRequestId",
        .domain_count = "DomainCount",
        .id = "Id",
        .managed_owner_name = "ManagedOwnerName",
        .modification_time = "ModificationTime",
        .name = "Name",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
