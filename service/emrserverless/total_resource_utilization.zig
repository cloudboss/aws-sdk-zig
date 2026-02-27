/// The aggregate vCPU, memory, and storage resources used from the time job
/// start executing till the time job is terminated, rounded up to the nearest
/// second.
pub const TotalResourceUtilization = struct {
    /// The aggregated memory used per hour from the time job start executing till
    /// the time job is terminated.
    memory_gb_hour: ?f64,

    /// The aggregated storage used per hour from the time job start executing till
    /// the time job is terminated.
    storage_gb_hour: ?f64,

    /// The aggregated vCPU used per hour from the time job start executing till the
    /// time job is terminated.
    v_cpu_hour: ?f64,

    pub const json_field_names = .{
        .memory_gb_hour = "memoryGBHour",
        .storage_gb_hour = "storageGBHour",
        .v_cpu_hour = "vCPUHour",
    };
};
