pub const MediaType = enum {
    image_logo_light_favicon,
    image_logo_dark_favicon,
    image_logo_light_horizontal,
    image_logo_dark_horizontal,

    pub const json_field_names = .{
        .image_logo_light_favicon = "IMAGE_LOGO_LIGHT_FAVICON",
        .image_logo_dark_favicon = "IMAGE_LOGO_DARK_FAVICON",
        .image_logo_light_horizontal = "IMAGE_LOGO_LIGHT_HORIZONTAL",
        .image_logo_dark_horizontal = "IMAGE_LOGO_DARK_HORIZONTAL",
    };
};
