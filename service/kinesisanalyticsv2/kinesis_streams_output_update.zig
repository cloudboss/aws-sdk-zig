/// When you update a SQL-based Kinesis Data Analytics application's output
/// configuration using the UpdateApplication operation, provides information
/// about a Kinesis data stream that is configured as the destination.
pub const KinesisStreamsOutputUpdate = struct {
    /// The Amazon Resource Name (ARN) of the Kinesis data stream where you want to
    /// write the
    /// output.
    resource_arn_update: []const u8,

    pub const json_field_names = .{
        .resource_arn_update = "ResourceARNUpdate",
    };
};
