/// Information for telemetry delivery to Kinesis Data Streams.
pub const KinesisDataStreamData = struct {
    /// ARN of the Kinesis Data Stream to deliver telemetry to.
    kinesis_data_stream_arn: []const u8,

    /// ARN of the IAM Role used by AWS Ground Station to deliver telemetry.
    kinesis_role_arn: []const u8,

    pub const json_field_names = .{
        .kinesis_data_stream_arn = "kinesisDataStreamArn",
        .kinesis_role_arn = "kinesisRoleArn",
    };
};
