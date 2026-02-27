const DataQualityTargetTable = @import("data_quality_target_table.zig").DataQualityTargetTable;

/// Describes a data quality ruleset returned by `GetDataQualityRuleset`.
pub const DataQualityRulesetListDetails = struct {
    /// The date and time the data quality ruleset was created.
    created_on: ?i64,

    /// A description of the data quality ruleset.
    description: ?[]const u8,

    /// The date and time the data quality ruleset was last modified.
    last_modified_on: ?i64,

    /// The name of the data quality ruleset.
    name: ?[]const u8,

    /// When a ruleset was created from a recommendation run, this run ID is
    /// generated to link the two together.
    recommendation_run_id: ?[]const u8,

    /// The number of rules in the ruleset.
    rule_count: ?i32,

    /// An object representing an Glue table.
    target_table: ?DataQualityTargetTable,

    pub const json_field_names = .{
        .created_on = "CreatedOn",
        .description = "Description",
        .last_modified_on = "LastModifiedOn",
        .name = "Name",
        .recommendation_run_id = "RecommendationRunId",
        .rule_count = "RuleCount",
        .target_table = "TargetTable",
    };
};
