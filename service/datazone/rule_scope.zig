const AssetTypesForRule = @import("asset_types_for_rule.zig").AssetTypesForRule;
const ProjectsForRule = @import("projects_for_rule.zig").ProjectsForRule;

/// The scope of a rule.
pub const RuleScope = struct {
    /// The asset type included in the rule scope.
    asset_type: ?AssetTypesForRule,

    /// The data product included in the rule scope.
    data_product: ?bool,

    /// The project included in the rule scope.
    project: ?ProjectsForRule,

    pub const json_field_names = .{
        .asset_type = "assetType",
        .data_product = "dataProduct",
        .project = "project",
    };
};
