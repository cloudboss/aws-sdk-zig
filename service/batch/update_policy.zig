/// Specifies the infrastructure update policy for the Amazon EC2 compute
/// environment. For more information
/// about infrastructure updates, see [Updating compute
/// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the
/// *Batch User Guide*.
///
/// The `updatePolicy` property applies only to Amazon EC2 managed compute
/// environments.
/// Batch doesn't support `updatePolicy` for Fargate compute environments. If
/// you
/// specify it for a Fargate compute environment, Batch ignores it.
pub const UpdatePolicy = struct {
    /// Specifies the job timeout (in minutes) when the compute environment
    /// infrastructure is
    /// updated. The default value is 30. The maximum value is 7200.
    ///
    /// Increasing `jobExecutionTimeoutMinutes` during infrastructure updates delays
    /// the replacement of instances with new instances that include updates such as
    /// security patches,
    /// but provides more time for jobs to execute. Consider the security
    /// implications of this tradeoff
    /// when setting timeout values.
    job_execution_timeout_minutes: ?i64 = null,

    /// Specifies whether jobs are automatically terminated when the compute
    /// environment
    /// infrastructure is updated. The default value is `false`.
    terminate_jobs_on_update: ?bool = null,

    pub const json_field_names = .{
        .job_execution_timeout_minutes = "jobExecutionTimeoutMinutes",
        .terminate_jobs_on_update = "terminateJobsOnUpdate",
    };
};
