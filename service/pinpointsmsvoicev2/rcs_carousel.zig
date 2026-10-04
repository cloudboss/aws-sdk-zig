const RcsCarouselCardContent = @import("rcs_carousel_card_content.zig").RcsCarouselCardContent;

/// A carousel of 2 to 10 scrollable rich cards.
pub const RcsCarousel = struct {
    /// The list of cards in the carousel. Minimum 2, maximum 10 cards.
    card_contents: []const RcsCarouselCardContent,

    /// The width of cards in the carousel. Valid values are SMALL and MEDIUM.
    card_width: []const u8,

    pub const json_field_names = .{
        .card_contents = "CardContents",
        .card_width = "CardWidth",
    };
};
