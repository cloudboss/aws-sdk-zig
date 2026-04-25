/// The configuration of the sheet tooltip.
pub const SheetTooltip = struct {
    /// The sheet ID of the tooltip sheet that is used by the tooltip.
    sheet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .sheet_id = "SheetId",
    };
};
