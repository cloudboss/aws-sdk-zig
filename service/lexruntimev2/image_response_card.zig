const Button = @import("button.zig").Button;

/// A card that is shown to the user by a messaging platform. You define
/// the contents of the card, the card is displayed by the platform.
///
/// When you use a response card, the response from the user is
/// constrained to the text associated with a button on the card.
pub const ImageResponseCard = struct {
    /// A list of buttons that should be displayed on the response card. The
    /// arrangement of the buttons is determined by the platform that displays
    /// the button.
    buttons: ?[]const Button = null,

    /// The URL of an image to display on the response card. The image URL
    /// must be publicly available so that the platform displaying the response
    /// card has access to the image.
    image_url: ?[]const u8 = null,

    /// The subtitle to display on the response card. The format of the
    /// subtitle is determined by the platform displaying the response
    /// card.
    subtitle: ?[]const u8 = null,

    /// The title to display on the response card. The format of the title
    /// is determined by the platform displaying the response card.
    title: []const u8,

    pub const json_field_names = .{
        .buttons = "buttons",
        .image_url = "imageUrl",
        .subtitle = "subtitle",
        .title = "title",
    };
};
