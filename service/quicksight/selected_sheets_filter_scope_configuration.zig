const SheetVisualScopingConfiguration = @import("sheet_visual_scoping_configuration.zig").SheetVisualScopingConfiguration;

/// The configuration for applying a filter to specific sheets or visuals. You
/// can apply this filter to multiple visuals that are on one sheet or to all
/// visuals on a sheet.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const SelectedSheetsFilterScopeConfiguration = struct {
    /// The sheet ID and visual IDs of the sheet and visuals that the filter is
    /// applied to.
    sheet_visual_scoping_configurations: ?[]const SheetVisualScopingConfiguration,

    pub const json_field_names = .{
        .sheet_visual_scoping_configurations = "SheetVisualScopingConfigurations",
    };
};
