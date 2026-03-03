/// The options for how a device's CPU is configured.
pub const CpuOptions = struct {
    /// The number of cores that the CPU can use.
    core_count: ?i32 = null,

    /// The number of threads per core in the CPU.
    threads_per_core: ?i32 = null,

    pub const json_field_names = .{
        .core_count = "coreCount",
        .threads_per_core = "threadsPerCore",
    };
};
