const LegendPosition = @import("legend_position.zig").LegendPosition;
const LabelOptions = @import("label_options.zig").LabelOptions;
const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const Visibility = @import("visibility.zig").Visibility;

/// The options for the legend setup of a visual.
pub const LegendOptions = struct {
    /// The height of the legend. If this value is omitted, a default height is used
    /// when
    /// rendering.
    height: ?[]const u8 = null,

    /// The positions for the legend. Choose one of the following
    /// options:
    ///
    /// * `AUTO`
    ///
    /// * `RIGHT`
    ///
    /// * `BOTTOM`
    ///
    /// * `LEFT`
    position: ?LegendPosition = null,

    /// The custom title for the legend.
    title: ?LabelOptions = null,

    value_font_configuration: ?FontConfiguration = null,

    /// Determines whether or not the legend is visible.
    visibility: ?Visibility = null,

    /// The width of the legend. If this value is omitted, a default width is used
    /// when rendering.
    width: ?[]const u8 = null,

    pub const json_field_names = .{
        .height = "Height",
        .position = "Position",
        .title = "Title",
        .value_font_configuration = "ValueFontConfiguration",
        .visibility = "Visibility",
        .width = "Width",
    };
};
