/// Defines the configuration for attaching an Amazon FSx for OpenZFS file
/// system to instances in a SageMaker HyperPod cluster instance group.
pub const ClusterFsxOpenZfsConfig = struct {
    /// The DNS name of the Amazon FSx for OpenZFS file system.
    dns_name: []const u8,

    /// The local path where the Amazon FSx for OpenZFS file system is mounted on
    /// instances.
    mount_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .dns_name = "DnsName",
        .mount_path = "MountPath",
    };
};
