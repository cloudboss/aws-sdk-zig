const DisplayConfig = @import("display_config.zig").DisplayConfig;
const QueryParameters = @import("query_parameters.zig").QueryParameters;

/// Defines the complete configuration for a widget, including data retrieval
/// settings and visualization preferences.
pub const WidgetConfig = struct {
    /// The configuration that determines how the retrieved data should be
    /// visualized in the widget.
    display_config: DisplayConfig,

    /// The parameters that define what data the widget should retrieve and how it
    /// should be filtered or grouped.
    query_parameters: QueryParameters,

    pub const json_field_names = .{
        .display_config = "displayConfig",
        .query_parameters = "queryParameters",
    };
};
