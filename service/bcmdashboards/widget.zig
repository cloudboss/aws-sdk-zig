const WidgetConfig = @import("widget_config.zig").WidgetConfig;

/// A configurable visualization component within a dashboard that displays
/// specific cost and usage metrics. Each widget can show data as charts or
/// tables and includes settings for data querying, filtering, and visual
/// presentation.
pub const Widget = struct {
    /// An array of configurations that define the data queries and display settings
    /// for the widget.
    configs: []const WidgetConfig,

    /// A description of the widget's purpose or the data it displays.
    description: ?[]const u8,

    /// The height of the widget in row spans. The dashboard layout consists of a
    /// grid system.
    height: i32 = 7,

    /// Specifies the starting column position of the widget in the dashboard's grid
    /// layout. Used to control widget placement.
    horizontal_offset: i32 = 0,

    /// The title of the widget.
    title: []const u8,

    /// The width of the widget in column spans. The dashboard layout consists of a
    /// grid system.
    width: i32 = 4,

    pub const json_field_names = .{
        .configs = "configs",
        .description = "description",
        .height = "height",
        .horizontal_offset = "horizontalOffset",
        .title = "title",
        .width = "width",
    };
};
