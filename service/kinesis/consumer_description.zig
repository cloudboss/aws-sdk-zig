const ConsumerStatus = @import("consumer_status.zig").ConsumerStatus;

/// An object that represents the details of a registered consumer. This type of
/// object is
/// returned by DescribeStreamConsumer.
pub const ConsumerDescription = struct {
    /// When you register a consumer, Kinesis Data Streams generates an ARN for it.
    /// You need
    /// this ARN to be able to call SubscribeToShard.
    ///
    /// If you delete a consumer and then create a new one with the same name, it
    /// won't have
    /// the same ARN. That's because consumer ARNs contain the creation timestamp.
    /// This is
    /// important to keep in mind if you have IAM policies that reference consumer
    /// ARNs.
    consumer_arn: []const u8,

    consumer_creation_timestamp: i64,

    /// The name of the consumer is something you choose when you register the
    /// consumer.
    consumer_name: []const u8,

    /// A consumer can't read data while in the `CREATING` or `DELETING`
    /// states.
    consumer_status: ConsumerStatus,

    /// The ARN of the stream with which you registered the consumer.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .consumer_arn = "ConsumerARN",
        .consumer_creation_timestamp = "ConsumerCreationTimestamp",
        .consumer_name = "ConsumerName",
        .consumer_status = "ConsumerStatus",
        .stream_arn = "StreamARN",
    };
};
