const DataSource = @import("data_source.zig").DataSource;
const TaskStatusType = @import("task_status_type.zig").TaskStatusType;

/// Describes the result of a data quality ruleset evaluation run.
pub const DataQualityRulesetEvaluationRunDescription = struct {
    /// The data source (an Glue table) associated with the run.
    data_source: ?DataSource,

    /// The unique run identifier associated with this run.
    run_id: ?[]const u8,

    /// The date and time when the run started.
    started_on: ?i64,

    /// The status for this run.
    status: ?TaskStatusType,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .run_id = "RunId",
        .started_on = "StartedOn",
        .status = "Status",
    };
};
