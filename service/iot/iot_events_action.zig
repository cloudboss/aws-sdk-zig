/// Sends an input to an IoT Events detector.
pub const IotEventsAction = struct {
    /// Whether to process the event actions as a batch. The default value is
    /// `false`.
    ///
    /// When `batchMode` is `true`, you can't specify a
    /// `messageId`.
    ///
    /// When `batchMode` is `true` and the rule SQL statement evaluates
    /// to an Array, each Array element is treated as a separate message when it's
    /// sent to IoT
    /// Events by calling [
    /// `BatchPutMessage`
    /// ](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_BatchPutMessage.html). The resulting array can't have more
    /// than 10 messages.
    batch_mode: ?bool,

    /// The name of the IoT Events input.
    input_name: []const u8,

    /// The ID of the message. The default `messageId` is a new UUID value.
    ///
    /// When `batchMode` is `true`, you can't specify a
    /// `messageId`--a new UUID value will be assigned.
    ///
    /// Assign a value to this property to ensure that only one input (message) with
    /// a given
    /// `messageId` will be processed by an IoT Events detector.
    message_id: ?[]const u8,

    /// The ARN of the role that grants IoT permission to send an input to an IoT
    /// Events detector. ("Action":"iotevents:BatchPutMessage").
    role_arn: []const u8,

    pub const json_field_names = .{
        .batch_mode = "batchMode",
        .input_name = "inputName",
        .message_id = "messageId",
        .role_arn = "roleArn",
    };
};
