/// Represents a change data capture stream for an Amazon Keyspaces table, which
/// enables tracking and processing of data changes.
pub const Stream = struct {
    /// The name of the keyspace containing the table associated with this stream.
    keyspace_name: []const u8,

    /// The Amazon Resource Name (ARN) that uniquely identifies this stream.
    stream_arn: []const u8,

    /// A unique identifier for this stream that can be used in stream operations.
    stream_label: []const u8,

    /// The name of the table associated with this stream.
    table_name: []const u8,

    pub const json_field_names = .{
        .keyspace_name = "keyspaceName",
        .stream_arn = "streamArn",
        .stream_label = "streamLabel",
        .table_name = "tableName",
    };
};
