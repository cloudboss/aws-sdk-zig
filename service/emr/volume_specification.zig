/// EBS volume specifications such as volume type, IOPS, size (GiB) and
/// throughput (MiB/s)
/// that are requested for the EBS volume attached to an Amazon EC2 instance in
/// the
/// cluster.
pub const VolumeSpecification = struct {
    /// The number of I/O operations per second (IOPS) that the volume supports.
    iops: ?i32 = null,

    /// The volume size, in gibibytes (GiB). This can be a number from 1 - 1024. If
    /// the volume
    /// type is EBS-optimized, the minimum value is 10.
    size_in_gb: i32,

    /// The throughput, in mebibyte per second (MiB/s). This optional parameter can
    /// be a number
    /// from 125 - 1000 and is valid only for gp3 volumes.
    throughput: ?i32 = null,

    /// The volume type. Volume types supported are gp3, gp2, io1, st1, sc1, and
    /// standard.
    volume_type: []const u8,

    pub const json_field_names = .{
        .iops = "Iops",
        .size_in_gb = "SizeInGB",
        .throughput = "Throughput",
        .volume_type = "VolumeType",
    };
};
