const aws = @import("aws");

const MessageAttributeValue = @import("message_attribute_value.zig").MessageAttributeValue;
const Identity = @import("identity.zig").Identity;
const ChannelMessageStatusStructure = @import("channel_message_status_structure.zig").ChannelMessageStatusStructure;
const Target = @import("target.zig").Target;
const ChannelMessageType = @import("channel_message_type.zig").ChannelMessageType;

/// Summary of the messages in a `Channel`.
pub const ChannelMessageSummary = struct {
    /// The content of the channel message. For Amazon Lex V2 bot responses, this
    /// field holds a list of messages originating from the bot. For more
    /// information, refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    content: ?[]const u8,

    /// The content type of the channel message listed in the summary. For Amazon
    /// Lex V2 bot responses, the content type is `application/amz-chime-lex-msgs`
    /// for success responses and
    /// `application/amz-chime-lex-error` for failure responses. For more
    /// information, refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    content_type: ?[]const u8,

    /// The time at which the message summary was created.
    created_timestamp: ?i64,

    /// The time at which a message was last edited.
    last_edited_timestamp: ?i64,

    /// The time at which a message was last updated.
    last_updated_timestamp: ?i64,

    /// The attributes for the channel message. For Amazon Lex V2 bot responses, the
    /// attributes are mapped to specific fields from the bot. For more information,
    /// refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    message_attributes: ?[]const aws.map.MapEntry(MessageAttributeValue),

    /// The ID of the message.
    message_id: ?[]const u8,

    /// The metadata of the message.
    metadata: ?[]const u8,

    /// Indicates whether a message was redacted.
    redacted: bool = false,

    /// The message sender.
    sender: ?Identity,

    /// The message status. The status value is `SENT` for messages sent to a
    /// channel without a channel flow. For channels associated with channel flow,
    /// the value determines the
    /// processing stage.
    status: ?ChannelMessageStatusStructure,

    /// The target of a message, a sender, a user, or a bot. Only the target and the
    /// sender can view targeted messages.
    /// Only users who can see targeted messages can take actions on them. However,
    /// administrators can delete targeted messages that they can’t see.
    target: ?[]const Target,

    /// The type of message.
    type: ?ChannelMessageType,

    pub const json_field_names = .{
        .content = "Content",
        .content_type = "ContentType",
        .created_timestamp = "CreatedTimestamp",
        .last_edited_timestamp = "LastEditedTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .message_attributes = "MessageAttributes",
        .message_id = "MessageId",
        .metadata = "Metadata",
        .redacted = "Redacted",
        .sender = "Sender",
        .status = "Status",
        .target = "Target",
        .type = "Type",
    };
};
