const DiskSnapshotInfo = @import("disk_snapshot_info.zig").DiskSnapshotInfo;
const InstanceSnapshotInfo = @import("instance_snapshot_info.zig").InstanceSnapshotInfo;
const ExportSnapshotRecordSourceType = @import("export_snapshot_record_source_type.zig").ExportSnapshotRecordSourceType;

/// Describes the source of an export snapshot record.
pub const ExportSnapshotRecordSourceInfo = struct {
    /// The Amazon Resource Name (ARN) of the source instance or disk snapshot.
    arn: ?[]const u8,

    /// The date when the source instance or disk snapshot was created.
    created_at: ?i64,

    /// A list of objects describing a disk snapshot.
    disk_snapshot_info: ?DiskSnapshotInfo,

    /// The Amazon Resource Name (ARN) of the snapshot's source instance or disk.
    from_resource_arn: ?[]const u8,

    /// The name of the snapshot's source instance or disk.
    from_resource_name: ?[]const u8,

    /// A list of objects describing an instance snapshot.
    instance_snapshot_info: ?InstanceSnapshotInfo,

    /// The name of the source instance or disk snapshot.
    name: ?[]const u8,

    /// The Lightsail resource type (`InstanceSnapshot` or
    /// `DiskSnapshot`).
    resource_type: ?ExportSnapshotRecordSourceType,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .disk_snapshot_info = "diskSnapshotInfo",
        .from_resource_arn = "fromResourceArn",
        .from_resource_name = "fromResourceName",
        .instance_snapshot_info = "instanceSnapshotInfo",
        .name = "name",
        .resource_type = "resourceType",
    };
};
