/// Describes the vCPU configurations for the instance type.
pub const VCpuInfo = struct {
    /// The default number of cores for the instance type.
    default_cores: ?i32 = null,

    /// The default number of threads per core for the instance type.
    default_threads_per_core: ?i32 = null,

    /// The default number of vCPUs for the instance type.
    default_v_cpus: ?i32 = null,

    /// The valid number of cores that can be configured for the instance type.
    valid_cores: ?[]const i32 = null,

    /// The valid number of threads per core that can be configured for the instance
    /// type.
    valid_threads_per_core: ?[]const i32 = null,
};
