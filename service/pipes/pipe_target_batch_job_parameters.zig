const aws = @import("aws");

const BatchArrayProperties = @import("batch_array_properties.zig").BatchArrayProperties;
const BatchContainerOverrides = @import("batch_container_overrides.zig").BatchContainerOverrides;
const BatchJobDependency = @import("batch_job_dependency.zig").BatchJobDependency;
const BatchRetryStrategy = @import("batch_retry_strategy.zig").BatchRetryStrategy;

/// The parameters for using an Batch job as a target.
pub const PipeTargetBatchJobParameters = struct {
    /// The array properties for the submitted job, such as the size of the array.
    /// The array size can be between 2 and 10,000.
    /// If you specify array properties for a job, it becomes an array job. This
    /// parameter is used only if the target is an Batch job.
    array_properties: ?BatchArrayProperties = null,

    /// The overrides that are sent to a container.
    container_overrides: ?BatchContainerOverrides = null,

    /// A list of dependencies for the job. A job can depend upon a maximum of 20
    /// jobs. You can
    /// specify a `SEQUENTIAL` type dependency without specifying a job ID for array
    /// jobs so that each child array job completes sequentially, starting at index
    /// 0. You can also
    /// specify an `N_TO_N` type dependency with a job ID for array jobs. In that
    /// case,
    /// each index child of this job must wait for the corresponding index child of
    /// each dependency
    /// to complete before it can begin.
    depends_on: ?[]const BatchJobDependency = null,

    /// The job definition used by this job. This value can be one of `name`,
    /// `name:revision`, or the Amazon Resource Name (ARN) for the job definition.
    /// If
    /// name is specified without a revision then the latest active revision is
    /// used.
    job_definition: []const u8,

    /// The name of the job. It can be up to 128 letters long. The first character
    /// must be
    /// alphanumeric, can contain uppercase and lowercase letters, numbers, hyphens
    /// (-), and
    /// underscores (_).
    job_name: []const u8,

    /// Additional parameters passed to the job that replace parameter substitution
    /// placeholders
    /// that are set in the job definition. Parameters are specified as a key and
    /// value pair
    /// mapping. Parameters included here override any corresponding parameter
    /// defaults from the
    /// job definition.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The retry strategy to use for failed jobs. When a retry strategy is
    /// specified here, it
    /// overrides the retry strategy defined in the job definition.
    retry_strategy: ?BatchRetryStrategy = null,

    pub const json_field_names = .{
        .array_properties = "ArrayProperties",
        .container_overrides = "ContainerOverrides",
        .depends_on = "DependsOn",
        .job_definition = "JobDefinition",
        .job_name = "JobName",
        .parameters = "Parameters",
        .retry_strategy = "RetryStrategy",
    };
};
