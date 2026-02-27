const BackendStoragePermissions = @import("backend_storage_permissions.zig").BackendStoragePermissions;
const ServiceName = @import("service_name.zig").ServiceName;

/// The resource configuration for updating backend storage.
pub const UpdateBackendStorageResourceConfig = struct {
    /// The authorization configuration for the storage S3 bucket.
    permissions: BackendStoragePermissions,

    /// The name of the storage service.
    service_name: ServiceName,

    pub const json_field_names = .{
        .permissions = "Permissions",
        .service_name = "ServiceName",
    };
};
