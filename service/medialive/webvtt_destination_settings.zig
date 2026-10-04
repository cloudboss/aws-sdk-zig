const TextCaptionPositionSettings = @import("text_caption_position_settings.zig").TextCaptionPositionSettings;
const WebvttDestinationStyleControl = @import("webvtt_destination_style_control.zig").WebvttDestinationStyleControl;

/// Webvtt Destination Settings
pub const WebvttDestinationSettings = struct {
    /// Specifies the position of the output captions. Applies only when
    /// styleControl is set to manual.
    position: ?TextCaptionPositionSettings = null,

    /// Controls whether the color and position of the source captions is passed
    /// through to the WebVTT output captions. PASSTHROUGH - Valid only if the
    /// source captions are EMBEDDED, TELETEXT, or SMART SUBTITLES. NO_STYLE_DATA -
    /// Don't pass through the style. The output captions will not contain any font
    /// styling information. MANUAL - Applies the specified styling and positioning.
    /// All other styling and positioning is given default values.
    style_control: ?WebvttDestinationStyleControl = null,

    pub const json_field_names = .{
        .position = "Position",
        .style_control = "StyleControl",
    };
};
