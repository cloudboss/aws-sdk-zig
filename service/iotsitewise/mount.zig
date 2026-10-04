const MountSource = @import("mount_source.zig").MountSource;
const MountStorageType = @import("mount_storage_type.zig").MountStorageType;

/// Attaches a data source to the container filesystem for a task at a
/// customer-supplied relative path under the service-owned mount root.
pub const Mount = struct {
    /// A unique name for the mount within the task.
    name: []const u8,

    /// The relative path under the service-owned mount root where this mount is
    /// attached inside the container.
    relative_path: []const u8,

    /// The data source for the mount.
    source: MountSource,

    /// The type of storage used for the mount.
    storage_type: MountStorageType,

    pub const json_field_names = .{
        .name = "name",
        .relative_path = "relativePath",
        .source = "source",
        .storage_type = "storageType",
    };
};
