const VolumeSpecification = @import("volume_specification.zig").VolumeSpecification;

/// Configuration of requested EBS block device associated with the instance
/// group.
pub const EbsBlockDevice = struct {
    /// The device name that is exposed to the instance, such as /dev/sdh.
    device: ?[]const u8,

    /// EBS volume specifications such as volume type, IOPS, size (GiB) and
    /// throughput (MiB/s)
    /// that are requested for the EBS volume attached to an Amazon EC2 instance in
    /// the
    /// cluster.
    volume_specification: ?VolumeSpecification,

    pub const json_field_names = .{
        .device = "Device",
        .volume_specification = "VolumeSpecification",
    };
};
