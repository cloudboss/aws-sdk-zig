const BatchArrayProperties = @import("batch_array_properties.zig").BatchArrayProperties;
const BatchRetryStrategy = @import("batch_retry_strategy.zig").BatchRetryStrategy;

/// The custom parameters to be used when the target is an Batch job.
pub const BatchParameters = struct {
    /// The array properties for the submitted job, such as the size of the array.
    /// The array size
    /// can be between 2 and 10,000. If you specify array properties for a job, it
    /// becomes an array
    /// job. This parameter is used only if the target is an Batch job.
    array_properties: ?BatchArrayProperties = null,

    /// The ARN or name of the job definition to use if the event target is an Batch
    /// job. This
    /// job definition must already exist.
    job_definition: []const u8,

    /// The name to use for this execution of the job, if the target is an Batch
    /// job.
    job_name: []const u8,

    /// The retry strategy to use for failed jobs, if the target is an Batch job.
    /// The retry
    /// strategy is the number of times to retry the failed job execution. Valid
    /// values are 1–10. When
    /// you specify a retry strategy here, it overrides the retry strategy defined
    /// in the job
    /// definition.
    retry_strategy: ?BatchRetryStrategy = null,

    pub const json_field_names = .{
        .array_properties = "ArrayProperties",
        .job_definition = "JobDefinition",
        .job_name = "JobName",
        .retry_strategy = "RetryStrategy",
    };
};
