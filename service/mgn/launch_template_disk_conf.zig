const VolumeType = @import("volume_type.zig").VolumeType;

/// Launch template disk configuration.
pub const LaunchTemplateDiskConf = struct {
    /// Launch template disk iops configuration.
    iops: ?i64,

    /// Launch template disk throughput configuration.
    throughput: ?i64,

    /// Launch template disk volume type configuration.
    volume_type: ?VolumeType,

    pub const json_field_names = .{
        .iops = "iops",
        .throughput = "throughput",
        .volume_type = "volumeType",
    };
};
