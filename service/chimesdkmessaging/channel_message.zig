const aws = @import("aws");

const MessageAttributeValue = @import("message_attribute_value.zig").MessageAttributeValue;
const ChannelMessagePersistenceType = @import("channel_message_persistence_type.zig").ChannelMessagePersistenceType;
const Identity = @import("identity.zig").Identity;
const ChannelMessageStatusStructure = @import("channel_message_status_structure.zig").ChannelMessageStatusStructure;
const Target = @import("target.zig").Target;
const ChannelMessageType = @import("channel_message_type.zig").ChannelMessageType;

/// The details of a message in a channel.
pub const ChannelMessage = struct {
    /// The ARN of the channel.
    channel_arn: ?[]const u8 = null,

    /// The content of the channel message. For Amazon Lex V2 bot responses, this
    /// field holds a list of messages originating from the bot. For more
    /// information, refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    content: ?[]const u8 = null,

    /// The content type of the channel message. For Amazon Lex V2 bot responses,
    /// the content type is `application/amz-chime-lex-msgs` for success responses
    /// and
    /// `application/amz-chime-lex-error` for failure responses. For more
    /// information, refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    content_type: ?[]const u8 = null,

    /// The time at which the message was created.
    created_timestamp: ?i64 = null,

    /// The time at which a message was edited.
    last_edited_timestamp: ?i64 = null,

    /// The time at which a message was updated.
    last_updated_timestamp: ?i64 = null,

    /// The attributes for the channel message. For Amazon Lex V2 bot responses, the
    /// attributes are mapped to specific fields from the bot. For more information,
    /// refer to
    /// [Processing responses from an
    /// AppInstanceBot](https://docs.aws.amazon.com/chime-sdk/latest/dg/appinstance-bots#process-response.html) in the
    /// *Amazon Chime SDK Messaging Developer Guide*.
    message_attributes: ?[]const aws.map.MapEntry(MessageAttributeValue) = null,

    /// The ID of a message.
    message_id: ?[]const u8 = null,

    /// The message metadata.
    metadata: ?[]const u8 = null,

    /// The persistence setting for a channel message.
    persistence: ?ChannelMessagePersistenceType = null,

    /// Hides the content of a message.
    redacted: bool = false,

    /// The message sender.
    sender: ?Identity = null,

    /// The status of the channel message.
    status: ?ChannelMessageStatusStructure = null,

    /// The ID of the SubChannel.
    sub_channel_id: ?[]const u8 = null,

    /// The target of a message, a sender, a user, or a bot. Only the target and the
    /// sender can view targeted messages.
    /// Only users who can see targeted messages can take actions on them. However,
    /// administrators can delete targeted messages that they can’t see.
    target: ?[]const Target = null,

    /// The message type.
    @"type": ?ChannelMessageType = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .content = "Content",
        .content_type = "ContentType",
        .created_timestamp = "CreatedTimestamp",
        .last_edited_timestamp = "LastEditedTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .message_attributes = "MessageAttributes",
        .message_id = "MessageId",
        .metadata = "Metadata",
        .persistence = "Persistence",
        .redacted = "Redacted",
        .sender = "Sender",
        .status = "Status",
        .sub_channel_id = "SubChannelId",
        .target = "Target",
        .@"type" = "Type",
    };
};
