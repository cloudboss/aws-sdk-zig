const MSKAccessCredentials = @import("msk_access_credentials.zig").MSKAccessCredentials;
const MSKStartPosition = @import("msk_start_position.zig").MSKStartPosition;

/// The parameters for using an MSK stream as a source.
pub const PipeSourceManagedStreamingKafkaParameters = struct {
    /// The maximum number of records to include in each batch.
    batch_size: ?i32,

    /// The name of the destination queue to consume.
    consumer_group_id: ?[]const u8,

    /// The credentials needed to access the resource.
    credentials: ?MSKAccessCredentials,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32,

    /// The position in a stream from which to start reading.
    starting_position: ?MSKStartPosition,

    /// The name of the topic that the pipe will read from.
    topic_name: []const u8,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .consumer_group_id = "ConsumerGroupID",
        .credentials = "Credentials",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
        .starting_position = "StartingPosition",
        .topic_name = "TopicName",
    };
};
