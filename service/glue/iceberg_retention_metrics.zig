/// Snapshot retention metrics for Iceberg for the optimizer run.
pub const IcebergRetentionMetrics = struct {
    /// The number of DPU hours consumed by the job.
    dpu_hours: f64 = 0,

    /// The duration of the job in hours.
    job_duration_in_hour: f64 = 0,

    /// The number of data files deleted by the retention job run.
    number_of_data_files_deleted: i64 = 0,

    /// The number of DPUs consumed by the job, rounded up to the nearest whole
    /// number.
    number_of_dpus: i32 = 0,

    /// The number of manifest files deleted by the retention job run.
    number_of_manifest_files_deleted: i64 = 0,

    /// The number of manifest lists deleted by the retention job run.
    number_of_manifest_lists_deleted: i64 = 0,

    pub const json_field_names = .{
        .dpu_hours = "DpuHours",
        .job_duration_in_hour = "JobDurationInHour",
        .number_of_data_files_deleted = "NumberOfDataFilesDeleted",
        .number_of_dpus = "NumberOfDpus",
        .number_of_manifest_files_deleted = "NumberOfManifestFilesDeleted",
        .number_of_manifest_lists_deleted = "NumberOfManifestListsDeleted",
    };
};
