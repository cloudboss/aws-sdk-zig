const VolumeSpecification = @import("volume_specification.zig").VolumeSpecification;

/// Configuration of requested EBS block device associated with the instance
/// group with
/// count of volumes that are associated to every instance.
pub const EbsBlockDeviceConfig = struct {
    /// EBS volume specifications such as volume type, IOPS, size (GiB) and
    /// throughput (MiB/s)
    /// that are requested for the EBS volume attached to an Amazon EC2 instance in
    /// the
    /// cluster.
    volume_specification: VolumeSpecification,

    /// Number of EBS volumes with a specific volume configuration that are
    /// associated with
    /// every instance in the instance group
    volumes_per_instance: ?i32,

    pub const json_field_names = .{
        .volume_specification = "VolumeSpecification",
        .volumes_per_instance = "VolumesPerInstance",
    };
};
