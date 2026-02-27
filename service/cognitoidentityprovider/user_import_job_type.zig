const UserImportJobStatusType = @import("user_import_job_status_type.zig").UserImportJobStatusType;

/// A user import job in a user pool. Describes the status of user import with a
/// CSV file.
/// For more information, see [Importing users into user pools from a CSV
/// file](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-using-import-tool.html).
pub const UserImportJobType = struct {
    /// The role Amazon Resource Name (ARN) for the Amazon CloudWatch Logging role
    /// for the user import
    /// job. For more information, see "Creating the CloudWatch Logs IAM Role" in
    /// the Amazon Cognito Developer
    /// Guide.
    cloud_watch_logs_role_arn: ?[]const u8,

    /// The date when the user import job was completed.
    completion_date: ?i64,

    /// The message returned when the user import job is completed.
    completion_message: ?[]const u8,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64,

    /// The number of users that couldn't be imported.
    failed_users: i64 = 0,

    /// The number of users that were successfully imported.
    imported_users: i64 = 0,

    /// The ID of the user import job.
    job_id: ?[]const u8,

    /// The friendly name of the user import job.
    job_name: ?[]const u8,

    /// The pre-signed URL target for uploading the CSV file.
    pre_signed_url: ?[]const u8,

    /// The number of users that were skipped.
    skipped_users: i64 = 0,

    /// The date when the user import job was started.
    start_date: ?i64,

    /// The status of the user import job. One of the following:
    ///
    /// * `Created` - The job was created but not started.
    ///
    /// * `Pending` - A transition state. You have started the job, but it
    /// has not begun importing users yet.
    ///
    /// * `InProgress` - The job has started, and users are being
    /// imported.
    ///
    /// * `Stopping` - You have stopped the job, but the job has not stopped
    /// importing users yet.
    ///
    /// * `Stopped` - You have stopped the job, and the job has stopped
    /// importing users.
    ///
    /// * `Succeeded` - The job has completed successfully.
    ///
    /// * `Failed` - The job has stopped due to an error.
    ///
    /// * `Expired` - You created a job, but did not start the job within
    /// 24-48 hours. All data associated with the job was deleted, and the job can't
    /// be
    /// started.
    status: ?UserImportJobStatusType,

    /// The ID of the user pool that the users are being imported into.
    user_pool_id: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_logs_role_arn = "CloudWatchLogsRoleArn",
        .completion_date = "CompletionDate",
        .completion_message = "CompletionMessage",
        .creation_date = "CreationDate",
        .failed_users = "FailedUsers",
        .imported_users = "ImportedUsers",
        .job_id = "JobId",
        .job_name = "JobName",
        .pre_signed_url = "PreSignedUrl",
        .skipped_users = "SkippedUsers",
        .start_date = "StartDate",
        .status = "Status",
        .user_pool_id = "UserPoolId",
    };
};
