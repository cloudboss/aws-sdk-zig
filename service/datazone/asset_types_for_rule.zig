const RuleScopeSelectionMode = @import("rule_scope_selection_mode.zig").RuleScopeSelectionMode;

/// The asset type for the rule details.
pub const AssetTypesForRule = struct {
    /// The selection mode for the rule.
    selection_mode: RuleScopeSelectionMode,

    /// The specific asset types that are included in the rule.
    specific_asset_types: ?[]const []const u8,

    pub const json_field_names = .{
        .selection_mode = "selectionMode",
        .specific_asset_types = "specificAssetTypes",
    };
};
