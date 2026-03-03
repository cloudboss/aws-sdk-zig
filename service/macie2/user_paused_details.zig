/// Provides information about when a classification job was paused. For a
/// one-time job, this object also specifies when the job will expire and be
/// cancelled if it isn't resumed. For a recurring job, this object also
/// specifies when the paused job run will expire and be cancelled if it isn't
/// resumed. This object is present only if a job's current status (jobStatus)
/// is USER_PAUSED. The information in this object applies only to a job that
/// was paused while it had a status of RUNNING.
pub const UserPausedDetails = struct {
    /// The date and time, in UTC and extended ISO 8601 format, when the job or job
    /// run will expire and be cancelled if you don't resume it first.
    job_expires_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Health event that Amazon Macie sent to
    /// notify you of the job or job run's pending expiration and cancellation. This
    /// value is null if a job has been paused for less than 23 days.
    job_imminent_expiration_health_event_arn: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when you paused the
    /// job.
    job_paused_at: ?i64 = null,

    pub const json_field_names = .{
        .job_expires_at = "jobExpiresAt",
        .job_imminent_expiration_health_event_arn = "jobImminentExpirationHealthEventArn",
        .job_paused_at = "jobPausedAt",
    };
};
