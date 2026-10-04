const DomainListType = @import("domain_list_type.zig").DomainListType;

/// Minimal high-level information for a firewall domain list. The action
/// ListFirewallDomainLists returns an array of these objects.
///
/// To retrieve full information for a firewall domain list, call
/// GetFirewallDomainList and ListFirewallDomains.
pub const FirewallDomainListMetadata = struct {
    /// The Amazon Resource Name (ARN) of the firewall domain list metadata.
    arn: ?[]const u8 = null,

    /// The category of the domain list.
    category: ?[]const u8 = null,

    /// A unique string defined by you to identify the request. This allows you to
    /// retry failed
    /// requests without the risk of running the operation twice. This can be any
    /// unique string,
    /// for example, a timestamp.
    creator_request_id: ?[]const u8 = null,

    /// The ID of the domain list.
    id: ?[]const u8 = null,

    /// The type of the managed domain list, for example `THREAT`.
    managed_list_type: ?DomainListType = null,

    /// The owner of the list, used only for lists that are not managed by you. For
    /// example, the managed domain list `AWSManagedDomainsMalwareDomainList` has
    /// the managed owner name `Route 53 Resolver DNS Firewall`.
    managed_owner_name: ?[]const u8 = null,

    /// The name of the domain list.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .category = "Category",
        .creator_request_id = "CreatorRequestId",
        .id = "Id",
        .managed_list_type = "ManagedListType",
        .managed_owner_name = "ManagedOwnerName",
        .name = "Name",
    };
};
