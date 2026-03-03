const MSKAccessCredentials = @import("msk_access_credentials.zig").MSKAccessCredentials;
const MSKStartPosition = @import("msk_start_position.zig").MSKStartPosition;

/// The parameters for using an MSK stream as a source.
pub const PipeSourceManagedStreamingKafkaParameters = struct {
    /// The maximum number of records to include in each batch.
    batch_size: ?i32 = null,

    /// The name of the destination queue to consume.
    consumer_group_id: ?[]const u8 = null,

    /// The credentials needed to access the resource.
    credentials: ?MSKAccessCredentials = null,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32 = null,

    /// The position in a stream from which to start reading.
    starting_position: ?MSKStartPosition = null,

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
