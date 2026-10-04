const RcsContent = @import("rcs_content.zig").RcsContent;
const RcsSuggestedAction = @import("rcs_suggested_action.zig").RcsSuggestedAction;

/// The content of an RCS message, containing the message body (text, file, rich
/// card, or carousel) and optional message-level suggested actions.
pub const RcsMessageContent = struct {
    /// The content of the RCS message. Exactly one content type must be specified:
    /// TextMessage, FileMessage, RichCard, or Carousel.
    content: RcsContent,

    /// Message-level suggested actions displayed to the recipient. Maximum 11
    /// suggestions per message.
    suggestions: ?[]const RcsSuggestedAction = null,

    pub const json_field_names = .{
        .content = "Content",
        .suggestions = "Suggestions",
    };
};
