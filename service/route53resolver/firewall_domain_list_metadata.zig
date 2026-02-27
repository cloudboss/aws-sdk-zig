/// Minimal high-level information for a firewall domain list. The action
/// ListFirewallDomainLists returns an array of these objects.
///
/// To retrieve full information for a firewall domain list, call
/// GetFirewallDomainList and ListFirewallDomains.
pub const FirewallDomainListMetadata = struct {
    /// The Amazon Resource Name (ARN) of the firewall domain list metadata.
    arn: ?[]const u8,

    /// A unique string defined by you to identify the request. This allows you to
    /// retry failed
    /// requests without the risk of running the operation twice. This can be any
    /// unique string,
    /// for example, a timestamp.
    creator_request_id: ?[]const u8,

    /// The ID of the domain list.
    id: ?[]const u8,

    /// The owner of the list, used only for lists that are not managed by you. For
    /// example, the managed domain list `AWSManagedDomainsMalwareDomainList` has
    /// the managed owner name `Route 53 Resolver DNS Firewall`.
    managed_owner_name: ?[]const u8,

    /// The name of the domain list.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .creator_request_id = "CreatorRequestId",
        .id = "Id",
        .managed_owner_name = "ManagedOwnerName",
        .name = "Name",
    };
};
