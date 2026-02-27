/// The navigation configuration for `CustomActionNavigationOperation`.
pub const LocalNavigationConfiguration = struct {
    /// The sheet that is targeted for navigation in the same analysis.
    target_sheet_id: []const u8,

    pub const json_field_names = .{
        .target_sheet_id = "TargetSheetId",
    };
};
