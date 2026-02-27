/// Compaction metrics for Iceberg for the optimizer run.
pub const IcebergCompactionMetrics = struct {
    /// The number of DPU hours consumed by the job.
    dpu_hours: f64 = 0,

    /// The duration of the job in hours.
    job_duration_in_hour: f64 = 0,

    /// The number of bytes removed by the compaction job run.
    number_of_bytes_compacted: i64 = 0,

    /// The number of DPUs consumed by the job, rounded up to the nearest whole
    /// number.
    number_of_dpus: i32 = 0,

    /// The number of files removed by the compaction job run.
    number_of_files_compacted: i64 = 0,

    pub const json_field_names = .{
        .dpu_hours = "DpuHours",
        .job_duration_in_hour = "JobDurationInHour",
        .number_of_bytes_compacted = "NumberOfBytesCompacted",
        .number_of_dpus = "NumberOfDpus",
        .number_of_files_compacted = "NumberOfFilesCompacted",
    };
};
