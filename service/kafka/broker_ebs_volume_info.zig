const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;

/// Specifies the EBS volume upgrade information. The broker identifier must be
/// set to the keyword ALL. This means the changes apply to all the brokers in
/// the cluster.
pub const BrokerEBSVolumeInfo = struct {
    /// The ID of the broker to update.
    kafka_broker_node_id: []const u8,

    /// EBS volume provisioned throughput information.
    provisioned_throughput: ?ProvisionedThroughput,

    /// Size of the EBS volume to update.
    volume_size_gb: ?i32,

    pub const json_field_names = .{
        .kafka_broker_node_id = "KafkaBrokerNodeId",
        .provisioned_throughput = "ProvisionedThroughput",
        .volume_size_gb = "VolumeSizeGB",
    };
};
