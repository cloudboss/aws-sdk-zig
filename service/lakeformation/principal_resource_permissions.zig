const DetailsMap = @import("details_map.zig").DetailsMap;
const Condition = @import("condition.zig").Condition;
const Permission = @import("permission.zig").Permission;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;
const Resource = @import("resource.zig").Resource;

/// The permissions granted or revoked on a resource.
pub const PrincipalResourcePermissions = struct {
    /// This attribute can be used to return any additional details of
    /// `PrincipalResourcePermissions`. Currently returns only as a RAM resource
    /// share ARN.
    additional_details: ?DetailsMap,

    /// A Lake Formation condition, which applies to permissions and opt-ins that
    /// contain an expression.
    condition: ?Condition,

    /// The date and time when the resource was last updated.
    last_updated: ?i64,

    /// The user who updated the record.
    last_updated_by: ?[]const u8,

    /// The permissions to be granted or revoked on the resource.
    permissions: ?[]const Permission,

    /// Indicates whether to grant the ability to grant permissions (as a subset of
    /// permissions granted).
    permissions_with_grant_option: ?[]const Permission,

    /// The Data Lake principal to be granted or revoked permissions.
    principal: ?DataLakePrincipal,

    /// The resource where permissions are to be granted or revoked.
    resource: ?Resource,

    pub const json_field_names = .{
        .additional_details = "AdditionalDetails",
        .condition = "Condition",
        .last_updated = "LastUpdated",
        .last_updated_by = "LastUpdatedBy",
        .permissions = "Permissions",
        .permissions_with_grant_option = "PermissionsWithGrantOption",
        .principal = "Principal",
        .resource = "Resource",
    };
};
