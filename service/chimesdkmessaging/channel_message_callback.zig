const aws = @import("aws");

const MessageAttributeValue = @import("message_attribute_value.zig").MessageAttributeValue;
const PushNotificationConfiguration = @import("push_notification_configuration.zig").PushNotificationConfiguration;

/// Stores information about a callback.
pub const ChannelMessageCallback = struct {
    /// The message content. For Amazon Lex V2 bot responses, this field holds a
    /// list of messages originating from the bot. For more information, refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    content: ?[]const u8,

    /// The content type of the call-back message. For Amazon Lex V2 bot responses,
    /// the content type is `application/amz-chime-lex-msgs` for success responses
    /// and
    /// `application/amz-chime-lex-error` for failure responses. For more
    /// information, refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    content_type: ?[]const u8,

    /// The attributes for the channel message. For Amazon Lex V2 bot responses, the
    /// attributes are mapped to specific fields from the bot. For more information,
    /// refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    message_attributes: ?[]const aws.map.MapEntry(MessageAttributeValue),

    /// The message ID.
    message_id: []const u8,

    /// The message metadata.
    metadata: ?[]const u8,

    /// The push notification configuration of the message.
    push_notification: ?PushNotificationConfiguration,

    /// The ID of the SubChannel.
    sub_channel_id: ?[]const u8,

    pub const json_field_names = .{
        .content = "Content",
        .content_type = "ContentType",
        .message_attributes = "MessageAttributes",
        .message_id = "MessageId",
        .metadata = "Metadata",
        .push_notification = "PushNotification",
        .sub_channel_id = "SubChannelId",
    };
};
