const Payload = @import("payload.zig").Payload;

/// Sends information about the detector model instance and the event that
/// triggered the
/// action to an Amazon SQS queue.
pub const SqsAction = struct {
    /// You can configure the action payload when you send a message to an Amazon
    /// SQS
    /// queue.
    payload: ?Payload = null,

    /// The URL of the SQS queue where the data is written.
    queue_url: []const u8,

    /// Set this to TRUE if you want the data to be base-64 encoded before it is
    /// written to the
    /// queue. Otherwise, set this to FALSE.
    use_base_64: ?bool = null,

    pub const json_field_names = .{
        .payload = "payload",
        .queue_url = "queueUrl",
        .use_base_64 = "useBase64",
    };
};
