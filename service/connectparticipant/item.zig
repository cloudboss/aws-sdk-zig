const AttachmentItem = @import("attachment_item.zig").AttachmentItem;
const MessageMetadata = @import("message_metadata.zig").MessageMetadata;
const ParticipantRole = @import("participant_role.zig").ParticipantRole;
const ChatItemType = @import("chat_item_type.zig").ChatItemType;

/// An item - message or event - that has been sent.
pub const Item = struct {
    /// The time when the message or event was sent.
    ///
    /// It's specified in ISO 8601 format: yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    absolute_time: ?[]const u8 = null,

    /// Provides information about the attachments.
    attachments: ?[]const AttachmentItem = null,

    /// The contactId on which the transcript item was originally sent. This field
    /// is
    /// populated only when the transcript item is from the current chat session.
    contact_id: ?[]const u8 = null,

    /// The content of the message or event.
    content: ?[]const u8 = null,

    /// The type of content of the item.
    content_type: ?[]const u8 = null,

    /// The chat display name of the sender.
    display_name: ?[]const u8 = null,

    /// The ID of the item.
    id: ?[]const u8 = null,

    /// The metadata related to the message. Currently this supports only
    /// information related
    /// to message receipts.
    message_metadata: ?MessageMetadata = null,

    /// The ID of the sender in the session.
    participant_id: ?[]const u8 = null,

    /// The role of the sender. For example, is it a customer, agent, or system.
    participant_role: ?ParticipantRole = null,

    /// The contactId on which the transcript item was originally sent. This field
    /// is only
    /// populated for persistent chats when the transcript item is from the past
    /// chat session.
    /// For more information, see [Enable persistent
    /// chat](https://docs.aws.amazon.com/connect/latest/adminguide/chat-persistence.html).
    related_contact_id: ?[]const u8 = null,

    /// Type of the item: message or event.
    @"type": ?ChatItemType = null,

    pub const json_field_names = .{
        .absolute_time = "AbsoluteTime",
        .attachments = "Attachments",
        .contact_id = "ContactId",
        .content = "Content",
        .content_type = "ContentType",
        .display_name = "DisplayName",
        .id = "Id",
        .message_metadata = "MessageMetadata",
        .participant_id = "ParticipantId",
        .participant_role = "ParticipantRole",
        .related_contact_id = "RelatedContactId",
        .@"type" = "Type",
    };
};
