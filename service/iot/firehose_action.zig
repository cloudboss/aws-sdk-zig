/// Describes an action that writes data to an Amazon Kinesis Firehose stream.
pub const FirehoseAction = struct {
    /// Whether to deliver the Kinesis Data Firehose stream as a batch by using [
    /// `PutRecordBatch`
    /// ](https://docs.aws.amazon.com/firehose/latest/APIReference/API_PutRecordBatch.html). The default value is
    /// `false`.
    ///
    /// When `batchMode` is `true` and the rule's SQL statement
    /// evaluates to an Array, each Array element forms one record in the [
    /// `PutRecordBatch`
    /// ](https://docs.aws.amazon.com/firehose/latest/APIReference/API_PutRecordBatch.html) request. The resulting array can't have more
    /// than 500 records.
    batch_mode: ?bool = null,

    /// The delivery stream name.
    delivery_stream_name: []const u8,

    /// The IAM role that grants access to the Amazon Kinesis Firehose stream.
    role_arn: []const u8,

    /// A character separator that will be used to separate records written to the
    /// Firehose
    /// stream. Valid values are: '\n' (newline), '\t' (tab), '\r\n' (Windows
    /// newline), ','
    /// (comma).
    separator: ?[]const u8 = null,

    pub const json_field_names = .{
        .batch_mode = "batchMode",
        .delivery_stream_name = "deliveryStreamName",
        .role_arn = "roleArn",
        .separator = "separator",
    };
};
