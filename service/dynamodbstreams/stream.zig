/// Represents all of the data describing a particular stream.
pub const Stream = struct {
    /// The Amazon Resource Name (ARN) for the stream.
    stream_arn: ?[]const u8 = null,

    /// A timestamp, in ISO 8601 format, for this stream.
    ///
    /// Note that `LatestStreamLabel` is not a unique identifier for the stream,
    /// because it is
    /// possible that a stream from another table might have the same timestamp.
    /// However, the
    /// combination of the following three elements is guaranteed to be unique:
    ///
    /// * the Amazon Web Services customer ID.
    ///
    /// * the table name
    ///
    /// * the `StreamLabel`
    stream_label: ?[]const u8 = null,

    /// The DynamoDB table with which the stream is associated.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .stream_arn = "StreamArn",
        .stream_label = "StreamLabel",
        .table_name = "TableName",
    };
};
