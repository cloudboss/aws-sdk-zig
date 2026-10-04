const FormFactorConfig = @import("form_factor_config.zig").FormFactorConfig;

/// Information about an instance type that can be ordered for an Outpost,
/// including
/// hardware specifications and supported form factors.
pub const DetailedInstanceTypeItem = struct {
    /// The supported form factor and Outpost generation configurations for the
    /// instance
    /// type.
    form_factor_configs: ?[]const FormFactorConfig = null,

    /// The instance type.
    instance_type: ?[]const u8 = null,

    /// The memory size of the instance type, in MiB.
    memory_in_mib: i32 = 0,

    /// The network performance of the instance type.
    network_performance: ?[]const u8 = null,

    /// The number of default VCPUs in the instance type.
    vcp_us: ?i32 = null,

    pub const json_field_names = .{
        .form_factor_configs = "FormFactorConfigs",
        .instance_type = "InstanceType",
        .memory_in_mib = "MemoryInMib",
        .network_performance = "NetworkPerformance",
        .vcp_us = "VCPUs",
    };
};
