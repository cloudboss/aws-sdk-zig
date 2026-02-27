const BackendStoragePermissions = @import("backend_storage_permissions.zig").BackendStoragePermissions;
const ServiceName = @import("service_name.zig").ServiceName;

/// The details for a backend storage resource.
pub const GetBackendStorageResourceConfig = struct {
    /// The name of the S3 bucket.
    bucket_name: ?[]const u8,

    /// Returns True if the storage resource has been imported.
    imported: bool,

    /// The authorization configuration for the storage S3 bucket.
    permissions: ?BackendStoragePermissions,

    /// The name of the storage service.
    service_name: ServiceName,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .imported = "Imported",
        .permissions = "Permissions",
        .service_name = "ServiceName",
    };
};
