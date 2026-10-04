const DataSource = @import("data_source.zig").DataSource;
const RecommendationMode = @import("recommendation_mode.zig").RecommendationMode;
const TaskStatusType = @import("task_status_type.zig").TaskStatusType;

/// Describes the result of a data quality rule recommendation run.
pub const DataQualityRuleRecommendationRunDescription = struct {
    /// The name of the ruleset that was created by the recommendation run.
    created_ruleset_name: ?[]const u8 = null,

    /// The data source (Glue table) associated with the recommendation run.
    data_source: ?DataSource = null,

    /// The mode that Glue Data Quality uses to recommend rules.
    ///
    /// The default is `BASIC`.
    recommendation_mode: ?RecommendationMode = null,

    /// The unique run identifier associated with this run.
    run_id: ?[]const u8 = null,

    /// The date and time when this run started.
    started_on: ?i64 = null,

    /// The status for this run.
    status: ?TaskStatusType = null,

    pub const json_field_names = .{
        .created_ruleset_name = "CreatedRulesetName",
        .data_source = "DataSource",
        .recommendation_mode = "RecommendationMode",
        .run_id = "RunId",
        .started_on = "StartedOn",
        .status = "Status",
    };
};
