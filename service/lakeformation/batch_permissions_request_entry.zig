const Condition = @import("condition.zig").Condition;
const Permission = @import("permission.zig").Permission;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;
const Resource = @import("resource.zig").Resource;

/// A permission to a resource granted by batch operation to the principal.
pub const BatchPermissionsRequestEntry = struct {
    condition: ?Condition = null,

    /// A unique identifier for the batch permissions request entry.
    id: []const u8,

    /// The permissions to be granted.
    permissions: ?[]const Permission = null,

    /// Indicates if the option to pass permissions is granted.
    permissions_with_grant_option: ?[]const Permission = null,

    /// The principal to be granted a permission.
    principal: ?DataLakePrincipal = null,

    /// The resource to which the principal is to be granted a permission.
    resource: ?Resource = null,

    pub const json_field_names = .{
        .condition = "Condition",
        .id = "Id",
        .permissions = "Permissions",
        .permissions_with_grant_option = "PermissionsWithGrantOption",
        .principal = "Principal",
        .resource = "Resource",
    };
};
