const DataQualityTargetTable = @import("data_quality_target_table.zig").DataQualityTargetTable;

/// The criteria used to filter data quality rulesets.
pub const DataQualityRulesetFilterCriteria = struct {
    /// Filter on rulesets created after this date.
    created_after: ?i64 = null,

    /// Filter on rulesets created before this date.
    created_before: ?i64 = null,

    /// The description of the ruleset filter criteria.
    description: ?[]const u8 = null,

    /// Filter on rulesets last modified after this date.
    last_modified_after: ?i64 = null,

    /// Filter on rulesets last modified before this date.
    last_modified_before: ?i64 = null,

    /// The name of the ruleset filter criteria.
    name: ?[]const u8 = null,

    /// The name and database name of the target table.
    target_table: ?DataQualityTargetTable = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .description = "Description",
        .last_modified_after = "LastModifiedAfter",
        .last_modified_before = "LastModifiedBefore",
        .name = "Name",
        .target_table = "TargetTable",
    };
};
