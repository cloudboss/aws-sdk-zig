const VisualCustomAction = @import("visual_custom_action.zig").VisualCustomAction;
const GeospatialMapConfiguration = @import("geospatial_map_configuration.zig").GeospatialMapConfiguration;
const ColumnHierarchy = @import("column_hierarchy.zig").ColumnHierarchy;
const GeocodePreference = @import("geocode_preference.zig").GeocodePreference;
const VisualSubtitleLabelOptions = @import("visual_subtitle_label_options.zig").VisualSubtitleLabelOptions;
const VisualTitleLabelOptions = @import("visual_title_label_options.zig").VisualTitleLabelOptions;

/// A geospatial map or a points on map visual.
///
/// For more information, see [Creating point
/// maps](https://docs.aws.amazon.com/quicksight/latest/user/point-maps.html) in
/// the *Amazon Quick Suite User Guide*.
pub const GeospatialMapVisual = struct {
    /// The list of custom actions that are configured for a visual.
    actions: ?[]const VisualCustomAction,

    /// The configuration settings of the visual.
    chart_configuration: ?GeospatialMapConfiguration,

    /// The column hierarchy that is used during drill-downs and drill-ups.
    column_hierarchies: ?[]const ColumnHierarchy,

    /// The geocoding prefences for geospatial map.
    geocoding_preferences: ?[]const GeocodePreference,

    /// The subtitle that is displayed on the visual.
    subtitle: ?VisualSubtitleLabelOptions,

    /// The title that is displayed on the visual.
    title: ?VisualTitleLabelOptions,

    /// The alt text for the visual.
    visual_content_alt_text: ?[]const u8,

    /// The unique identifier of a visual. This identifier must be unique within the
    /// context of a dashboard, template, or analysis. Two dashboards, analyses, or
    /// templates can have visuals with the same identifiers..
    visual_id: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .chart_configuration = "ChartConfiguration",
        .column_hierarchies = "ColumnHierarchies",
        .geocoding_preferences = "GeocodingPreferences",
        .subtitle = "Subtitle",
        .title = "Title",
        .visual_content_alt_text = "VisualContentAltText",
        .visual_id = "VisualId",
    };
};
