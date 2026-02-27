const TableBorderStyle = @import("table_border_style.zig").TableBorderStyle;

/// The border options for a table border.
pub const TableBorderOptions = struct {
    /// The color of a table border.
    color: ?[]const u8,

    /// The style (none, solid) of a table border.
    style: ?TableBorderStyle,

    /// The thickness of a table border.
    thickness: ?i32,

    pub const json_field_names = .{
        .color = "Color",
        .style = "Style",
        .thickness = "Thickness",
    };
};
