const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

/// Summary information about a firewall domain list.
pub const FirewallDomainListsItem = struct {
    /// The Amazon Resource Name (ARN) of the firewall domain list.
    arn: []const u8,

    /// The date and time when the firewall domain list was created.
    created_at: i64,

    /// A description of the firewall domain list.
    description: ?[]const u8 = null,

    /// The ID of the global resolver that the firewall domain list is associated
    /// with.
    global_resolver_id: []const u8,

    /// The unique identifier of the firewall domain list.
    id: []const u8,

    /// The name of the firewall domain list.
    name: []const u8,

    /// The current status of the firewall domain list.
    status: CRResourceStatus,

    /// The date and time when the firewall domain list was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .global_resolver_id = "globalResolverId",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
