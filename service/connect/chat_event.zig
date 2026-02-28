const ChatEventType = @import("chat_event_type.zig").ChatEventType;

/// Chat integration event containing payload to perform different chat actions
/// such as:
///
/// * Sending a chat message
///
/// * Sending a chat event, such as typing
///
/// * Disconnecting from a chat
pub const ChatEvent = struct {
    /// Content of the message or event. This is required when `Type` is `MESSAGE`
    /// and for certain
    /// `ContentTypes` when `Type` is `EVENT`.
    ///
    /// * For allowed message content, see the `Content` parameter in the
    ///   [SendMessage](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_SendMessage.html) topic in the
    /// *Amazon Connect Participant Service API Reference*.
    ///
    /// * For allowed event content, see the `Content` parameter in the
    ///   [SendEvent](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_SendEvent.html) topic in the *Amazon Connect Participant Service API Reference*.
    content: ?[]const u8,

    /// Type of content. This is required when `Type` is `MESSAGE` or `EVENT`.
    ///
    /// * For allowed message content types, see the `ContentType` parameter in the
    ///   [SendMessage](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_SendMessage.html) topic
    /// in the *Amazon Connect Participant Service API Reference*.
    ///
    /// * For allowed event content types, see the `ContentType` parameter in the
    ///   [SendEvent](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_SendEvent.html) topic in the *Amazon Connect Participant Service API Reference*.
    content_type: ?[]const u8,

    /// Type of chat integration event.
    @"type": ChatEventType,

    pub const json_field_names = .{
        .content = "Content",
        .content_type = "ContentType",
        .@"type" = "Type",
    };
};
