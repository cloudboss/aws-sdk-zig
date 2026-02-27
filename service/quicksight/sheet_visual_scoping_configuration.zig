const FilterVisualScope = @import("filter_visual_scope.zig").FilterVisualScope;

/// The filter that is applied to the options.
pub const SheetVisualScopingConfiguration = struct {
    /// The scope of the applied entities. Choose one of the following options:
    ///
    /// * `ALL_VISUALS`
    ///
    /// * `SELECTED_VISUALS`
    scope: FilterVisualScope,

    /// The selected sheet that the filter is applied to.
    sheet_id: []const u8,

    /// The selected visuals that the filter is applied to.
    visual_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .scope = "Scope",
        .sheet_id = "SheetId",
        .visual_ids = "VisualIds",
    };
};
