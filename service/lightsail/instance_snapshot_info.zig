const DiskInfo = @import("disk_info.zig").DiskInfo;

/// Describes an instance snapshot.
pub const InstanceSnapshotInfo = struct {
    /// The blueprint ID from which the source instance (`amazon_linux_2023`).
    from_blueprint_id: ?[]const u8 = null,

    /// The bundle ID from which the source instance was created (`micro_x_x`).
    from_bundle_id: ?[]const u8 = null,

    /// A list of objects describing the disks that were attached to the source
    /// instance.
    from_disk_info: ?[]const DiskInfo = null,

    pub const json_field_names = .{
        .from_blueprint_id = "fromBlueprintId",
        .from_bundle_id = "fromBundleId",
        .from_disk_info = "fromDiskInfo",
    };
};
