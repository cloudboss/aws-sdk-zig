/// The display options for margins around the outside edge of sheets.
pub const MarginStyle = struct {
    /// This Boolean value controls whether to display sheet margins.
    show: ?bool,

    pub const json_field_names = .{
        .show = "Show",
    };
};
