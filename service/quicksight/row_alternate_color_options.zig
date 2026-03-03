const WidgetStatus = @import("widget_status.zig").WidgetStatus;

/// Determines the row alternate color options.
pub const RowAlternateColorOptions = struct {
    /// Determines the list of row alternate colors.
    row_alternate_colors: ?[]const []const u8 = null,

    /// Determines the widget status.
    status: ?WidgetStatus = null,

    /// The primary background color options for alternate rows.
    use_primary_background_color: ?WidgetStatus = null,

    pub const json_field_names = .{
        .row_alternate_colors = "RowAlternateColors",
        .status = "Status",
        .use_primary_background_color = "UsePrimaryBackgroundColor",
    };
};
