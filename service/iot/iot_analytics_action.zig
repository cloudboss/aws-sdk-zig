/// Sends message data to an IoT Analytics channel.
pub const IotAnalyticsAction = struct {
    /// Whether to process the action as a batch. The default value is
    /// `false`.
    ///
    /// When `batchMode` is `true` and the rule SQL statement evaluates
    /// to an Array, each Array element is delivered as a separate message when
    /// passed by [
    /// `BatchPutMessage`
    /// ](https://docs.aws.amazon.com/iotanalytics/latest/APIReference/API_BatchPutMessage.html) to the IoT Analytics channel. The resulting array can't have more
    /// than 100 messages.
    batch_mode: ?bool = null,

    /// (deprecated) The ARN of the IoT Analytics channel to which message data will
    /// be
    /// sent.
    channel_arn: ?[]const u8 = null,

    /// The name of the IoT Analytics channel to which message data will be sent.
    channel_name: ?[]const u8 = null,

    /// The ARN of the role which has a policy that grants IoT Analytics permission
    /// to send
    /// message data via IoT Analytics (iotanalytics:BatchPutMessage).
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .batch_mode = "batchMode",
        .channel_arn = "channelArn",
        .channel_name = "channelName",
        .role_arn = "roleArn",
    };
};
