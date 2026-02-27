const RehydrationType = @import("rehydration_type.zig").RehydrationType;

/// Enable persistent chats. For more information about enabling persistent
/// chat, and for example use cases and how
/// to configure for them, see [Enable
/// persistent
/// chat](https://docs.aws.amazon.com/connect/latest/adminguide/chat-persistence.html).
pub const PersistentChat = struct {
    /// The contactId that is used for rehydration depends on the rehydration type.
    /// RehydrationType is required for
    /// persistent chat.
    ///
    /// * `ENTIRE_PAST_SESSION`: Rehydrates a chat from the most recently terminated
    ///   past chat contact of the
    /// specified past ended chat session. To use this type, provide the
    /// `initialContactId` of the past ended
    /// chat session in the `sourceContactId` field. In this type, Amazon Connect
    /// determines the most recent
    /// chat contact on the specified chat session that has ended, and uses it to
    /// start a persistent chat.
    ///
    /// * `FROM_SEGMENT`: Rehydrates a chat from the past chat contact that is
    ///   specified in the
    /// `sourceContactId` field.
    ///
    /// The actual contactId used for rehydration is provided in the response of
    /// this API.
    rehydration_type: ?RehydrationType,

    /// The contactId from which a persistent chat session must be started.
    source_contact_id: ?[]const u8,

    pub const json_field_names = .{
        .rehydration_type = "RehydrationType",
        .source_contact_id = "SourceContactId",
    };
};
