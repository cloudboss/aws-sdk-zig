const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const FilledMapConfiguration = @import("filled_map_configuration.zig").FilledMapConfiguration;
const ColumnHierarchy = @import("column_hierarchy.zig").ColumnHierarchy;
const FilledMapConditionalFormatting = @import("filled_map_conditional_formatting.zig").FilledMapConditionalFormatting;
const GeocodePreference = @import("geocode_preference.zig").GeocodePreference;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A filled map.
///
/// For more information, see [Creating filled
/// maps](https://docs.aws.amazon.com/quicksight/latest/user/filled-maps.html)
/// in the *Amazon Quick Suite User Guide*.
pub const FilledMapVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction = null,

    /// The configuration settings of the visual.
    chart_configuration: ?FilledMapConfiguration = null,

    /// The column hierarchy that is used during drill-downs and drill-ups.
    column_hierarchies: ?[]const ColumnHierarchy = null,

    /// The conditional formatting of a `FilledMapVisual`.
    conditional_formatting: ?FilledMapConditionalFormatting = null,

    /// The geocoding prefences for filled map visual.
    geocoding_preferences: ?[]const GeocodePreference = null,

    /// The subtitle that is displayed on the visual.
    subtitle: ?VisualSubtitleLabelOptions = null,

    /// The title that is displayed on the visual.
    title: ?VisualTitleLabelOptions = null,

    /// The alt text for the visual.
    visual_content_alt_text: ?[]const u8 = null,

    /// The unique identifier of a visual. This identifier must be unique within the
    /// context of a dashboard, template, or analysis. Two dashboards, analyses, or
    /// templates can have visuals with the same identifiers..
    visual_id: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .chart_configuration = "ChartConfiguration",
        .column_hierarchies = "ColumnHierarchies",
        .conditional_formatting = "ConditionalFormatting",
        .geocoding_preferences = "GeocodingPreferences",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
