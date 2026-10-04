const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const ChildResourceType = @import("child_resource_type.zig").ChildResourceType;

/// Contains information about a child resource of a given resource in a
/// collaboration.
pub const ChildResource = struct {
    /// The Amazon Web Services account ID of the member who owns the child
    /// resource.
    owner_account_id: []const u8,

    /// The unique identifier of the child resource.
    resource_id: ?[]const u8 = null,

    /// The name of the child resource.
    resource_name: []const u8,

    /// The current status of the child resource.
    resource_status: ?ResourceStatus = null,

    /// The type of the child resource.
    resource_type: ChildResourceType,

    pub const json_field_names = .{
        .owner_account_id = "ownerAccountId",
        .resource_id = "resourceId",
        .resource_name = "resourceName",
        .resource_status = "resourceStatus",
        .resource_type = "resourceType",
    };
};
