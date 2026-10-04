const RcsCarouselCardMedia = @import("rcs_carousel_card_media.zig").RcsCarouselCardMedia;
const RcsSuggestedAction = @import("rcs_suggested_action.zig").RcsSuggestedAction;

/// The content of a carousel card, including title, description, media, and
/// card-level suggested actions. Media height is restricted to SHORT or MEDIUM.
pub const RcsCarouselCardContent = struct {
    /// The description text of the carousel card. Maximum 2000 characters.
    description: ?[]const u8 = null,

    /// The media content of the carousel card. Media height is restricted to SHORT
    /// or MEDIUM (TALL is not supported in carousels).
    media: ?RcsCarouselCardMedia = null,

    /// Card-level suggested actions for this carousel card. Maximum 4 suggestions
    /// per card.
    suggestions: ?[]const RcsSuggestedAction = null,

    /// The title of the carousel card. Maximum 200 characters.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .media = "Media",
        .suggestions = "Suggestions",
        .title = "Title",
    };
};
