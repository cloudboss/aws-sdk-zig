const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const Shard = @import("shard.zig").Shard;
const StreamStatus = @import("stream_status.zig").StreamStatus;
const StreamViewType = @import("stream_view_type.zig").StreamViewType;

/// Represents all of the data describing a particular stream.
pub const StreamDescription = struct {
    /// The date and time when the request to create this stream was issued.
    creation_request_date_time: ?i64 = null,

    /// The key attribute(s) of the stream's DynamoDB table.
    key_schema: ?[]const KeySchemaElement = null,

    /// The shard ID of the item where the operation stopped, inclusive of the
    /// previous result set. Use this value to start a new operation, excluding this
    /// value in the new request.
    ///
    /// If `LastEvaluatedShardId` is empty, then the "last page" of results has been
    /// processed and there is currently no more data to be retrieved.
    ///
    /// If `LastEvaluatedShardId` is not empty, it does not necessarily mean that
    /// there is
    /// more data in the result set. The only way to know when you have reached the
    /// end of the result
    /// set is when `LastEvaluatedShardId` is empty.
    last_evaluated_shard_id: ?[]const u8 = null,

    /// The shards that comprise the stream.
    shards: ?[]const Shard = null,

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

    /// Indicates the current status of the stream:
    ///
    /// * `ENABLING` - Streams is currently being enabled on the DynamoDB table.
    ///
    /// * `ENABLED` - the stream is enabled.
    ///
    /// * `DISABLING` - Streams is currently being disabled on the DynamoDB table.
    ///
    /// * `DISABLED` - the stream is disabled.
    stream_status: ?StreamStatus = null,

    /// Indicates the format of the records within this stream:
    ///
    /// * `KEYS_ONLY` - only the key attributes of items that were modified in the
    ///   DynamoDB table.
    ///
    /// * `NEW_IMAGE` - entire items from the table, as they appeared after they
    ///   were modified.
    ///
    /// * `OLD_IMAGE` - entire items from the table, as they appeared before they
    ///   were modified.
    ///
    /// * `NEW_AND_OLD_IMAGES` - both the new and the old images of the items from
    ///   the table.
    stream_view_type: ?StreamViewType = null,

    /// The DynamoDB table with which the stream is associated.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_request_date_time = "CreationRequestDateTime",
        .key_schema = "KeySchema",
        .last_evaluated_shard_id = "LastEvaluatedShardId",
        .shards = "Shards",
        .stream_arn = "StreamArn",
        .stream_label = "StreamLabel",
        .stream_status = "StreamStatus",
        .stream_view_type = "StreamViewType",
        .table_name = "TableName",
    };
};
