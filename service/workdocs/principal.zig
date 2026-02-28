const PermissionInfo = @import("permission_info.zig").PermissionInfo;
const PrincipalType = @import("principal_type.zig").PrincipalType;

/// Describes a resource.
pub const Principal = struct {
    /// The ID of the resource.
    id: ?[]const u8,

    /// The permission information for the resource.
    roles: ?[]const PermissionInfo,

    /// The type of resource.
    @"type": ?PrincipalType,

    pub const json_field_names = .{
        .id = "Id",
        .roles = "Roles",
        .@"type" = "Type",
    };
};
