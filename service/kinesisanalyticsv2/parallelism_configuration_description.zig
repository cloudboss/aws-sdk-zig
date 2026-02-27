const ConfigurationType = @import("configuration_type.zig").ConfigurationType;

/// Describes parameters for how a Managed Service for Apache Flink application
/// executes multiple tasks simultaneously.
pub const ParallelismConfigurationDescription = struct {
    /// Describes whether the Managed Service for Apache Flink service can increase
    /// the parallelism of the application in response to increased throughput.
    auto_scaling_enabled: ?bool,

    /// Describes whether the application uses the default parallelism for the
    /// Managed Service for Apache Flink service.
    configuration_type: ?ConfigurationType,

    /// Describes the current number of parallel tasks that a Managed Service for
    /// Apache Flink application can perform.
    /// If `AutoScalingEnabled` is set to True, Managed Service for Apache Flink can
    /// increase this value in response to application
    /// load. The service can increase this value up to the maximum parallelism,
    /// which is `ParalellismPerKPU` times the maximum KPUs for the application.
    /// The maximum KPUs for an application is 32 by default, and can be increased
    /// by requesting a limit increase. If application load is reduced, the service
    /// can reduce
    /// the `CurrentParallelism` value down to the `Parallelism` setting.
    current_parallelism: ?i32,

    /// Describes the initial number of parallel tasks that a Managed Service for
    /// Apache Flink application can perform. If
    /// `AutoScalingEnabled` is set to True, then Managed Service for Apache Flink
    /// can increase the
    /// `CurrentParallelism` value in response to application load. The service can
    /// increase `CurrentParallelism` up to the maximum parallelism, which is
    /// `ParalellismPerKPU` times the maximum KPUs for the application. The maximum
    /// KPUs
    /// for an application is 64 by default, and can be increased by requesting a
    /// limit increase. If
    /// application load is reduced, the service can reduce the `CurrentParallelism`
    /// value
    /// down to the `Parallelism` setting.
    parallelism: ?i32,

    /// Describes the number of parallel tasks that a Managed Service for Apache
    /// Flink application can perform per
    /// Kinesis Processing Unit (KPU) used by the application.
    parallelism_per_kpu: ?i32,

    pub const json_field_names = .{
        .auto_scaling_enabled = "AutoScalingEnabled",
        .configuration_type = "ConfigurationType",
        .current_parallelism = "CurrentParallelism",
        .parallelism = "Parallelism",
        .parallelism_per_kpu = "ParallelismPerKPU",
    };
};
