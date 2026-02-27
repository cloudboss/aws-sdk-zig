/// Specifies a destination table bucket for replication.
pub const ReplicationDestination = struct {
    /// The Amazon Resource Name (ARN) of the destination table bucket where tables
    /// will be replicated.
    destination_table_bucket_arn: []const u8,

    pub const json_field_names = .{
        .destination_table_bucket_arn = "destinationTableBucketARN",
    };
};
