const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;

/// Contains information about the EBS storage volumes attached to Apache Kafka
/// broker nodes.
pub const EBSStorageInfo = struct {
    /// EBS volume provisioned throughput information.
    provisioned_throughput: ?ProvisionedThroughput,

    /// The size in GiB of the EBS volume for the data drive on each broker node.
    volume_size: ?i32,

    pub const json_field_names = .{
        .provisioned_throughput = "ProvisionedThroughput",
        .volume_size = "VolumeSize",
    };
};
