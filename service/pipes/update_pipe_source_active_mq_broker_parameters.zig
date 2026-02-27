const MQBrokerAccessCredentials = @import("mq_broker_access_credentials.zig").MQBrokerAccessCredentials;

/// The parameters for using an Active MQ broker as a source.
pub const UpdatePipeSourceActiveMQBrokerParameters = struct {
    /// The maximum number of records to include in each batch.
    batch_size: ?i32,

    /// The credentials needed to access the resource.
    credentials: MQBrokerAccessCredentials,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .credentials = "Credentials",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
    };
};
