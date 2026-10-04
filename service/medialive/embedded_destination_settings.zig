const EmbeddedCaptionPositionSettings = @import("embedded_caption_position_settings.zig").EmbeddedCaptionPositionSettings;
const EmbeddedDestinationStyleControl = @import("embedded_destination_style_control.zig").EmbeddedDestinationStyleControl;

/// Embedded Destination Settings
pub const EmbeddedDestinationSettings = struct {
    /// Specifies the position of the output captions. Applies only when
    /// styleControl is set to manual.
    position: ?EmbeddedCaptionPositionSettings = null,

    /// Controls the source of position and style information for the output
    /// captions.
    ///
    /// - "passthrough": Carry the caption position and style from the source
    /// captions. When the source captions are embedded, SCTE-20, or ancillary, the
    /// position and style are preserved exactly. When the source captions are
    /// another format, the position and any supported style are carried over.
    /// - "manual": Applies the specified styling and positioning. All other styling
    /// and positioning is given default values.
    style_control: ?EmbeddedDestinationStyleControl = null,

    pub const json_field_names = .{
        .position = "Position",
        .style_control = "StyleControl",
    };
};
