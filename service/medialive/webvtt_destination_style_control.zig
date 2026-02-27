/// Webvtt Destination Style Control
pub const WebvttDestinationStyleControl = enum {
    no_style_data,
    passthrough,

    pub const json_field_names = .{
        .no_style_data = "NO_STYLE_DATA",
        .passthrough = "PASSTHROUGH",
    };
};
