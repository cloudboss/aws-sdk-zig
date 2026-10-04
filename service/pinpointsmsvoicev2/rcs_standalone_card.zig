const RcsCardContent = @import("rcs_card_content.zig").RcsCardContent;

/// A standalone rich card with media, title, description, and suggested
/// actions.
pub const RcsStandaloneCard = struct {
    /// The content of the rich card, including title, description, media, and
    /// card-level suggested actions.
    card_content: RcsCardContent,

    /// The orientation of the rich card. Valid values are HORIZONTAL and VERTICAL.
    card_orientation: []const u8,

    /// The alignment of the thumbnail image in a horizontal card. Valid values are
    /// LEFT and RIGHT. Only applicable when CardOrientation is HORIZONTAL.
    thumbnail_image_alignment: ?[]const u8 = null,

    pub const json_field_names = .{
        .card_content = "CardContent",
        .card_orientation = "CardOrientation",
        .thumbnail_image_alignment = "ThumbnailImageAlignment",
    };
};
