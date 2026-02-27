const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const Font = @import("font.zig").Font;
const VisualSubtitleFontConfiguration = @import("visual_subtitle_font_configuration.zig").VisualSubtitleFontConfiguration;
const VisualTitleFontConfiguration = @import("visual_title_font_configuration.zig").VisualTitleFontConfiguration;

/// Determines the typography options.
pub const Typography = struct {
    axis_label_font_configuration: ?FontConfiguration,

    axis_title_font_configuration: ?FontConfiguration,

    data_label_font_configuration: ?FontConfiguration,

    /// Determines the list of font families.
    font_families: ?[]const Font,

    legend_title_font_configuration: ?FontConfiguration,

    legend_value_font_configuration: ?FontConfiguration,

    /// Configures the display properties of the visual sub-title.
    visual_subtitle_font_configuration: ?VisualSubtitleFontConfiguration,

    /// Configures the display properties of the visual title.
    visual_title_font_configuration: ?VisualTitleFontConfiguration,

    pub const json_field_names = .{
        .axis_label_font_configuration = "AxisLabelFontConfiguration",
        .axis_title_font_configuration = "AxisTitleFontConfiguration",
        .data_label_font_configuration = "DataLabelFontConfiguration",
        .font_families = "FontFamilies",
        .legend_title_font_configuration = "LegendTitleFontConfiguration",
        .legend_value_font_configuration = "LegendValueFontConfiguration",
        .visual_subtitle_font_configuration = "VisualSubtitleFontConfiguration",
        .visual_title_font_configuration = "VisualTitleFontConfiguration",
    };
};
