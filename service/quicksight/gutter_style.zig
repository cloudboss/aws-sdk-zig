/// The display options for gutter spacing between tiles on a sheet.
pub const GutterStyle = struct {
    /// This Boolean value controls whether to display a gutter space between sheet
    /// tiles.
    show: ?bool = null,

    pub const json_field_names = .{
        .show = "Show",
    };
};
