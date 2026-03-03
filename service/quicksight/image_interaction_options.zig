const ImageMenuOption = @import("image_menu_option.zig").ImageMenuOption;

/// The general image interactions setup for image publish options.
pub const ImageInteractionOptions = struct {
    /// The menu options for the image.
    image_menu_option: ?ImageMenuOption = null,

    pub const json_field_names = .{
        .image_menu_option = "ImageMenuOption",
    };
};
