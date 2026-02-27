/// Specify the color of the shadow cast by the captions. Leave Shadow color
/// blank and set Style passthrough to enabled to use the shadow color data from
/// your input captions, if present. Within your job settings, all of your
/// DVB-Sub settings must be identical.
pub const DvbSubtitleShadowColor = enum {
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
