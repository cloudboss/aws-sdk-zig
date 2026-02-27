const WebvttDestinationStyleControl = @import("webvtt_destination_style_control.zig").WebvttDestinationStyleControl;

/// Webvtt Destination Settings
pub const WebvttDestinationSettings = struct {
    /// Controls whether the color and position of the source captions is passed
    /// through to the WebVTT output captions. PASSTHROUGH - Valid only if the
    /// source captions are EMBEDDED or TELETEXT. NO_STYLE_DATA - Don't pass through
    /// the style. The output captions will not contain any font styling
    /// information.
    style_control: ?WebvttDestinationStyleControl,

    pub const json_field_names = .{
        .style_control = "StyleControl",
    };
};
