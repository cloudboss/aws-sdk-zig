const PartitionLoadFrequency = @import("partition_load_frequency.zig").PartitionLoadFrequency;

/// Describes integration options for Amazon Athena.
pub const AthenaIntegration = struct {
    /// The location in Amazon S3 to store the generated CloudFormation template.
    integration_result_s_3_destination_arn: []const u8,

    /// The end date for the partition.
    partition_end_date: ?i64,

    /// The schedule for adding new partitions to the table.
    partition_load_frequency: PartitionLoadFrequency,

    /// The start date for the partition.
    partition_start_date: ?i64,
};
