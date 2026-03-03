const TableBorderOptions = @import("table_border_options.zig").TableBorderOptions;

/// The side border options for a table.
pub const TableSideBorderOptions = struct {
    /// The table border options of the bottom border.
    bottom: ?TableBorderOptions = null,

    /// The table border options of the inner horizontal border.
    inner_horizontal: ?TableBorderOptions = null,

    /// The table border options of the inner vertical border.
    inner_vertical: ?TableBorderOptions = null,

    /// The table border options of the left border.
    left: ?TableBorderOptions = null,

    /// The table border options of the right border.
    right: ?TableBorderOptions = null,

    /// The table border options of the top border.
    top: ?TableBorderOptions = null,

    pub const json_field_names = .{
        .bottom = "Bottom",
        .inner_horizontal = "InnerHorizontal",
        .inner_vertical = "InnerVertical",
        .left = "Left",
        .right = "Right",
        .top = "Top",
    };
};
