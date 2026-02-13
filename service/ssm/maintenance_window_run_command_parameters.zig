const aws = @import("aws");

const CloudWatchOutputConfig = @import("cloud_watch_output_config.zig").CloudWatchOutputConfig;
const DocumentHashType = @import("document_hash_type.zig").DocumentHashType;
const NotificationConfig = @import("notification_config.zig").NotificationConfig;

/// The parameters for a `RUN_COMMAND` task type.
///
/// For information about specifying and updating task parameters, see
/// RegisterTaskWithMaintenanceWindow and UpdateMaintenanceWindowTask.
///
/// **Note:**
///
/// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
/// Service (Amazon S3) bucket to contain logs, instead use the
/// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
/// `TaskInvocationParameters` structure.
/// For information about how Amazon Web Services Systems Manager handles these
/// options for the supported maintenance
/// window task types, see MaintenanceWindowTaskInvocationParameters.
///
/// `TaskParameters` has been deprecated. To specify parameters to pass to a
/// task when it runs,
/// instead use the `Parameters` option in the `TaskInvocationParameters`
/// structure. For information
/// about how Systems Manager handles these options for the supported
/// maintenance window task
/// types, see MaintenanceWindowTaskInvocationParameters.
///
/// For `RUN_COMMAND` tasks, Systems Manager uses specified values for
/// `TaskParameters` and `LoggingInfo` only if no values are specified for
/// `TaskInvocationParameters`.
pub const MaintenanceWindowRunCommandParameters = struct {
    cloud_watch_output_config: ?CloudWatchOutputConfig,

    /// Information about the commands to run.
    comment: ?[]const u8,

    /// The SHA-256 or SHA-1 hash created by the system when the document was
    /// created. SHA-1 hashes
    /// have been deprecated.
    document_hash: ?[]const u8,

    /// SHA-256 or SHA-1. SHA-1 hashes have been deprecated.
    document_hash_type: ?DocumentHashType,

    /// The Amazon Web Services Systems Manager document (SSM document) version to
    /// use in the request. You can specify
    /// `$DEFAULT`, `$LATEST`, or a specific version number. If you run commands
    /// by using the Amazon Web Services CLI, then you must escape the first two
    /// options by using a backslash. If you
    /// specify a version number, then you don't need to use the backslash. For
    /// example:
    ///
    /// `--document-version "\$DEFAULT"`
    ///
    /// `--document-version "\$LATEST"`
    ///
    /// `--document-version "3"`
    document_version: ?[]const u8,

    /// Configurations for sending notifications about command status changes on a
    /// per-managed node
    /// basis.
    notification_config: ?NotificationConfig,

    /// The name of the Amazon Simple Storage Service (Amazon S3) bucket.
    output_s_3_bucket_name: ?[]const u8,

    /// The S3 bucket subfolder.
    output_s_3_key_prefix: ?[]const u8,

    /// The parameters for the `RUN_COMMAND` task execution.
    parameters: ?[]const aws.map.MapEntry([]const []const u8),

    /// The Amazon Resource Name (ARN) of the IAM service role for
    /// Amazon Web Services Systems Manager to assume when running a maintenance
    /// window task. If you do not specify a
    /// service role ARN, Systems Manager uses a service-linked role in your
    /// account. If no
    /// appropriate service-linked role for Systems Manager exists in your account,
    /// it is created when
    /// you run `RegisterTaskWithMaintenanceWindow`.
    ///
    /// However, for an improved security posture, we strongly recommend creating a
    /// custom
    /// policy and custom service role for running your maintenance window tasks.
    /// The policy
    /// can be crafted to provide only the permissions needed for your particular
    /// maintenance window tasks. For more information, see [Setting up Maintenance
    /// Windows](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-permissions.html) in the in the
    /// *Amazon Web Services Systems Manager User Guide*.
    service_role_arn: ?[]const u8,

    /// If this time is reached and the command hasn't already started running, it
    /// doesn't
    /// run.
    timeout_seconds: ?i32,

    pub const json_field_names = .{
        .cloud_watch_output_config = "CloudWatchOutputConfig",
        .comment = "Comment",
        .document_hash = "DocumentHash",
        .document_hash_type = "DocumentHashType",
        .document_version = "DocumentVersion",
        .notification_config = "NotificationConfig",
        .output_s_3_bucket_name = "OutputS3BucketName",
        .output_s_3_key_prefix = "OutputS3KeyPrefix",
        .parameters = "Parameters",
        .service_role_arn = "ServiceRoleArn",
        .timeout_seconds = "TimeoutSeconds",
    };
};
