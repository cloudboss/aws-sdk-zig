/// Describes the configuration of an Amazon Elastic Block Store (Amazon EBS)
/// volume.
pub const VolumeConfiguration = struct {
    /// Contains the image used to boot the instance during launch.
    root_volume: ?bool,

    /// The baseline IOPS of the volume.
    volume_baseline_iops: i32 = 0,

    /// The baseline throughput of the volume.
    volume_baseline_throughput: i32 = 0,

    /// The burst IOPS of the volume.
    volume_burst_iops: i32 = 0,

    /// The burst throughput of the volume.
    volume_burst_throughput: i32 = 0,

    /// The size of the volume, in GiB.
    volume_size: i32 = 0,

    /// The volume type.
    ///
    /// The volume types can be the following:
    ///
    /// * General Purpose SSD `gp2` and `gp3`
    ///
    /// * Provisioned IOPS SSD `io1`, `io2`, and `io2 Block Express`
    ///
    /// * Throughput Optimized HDD `st1`
    ///
    /// * Cold HDD `sc1`
    ///
    /// * Magnetic volumes `standard`
    volume_type: ?[]const u8,

    pub const json_field_names = .{
        .root_volume = "rootVolume",
        .volume_baseline_iops = "volumeBaselineIOPS",
        .volume_baseline_throughput = "volumeBaselineThroughput",
        .volume_burst_iops = "volumeBurstIOPS",
        .volume_burst_throughput = "volumeBurstThroughput",
        .volume_size = "volumeSize",
        .volume_type = "volumeType",
    };
};
