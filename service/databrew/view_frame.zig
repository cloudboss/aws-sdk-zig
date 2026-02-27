const AnalyticsMode = @import("analytics_mode.zig").AnalyticsMode;

/// Represents the data being transformed during an action.
pub const ViewFrame = struct {
    /// Controls if analytics computation is enabled or disabled. Enabled by
    /// default.
    analytics: ?AnalyticsMode,

    /// The number of columns to include in the view frame, beginning with the
    /// `StartColumnIndex` value and ignoring any columns in the
    /// `HiddenColumns` list.
    column_range: ?i32,

    /// A list of columns to hide in the view frame.
    hidden_columns: ?[]const []const u8,

    /// The number of rows to include in the view frame, beginning with the
    /// `StartRowIndex` value.
    row_range: ?i32,

    /// The starting index for the range of columns to return in the view frame.
    start_column_index: i32,

    /// The starting index for the range of rows to return in the view frame.
    start_row_index: ?i32,

    pub const json_field_names = .{
        .analytics = "Analytics",
        .column_range = "ColumnRange",
        .hidden_columns = "HiddenColumns",
        .row_range = "RowRange",
        .start_column_index = "StartColumnIndex",
        .start_row_index = "StartRowIndex",
    };
};
