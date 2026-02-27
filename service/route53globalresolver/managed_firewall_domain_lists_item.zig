/// Summary information about a managed firewall domain list.
pub const ManagedFirewallDomainListsItem = struct {
    /// A description of the managed firewall domain list.
    description: ?[]const u8,

    /// The unique identifier of the managed firewall domain list.
    id: []const u8,

    /// The type of the managed firewall domain list.
    managed_list_type: []const u8,

    /// The name of the managed firewall domain list.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .id = "id",
        .managed_list_type = "managedListType",
        .name = "name",
    };
};
