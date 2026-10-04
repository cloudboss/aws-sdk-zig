const aws = @import("aws");

const DataSource = @import("data_source.zig").DataSource;
const DataQualityEvaluationRunAdditionalRunOptions = @import("data_quality_evaluation_run_additional_run_options.zig").DataQualityEvaluationRunAdditionalRunOptions;
const TaskStatusType = @import("task_status_type.zig").TaskStatusType;

/// The details of a data quality ruleset evaluation run.
pub const DataQualityRulesetEvaluationRun = struct {
    /// A map of reference strings to additional data sources you can specify for an
    /// evaluation run.
    additional_data_sources: ?[]const aws.map.MapEntry(DataSource) = null,

    additional_run_options: ?DataQualityEvaluationRunAdditionalRunOptions = null,

    /// The date and time when this run was completed.
    completed_on: ?i64 = null,

    data_source: ?DataSource = null,

    /// The error strings that are associated with the run.
    error_string: ?[]const u8 = null,

    /// The amount of time (in seconds) that the run consumed resources.
    execution_time: i32 = 0,

    /// A timestamp. The last point in time when this run was modified.
    last_modified_on: ?i64 = null,

    /// The number of `G.1X` workers to be used in the run. The default is 5.
    number_of_workers: ?i32 = null,

    /// A list of result IDs for the data quality results for the run.
    result_ids: ?[]const []const u8 = null,

    /// An IAM role supplied to encrypt the results of the run.
    role: ?[]const u8 = null,

    /// A list of ruleset names for the run.
    ruleset_names: ?[]const []const u8 = null,

    /// The unique run identifier associated with this run.
    run_id: ?[]const u8 = null,

    /// The date and time when this run started.
    started_on: ?i64 = null,

    /// The status for this run.
    status: ?TaskStatusType = null,

    /// The timeout for a run in minutes. This is the maximum time that a run can
    /// consume resources before it is terminated and enters `TIMEOUT` status. The
    /// default is 2,880 minutes (48 hours).
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .additional_data_sources = "AdditionalDataSources",
        .additional_run_options = "AdditionalRunOptions",
        .completed_on = "CompletedOn",
        .data_source = "DataSource",
        .error_string = "ErrorString",
        .execution_time = "ExecutionTime",
        .last_modified_on = "LastModifiedOn",
        .number_of_workers = "NumberOfWorkers",
        .result_ids = "ResultIds",
        .role = "Role",
        .ruleset_names = "RulesetNames",
        .run_id = "RunId",
        .started_on = "StartedOn",
        .status = "Status",
        .timeout = "Timeout",
    };
};
