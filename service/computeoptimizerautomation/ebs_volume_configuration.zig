/// Configuration details for an Amazon EBS volume.
pub const EbsVolumeConfiguration = struct {
    /// The number of I/O operations per second (IOPS) provisioned for the volume.
    iops: ?i32 = null,

    /// The size of the EBS volume in gibibytes (GiB).
    size_in_gib: ?i32 = null,

    /// The throughput in MiB/s provisioned for the volume (applicable to gp3, io1,
    /// and io2bx volumes).
    throughput: ?i32 = null,

    /// The EBS volume type, such as gp2, gp3, io1, io2, st1, or sc1.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .iops = "iops",
        .size_in_gib = "sizeInGib",
        .throughput = "throughput",
        .@"type" = "type",
    };
};
