const PartitionInstanceType = @import("partition_instance_type.zig").PartitionInstanceType;

/// The desired instance type and desired number of replicas of each index
/// partition.
pub const ScalingParameters = struct {
    /// The instance type that you want to preconfigure for your domain. For
    /// example, `search.m1.small`.
    desired_instance_type: ?PartitionInstanceType,

    /// The number of partitions you want to preconfigure for your domain. Only
    /// valid when
    /// you select `m2.2xlarge` as the desired instance type.
    desired_partition_count: i32 = 0,

    /// The number of replicas you want to preconfigure for each index partition.
    desired_replication_count: i32 = 0,
};
