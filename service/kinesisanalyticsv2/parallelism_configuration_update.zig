const ConfigurationType = @import("configuration_type.zig").ConfigurationType;

/// Describes updates to parameters for how an application executes multiple
/// tasks simultaneously.
pub const ParallelismConfigurationUpdate = struct {
    /// Describes updates to whether the Managed Service for Apache Flink service
    /// can increase the parallelism of a Managed Service for Apache Flink
    /// application in response to increased throughput.
    auto_scaling_enabled_update: ?bool,

    /// Describes updates to whether the application uses the default parallelism
    /// for the Managed Service for Apache Flink service, or if a custom parallelism
    /// is used.
    /// You must set this property to `CUSTOM`
    /// in order to change your application's `AutoScalingEnabled`, `Parallelism`,
    /// or `ParallelismPerKPU` properties.
    configuration_type_update: ?ConfigurationType,

    /// Describes updates to the number of parallel tasks an application can perform
    /// per Kinesis Processing Unit (KPU) used by the application.
    parallelism_per_kpu_update: ?i32,

    /// Describes updates to the initial number of parallel tasks an application can
    /// perform. If `AutoScalingEnabled` is set to True, then
    /// Managed Service for Apache Flink can increase the `CurrentParallelism` value
    /// in response to application
    /// load. The service can increase `CurrentParallelism` up to the maximum
    /// parallelism, which is `ParalellismPerKPU` times the maximum KPUs for the
    /// application.
    /// The maximum KPUs for an application is 32 by default, and can be increased
    /// by requesting a limit increase. If application load is reduced, the service
    /// will
    /// reduce `CurrentParallelism` down to the `Parallelism` setting.
    parallelism_update: ?i32,

    pub const json_field_names = .{
        .auto_scaling_enabled_update = "AutoScalingEnabledUpdate",
        .configuration_type_update = "ConfigurationTypeUpdate",
        .parallelism_per_kpu_update = "ParallelismPerKPUUpdate",
        .parallelism_update = "ParallelismUpdate",
    };
};
