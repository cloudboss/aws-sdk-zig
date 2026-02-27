/// Metrics for the optimizer run.
///
/// This structure is deprecated. See the individual metric members for
/// compaction, retention, and orphan file deletion.
pub const RunMetrics = struct {
    /// The duration of the job in hours.
    job_duration_in_hour: ?[]const u8,

    /// The number of bytes removed by the compaction job run.
    number_of_bytes_compacted: ?[]const u8,

    /// The number of DPUs consumed by the job, rounded up to the nearest whole
    /// number.
    number_of_dpus: ?[]const u8,

    /// The number of files removed by the compaction job run.
    number_of_files_compacted: ?[]const u8,

    pub const json_field_names = .{
        .job_duration_in_hour = "JobDurationInHour",
        .number_of_bytes_compacted = "NumberOfBytesCompacted",
        .number_of_dpus = "NumberOfDpus",
        .number_of_files_compacted = "NumberOfFilesCompacted",
    };
};
