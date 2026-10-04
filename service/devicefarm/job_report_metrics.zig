/// Contains aggregated metrics across all jobs in a run.
pub const JobReportMetrics = struct {
    /// The average execution duration of jobs in the run, in seconds.
    average_job_execution_duration_seconds: ?f64 = null,

    /// The number of jobs that errored.
    jobs_errored: ?i32 = null,

    /// The number of jobs that failed.
    jobs_failed: ?i32 = null,

    /// The number of jobs that passed.
    jobs_passed: ?i32 = null,

    /// The percentage of jobs that passed.
    jobs_passed_percentage: ?f64 = null,

    /// The number of jobs that were skipped.
    jobs_skipped: ?i32 = null,

    /// The number of jobs that were stopped.
    jobs_stopped: ?i32 = null,

    /// The total number of jobs in the run.
    jobs_total: ?i32 = null,

    /// The median execution duration of jobs in the run, in seconds.
    median_job_execution_duration_seconds: ?f64 = null,

    /// The total execution duration of all jobs in the run, in seconds.
    total_job_execution_duration_seconds: ?f64 = null,

    pub const json_field_names = .{
        .average_job_execution_duration_seconds = "averageJobExecutionDurationSeconds",
        .jobs_errored = "jobsErrored",
        .jobs_failed = "jobsFailed",
        .jobs_passed = "jobsPassed",
        .jobs_passed_percentage = "jobsPassedPercentage",
        .jobs_skipped = "jobsSkipped",
        .jobs_stopped = "jobsStopped",
        .jobs_total = "jobsTotal",
        .median_job_execution_duration_seconds = "medianJobExecutionDurationSeconds",
        .total_job_execution_duration_seconds = "totalJobExecutionDurationSeconds",
    };
};
