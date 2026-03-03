const TtmlDestinationStyleControl = @import("ttml_destination_style_control.zig").TtmlDestinationStyleControl;

/// Ttml Destination Settings
pub const TtmlDestinationSettings = struct {
    /// This field is not currently supported and will not affect the output
    /// styling. Leave the default value.
    style_control: ?TtmlDestinationStyleControl = null,

    pub const json_field_names = .{
        .style_control = "StyleControl",
    };
};
