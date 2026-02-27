const Permission = @import("permission.zig").Permission;

/// A policy used by the function to access a resource.
pub const ResourceAccessPolicy = struct {
    /// The permissions that the Lambda function has to the resource. Can be one of
    /// ''rw'' (read/write) or ''ro'' (read-only).
    permission: ?Permission,

    /// The ID of the resource. (This ID is assigned to the resource when you create
    /// the resource definiton.)
    resource_id: []const u8,

    pub const json_field_names = .{
        .permission = "Permission",
        .resource_id = "ResourceId",
    };
};
