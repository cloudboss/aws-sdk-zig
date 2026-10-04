const VolumeType = @import("volume_type.zig").VolumeType;

/// Launch template disk configuration.
pub const LaunchTemplateDiskConf = struct {
    /// Launch template disk delete on termination configuration.
    delete_on_termination: ?bool = null,

    /// Launch template disk iops configuration.
    iops: ?i64 = null,

    /// Launch template disk throughput configuration.
    throughput: ?i64 = null,

    /// Launch template disk volume initialization rate configuration.
    volume_initialization_rate: ?i64 = null,

    /// Launch template disk volume type configuration.
    volume_type: ?VolumeType = null,

    pub const json_field_names = .{
        .delete_on_termination = "deleteOnTermination",
        .iops = "iops",
        .throughput = "throughput",
        .volume_initialization_rate = "volumeInitializationRate",
        .volume_type = "volumeType",
    };
};
