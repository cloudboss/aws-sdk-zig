const MQBrokerAccessCredentials = @import("mq_broker_access_credentials.zig").MQBrokerAccessCredentials;

/// The parameters for using a Rabbit MQ broker as a source.
pub const PipeSourceRabbitMQBrokerParameters = struct {
    /// The maximum number of records to include in each batch.
    batch_size: ?i32,

    /// The credentials needed to access the resource.
    credentials: MQBrokerAccessCredentials,

    /// The maximum length of a time to wait for events.
    maximum_batching_window_in_seconds: ?i32,

    /// The name of the destination queue to consume.
    queue_name: []const u8,

    /// The name of the virtual host associated with the source broker.
    virtual_host: ?[]const u8,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .credentials = "Credentials",
        .maximum_batching_window_in_seconds = "MaximumBatchingWindowInSeconds",
        .queue_name = "QueueName",
        .virtual_host = "VirtualHost",
    };
};
