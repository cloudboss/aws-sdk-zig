/// Specify the color of the rectangle behind the captions. Leave background
/// color blank and set Style passthrough to enabled to use the background color
/// data from your input captions, if present.
pub const DvbSubtitleBackgroundColor = enum {
    none,
    black,
    white,
    auto,

    pub const json_field_names = .{
        .none = "NONE",
        .black = "BLACK",
        .white = "WHITE",
        .auto = "AUTO",
    };
};
