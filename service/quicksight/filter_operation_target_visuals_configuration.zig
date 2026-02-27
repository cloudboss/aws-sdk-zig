const SameSheetTargetVisualConfiguration = @import("same_sheet_target_visual_configuration.zig").SameSheetTargetVisualConfiguration;

/// The configuration of target visuals that you want to be filtered.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const FilterOperationTargetVisualsConfiguration = struct {
    /// The configuration of the same-sheet target visuals that you want to be
    /// filtered.
    same_sheet_target_visual_configuration: ?SameSheetTargetVisualConfiguration,

    pub const json_field_names = .{
        .same_sheet_target_visual_configuration = "SameSheetTargetVisualConfiguration",
    };
};
