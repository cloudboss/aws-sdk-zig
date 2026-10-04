const RcsCardMedia = @import("rcs_card_media.zig").RcsCardMedia;
const RcsSuggestedAction = @import("rcs_suggested_action.zig").RcsSuggestedAction;

/// The content of a rich card, including title, description, media, and
/// card-level suggested actions.
pub const RcsCardContent = struct {
    /// The description text of the card. Maximum 2000 characters.
    description: ?[]const u8 = null,

    /// The media content of the card, including the file URL, optional thumbnail,
    /// and display height.
    media: ?RcsCardMedia = null,

    /// Card-level suggested actions. Maximum 4 suggestions per card.
    suggestions: ?[]const RcsSuggestedAction = null,

    /// The title of the card. Maximum 200 characters.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .media = "Media",
        .suggestions = "Suggestions",
        .title = "Title",
    };
};
