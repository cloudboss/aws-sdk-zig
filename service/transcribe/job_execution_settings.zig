/// Makes it possible to control how your transcription job is processed.
/// Currently, the
/// only `JobExecutionSettings` modification you can choose is enabling job
/// queueing using the `AllowDeferredExecution` sub-parameter.
///
/// If you include `JobExecutionSettings` in your request, you must also
/// include the sub-parameters: `AllowDeferredExecution` and
/// `DataAccessRoleArn`.
pub const JobExecutionSettings = struct {
    /// Makes it possible to enable job queuing when your concurrent request limit
    /// is
    /// exceeded. When `AllowDeferredExecution` is set to `true`,
    /// transcription job requests are placed in a queue until the number of jobs
    /// falls below
    /// the concurrent request limit. If `AllowDeferredExecution` is set to
    /// `false` and the number of transcription job requests exceed the
    /// concurrent request limit, you get a `LimitExceededException` error.
    ///
    /// If you include `AllowDeferredExecution` in your request, you must also
    /// include `DataAccessRoleArn`.
    allow_deferred_execution: ?bool = null,

    /// The Amazon Resource Name (ARN) of an IAM role that has permissions to
    /// access the Amazon S3 bucket that contains your input files. If the role that
    /// you
    /// specify doesn’t have the appropriate permissions to access the specified
    /// Amazon S3
    /// location, your request fails.
    ///
    /// IAM role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`. For example:
    /// `arn:aws:iam::111122223333:role/Admin`. For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    ///
    /// Note that if you include `DataAccessRoleArn` in your request, you must also
    /// include `AllowDeferredExecution`.
    data_access_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .allow_deferred_execution = "AllowDeferredExecution",
        .data_access_role_arn = "DataAccessRoleArn",
    };
};
