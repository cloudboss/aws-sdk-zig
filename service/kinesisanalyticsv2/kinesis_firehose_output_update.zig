/// For a SQL-based Kinesis Data Analytics application, when updating an output
/// configuration using the UpdateApplication operation, provides information
/// about a Kinesis Data Firehose delivery stream that is configured as the
/// destination.
pub const KinesisFirehoseOutputUpdate = struct {
    /// The Amazon Resource Name (ARN) of the delivery stream to write to.
    resource_arn_update: []const u8,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
    };
};
