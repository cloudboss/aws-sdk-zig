pub const ExportSnapshotRecordSourceType = enum {
    instance_snapshot,
    disk_snapshot,

    pub const json_field_names = .{
        .instance_snapshot = "InstanceSnapshot",
        .disk_snapshot = "DiskSnapshot",
    };
};
