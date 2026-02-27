const ResourcePermission = @import("resource_permission.zig").ResourcePermission;

/// Permission group parameters for Dataset permissions.
///
/// Here is an example of how you could specify the `PermissionGroupParams`:
///
/// `
/// {
/// "permissionGroupId": "0r6fCRtSTUk4XPfXQe3M0g",
/// "datasetPermissions": [
/// {"permission": "ViewDatasetDetails"},
/// {"permission": "AddDatasetData"},
/// {"permission": "EditDatasetMetadata"},
/// {"permission": "DeleteDataset"}
/// ]
/// }
/// `
pub const PermissionGroupParams = struct {
    /// List of resource permissions.
    dataset_permissions: ?[]const ResourcePermission,

    /// The unique identifier for the `PermissionGroup`.
    permission_group_id: ?[]const u8,

    pub const json_field_names = .{
        .dataset_permissions = "datasetPermissions",
        .permission_group_id = "permissionGroupId",
    };
};
