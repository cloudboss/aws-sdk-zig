const aws = @import("aws");

/// Configuration information for Amazon SageMaker Debugger system monitoring,
/// framework profiling, and storage paths.
pub const ProfilerConfig = struct {
    /// Configuration to turn off Amazon SageMaker Debugger's system monitoring and
    /// profiling functionality. To turn it off, set to `True`.
    disable_profiler: ?bool = null,

    /// A time interval for capturing system metrics in milliseconds. Available
    /// values are 100, 200, 500, 1000 (1 second), 5000 (5 seconds), and 60000 (1
    /// minute) milliseconds. The default value is 500 milliseconds.
    profiling_interval_in_milliseconds: ?i64 = null,

    /// Configuration information for capturing framework metrics. Available key
    /// strings for different profiling options are `DetailedProfilingConfig`,
    /// `PythonProfilingConfig`, and `DataLoaderProfilingConfig`. The following
    /// codes are configuration structures for the `ProfilingParameters` parameter.
    /// To learn more about how to configure the `ProfilingParameters` parameter,
    /// see [Use the SageMaker and Debugger Configuration API Operations to Create,
    /// Update, and Debug Your Training
    /// Job](https://docs.aws.amazon.com/sagemaker/latest/dg/debugger-createtrainingjob-api.html).
    profiling_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Path to Amazon S3 storage location for system and framework metrics.
    s3_output_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .disable_profiler = "DisableProfiler",
        .profiling_interval_in_milliseconds = "ProfilingIntervalInMilliseconds",
        .profiling_parameters = "ProfilingParameters",
        .s3_output_path = "S3OutputPath",
    };
};
