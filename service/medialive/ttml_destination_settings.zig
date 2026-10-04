const TextCaptionPositionSettings = @import("text_caption_position_settings.zig").TextCaptionPositionSettings;
const TtmlDestinationStyleControl = @import("ttml_destination_style_control.zig").TtmlDestinationStyleControl;

/// Ttml Destination Settings
pub const TtmlDestinationSettings = struct {
    /// Specifies the position of the output captions. Applies only when
    /// styleControl is set to manual.
    position: ?TextCaptionPositionSettings = null,

    /// Controls the source of style and position information for the output
    /// captions. PASSTHROUGH - Preserve the style and position from the source
    /// captions. USE_CONFIGURED - Don't pass through the style. The output captions
    /// will use the default styling. MANUAL - Applies the specified styling and
    /// positioning. All other styling and positioning is given default values.
    style_control: ?TtmlDestinationStyleControl = null,

    pub const json_field_names = .{
        .position = "Position",
        .style_control = "StyleControl",
    };
};
