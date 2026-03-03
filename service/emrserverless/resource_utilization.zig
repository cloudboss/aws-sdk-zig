/// The resource utilization for memory, storage, and vCPU for jobs.
pub const ResourceUtilization = struct {
    /// The aggregated memory used per hour from the time the job starts executing
    /// until the job is terminated.
    memory_gb_hour: ?f64 = null,

    /// The aggregated storage used per hour from the time the job starts executing
    /// until the job is terminated.
    storage_gb_hour: ?f64 = null,

    /// The aggregated vCPU used per hour from the time the job starts executing
    /// until the job is terminated.
    v_cpu_hour: ?f64 = null,

    pub const json_field_names = .{
        .memory_gb_hour = "memoryGBHour",
        .storage_gb_hour = "storageGBHour",
        .v_cpu_hour = "vCPUHour",
    };
};
