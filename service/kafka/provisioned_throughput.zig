/// Contains information about provisioned throughput for EBS storage volumes
/// attached to kafka broker nodes.
pub const ProvisionedThroughput = struct {
    /// Provisioned throughput is enabled or not.
    enabled: ?bool,

    /// Throughput value of the EBS volumes for the data drive on each kafka broker
    /// node in MiB per second.
    volume_throughput: ?i32,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .volume_throughput = "VolumeThroughput",
    };
};
