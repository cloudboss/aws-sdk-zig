const RcsCarousel = @import("rcs_carousel.zig").RcsCarousel;
const RcsFileMessage = @import("rcs_file_message.zig").RcsFileMessage;
const RcsStandaloneCard = @import("rcs_standalone_card.zig").RcsStandaloneCard;
const RcsTextMessage = @import("rcs_text_message.zig").RcsTextMessage;

/// The message body of an RCS message. Exactly one content type must be
/// specified.
pub const RcsContent = union(enum) {
    /// A carousel of 2 to 10 scrollable cards, each with media, title, description,
    /// and suggested actions.
    carousel: ?RcsCarousel,
    /// A file message containing a media file (image, video, audio, or PDF) with an
    /// optional thumbnail.
    file_message: ?RcsFileMessage,
    /// A standalone rich card with media, title, description, and suggested
    /// actions.
    rich_card: ?RcsStandaloneCard,
    /// A plain text RCS message.
    text_message: ?RcsTextMessage,

    pub const json_field_names = .{
        .carousel = "Carousel",
        .file_message = "FileMessage",
        .rich_card = "RichCard",
        .text_message = "TextMessage",
    };
};
