const aws = @import("aws");

/// Configuration information for updating the Amazon SageMaker Debugger profile
/// parameters, system and framework metrics configurations, and storage paths.
pub const ProfilerConfigForUpdate = struct {
    /// To turn off Amazon SageMaker Debugger monitoring and profiling while a
    /// training job is in progress, set to `True`.
    disable_profiler: ?bool,

    /// A time interval for capturing system metrics in milliseconds. Available
    /// values are 100, 200, 500, 1000 (1 second), 5000 (5 seconds), and 60000 (1
    /// minute) milliseconds. The default value is 500 milliseconds.
    profiling_interval_in_milliseconds: ?i64,

    /// Configuration information for capturing framework metrics. Available key
    /// strings for different profiling options are `DetailedProfilingConfig`,
    /// `PythonProfilingConfig`, and `DataLoaderProfilingConfig`. The following
    /// codes are configuration structures for the `ProfilingParameters` parameter.
    /// To learn more about how to configure the `ProfilingParameters` parameter,
    /// see [Use the SageMaker and Debugger Configuration API Operations to Create,
    /// Update, and Debug Your Training
    /// Job](https://docs.aws.amazon.com/sagemaker/latest/dg/debugger-createtrainingjob-api.html).
    profiling_parameters: ?[]const aws.map.StringMapEntry,

    /// Path to Amazon S3 storage location for system and framework metrics.
    s3_output_path: ?[]const u8,

    pub const json_field_names = .{
        .disable_profiler = "DisableProfiler",
        .profiling_interval_in_milliseconds = "ProfilingIntervalInMilliseconds",
        .profiling_parameters = "ProfilingParameters",
        .s3_output_path = "S3OutputPath",
    };
};
