const aws = @import("aws");

const Classification = @import("classification.zig").Classification;

/// The engine configuration for the workgroup, which includes the
/// minimum/maximum number of Data Processing Units (DPU) that queries should
/// use when
/// running in provisioned capacity. If not specified, Athena uses default
/// values (Default value for min is 4 and for max is Minimum of 124 and
/// allocated DPUs).
///
/// To specify DPU values for PC queries the WG containing EngineConfiguration
/// should have the following values:
/// The name of the Classifications should be `athena-query-engine-properties`,
/// with the only allowed properties as `max-dpu-count` and `min-dpu-count`.
pub const EngineConfiguration = struct {
    /// Contains additional notebook engine `MAP` parameter
    /// mappings in the form of key-value pairs. To specify an Athena notebook that
    /// the Jupyter server will download and serve, specify a value for the
    /// StartSessionRequest$NotebookVersion field, and then add a key named
    /// `NotebookId` to `AdditionalConfigs` that has the value of the
    /// Athena notebook ID.
    additional_configs: ?[]const aws.map.StringMapEntry,

    /// The configuration classifications that can be specified for the engine.
    classifications: ?[]const Classification,

    /// The number of DPUs to use for the coordinator. A coordinator is a special
    /// executor
    /// that orchestrates processing work and manages other executors in a notebook
    /// session. The
    /// default is 1.
    coordinator_dpu_size: ?i32,

    /// The default number of DPUs to use for executors. An executor is the smallest
    /// unit of
    /// compute that a notebook session can request from Athena. The default is
    /// 1.
    default_executor_dpu_size: ?i32,

    /// The maximum number of DPUs that can run concurrently.
    max_concurrent_dpus: i32 = 20,

    /// Specifies custom jar files and Spark properties for use cases like cluster
    /// encryption,
    /// table formats, and general Spark tuning.
    spark_properties: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .additional_configs = "AdditionalConfigs",
        .classifications = "Classifications",
        .coordinator_dpu_size = "CoordinatorDpuSize",
        .default_executor_dpu_size = "DefaultExecutorDpuSize",
        .max_concurrent_dpus = "MaxConcurrentDpus",
        .spark_properties = "SparkProperties",
    };
};
