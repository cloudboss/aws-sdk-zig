const DatabaseOutput = @import("database_output.zig").DatabaseOutput;
const DataCatalogOutput = @import("data_catalog_output.zig").DataCatalogOutput;
const JobSample = @import("job_sample.zig").JobSample;
const LogSubscription = @import("log_subscription.zig").LogSubscription;
const Output = @import("output.zig").Output;
const RecipeReference = @import("recipe_reference.zig").RecipeReference;
const JobRunState = @import("job_run_state.zig").JobRunState;
const ValidationConfiguration = @import("validation_configuration.zig").ValidationConfiguration;

/// Represents one run of a DataBrew job.
pub const JobRun = struct {
    /// The number of times that DataBrew has attempted to run the job.
    attempt: i32 = 0,

    /// The date and time when the job completed processing.
    completed_on: ?i64,

    /// Represents a list of JDBC database output objects which defines the output
    /// destination for a DataBrew recipe job to write into.
    database_outputs: ?[]const DatabaseOutput,

    /// One or more artifacts that represent the Glue Data Catalog output
    /// from running the job.
    data_catalog_outputs: ?[]const DataCatalogOutput,

    /// The name of the dataset for the job to process.
    dataset_name: ?[]const u8,

    /// A message indicating an error (if any) that was encountered when the job
    /// ran.
    error_message: ?[]const u8,

    /// The amount of time, in seconds, during which a job run consumed resources.
    execution_time: i32 = 0,

    /// The name of the job being processed during this run.
    job_name: ?[]const u8,

    /// A sample configuration for profile jobs only, which determines the number of
    /// rows on which the
    /// profile job is run. If a `JobSample` value isn't provided, the default
    /// is used. The default value is CUSTOM_ROWS for the mode parameter and 20,000
    /// for the
    /// size parameter.
    job_sample: ?JobSample,

    /// The name of an Amazon CloudWatch log group, where the job writes diagnostic
    /// messages
    /// when it runs.
    log_group_name: ?[]const u8,

    /// The current status of Amazon CloudWatch logging for the job run.
    log_subscription: ?LogSubscription,

    /// One or more output artifacts from a job run.
    outputs: ?[]const Output,

    /// The set of steps processed by the job.
    recipe_reference: ?RecipeReference,

    /// The unique identifier of the job run.
    run_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the user who initiated the job run.
    started_by: ?[]const u8,

    /// The date and time when the job run began.
    started_on: ?i64,

    /// The current state of the job run entity itself.
    state: ?JobRunState,

    /// List of validation configurations that are applied to the profile job run.
    validation_configurations: ?[]const ValidationConfiguration,

    pub const json_field_names = .{
        .attempt = "Attempt",
        .completed_on = "CompletedOn",
        .database_outputs = "DatabaseOutputs",
        .data_catalog_outputs = "DataCatalogOutputs",
        .dataset_name = "DatasetName",
        .error_message = "ErrorMessage",
        .execution_time = "ExecutionTime",
        .job_name = "JobName",
        .job_sample = "JobSample",
        .log_group_name = "LogGroupName",
        .log_subscription = "LogSubscription",
        .outputs = "Outputs",
        .recipe_reference = "RecipeReference",
        .run_id = "RunId",
        .started_by = "StartedBy",
        .started_on = "StartedOn",
        .state = "State",
        .validation_configurations = "ValidationConfigurations",
    };
};
