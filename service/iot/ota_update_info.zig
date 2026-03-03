const aws = @import("aws");

const AwsJobExecutionsRolloutConfig = @import("aws_job_executions_rollout_config.zig").AwsJobExecutionsRolloutConfig;
const AwsJobPresignedUrlConfig = @import("aws_job_presigned_url_config.zig").AwsJobPresignedUrlConfig;
const ErrorInfo = @import("error_info.zig").ErrorInfo;
const OTAUpdateFile = @import("ota_update_file.zig").OTAUpdateFile;
const OTAUpdateStatus = @import("ota_update_status.zig").OTAUpdateStatus;
const Protocol = @import("protocol.zig").Protocol;
const TargetSelection = @import("target_selection.zig").TargetSelection;

/// Information about an OTA update.
pub const OTAUpdateInfo = struct {
    /// A collection of name/value pairs
    additional_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The IoT job ARN associated with the OTA update.
    aws_iot_job_arn: ?[]const u8 = null,

    /// The IoT job ID associated with the OTA update.
    aws_iot_job_id: ?[]const u8 = null,

    /// Configuration for the rollout of OTA updates.
    aws_job_executions_rollout_config: ?AwsJobExecutionsRolloutConfig = null,

    /// Configuration information for pre-signed URLs. Valid when `protocols`
    /// contains HTTP.
    aws_job_presigned_url_config: ?AwsJobPresignedUrlConfig = null,

    /// The date when the OTA update was created.
    creation_date: ?i64 = null,

    /// A description of the OTA update.
    description: ?[]const u8 = null,

    /// Error information associated with the OTA update.
    error_info: ?ErrorInfo = null,

    /// The date when the OTA update was last updated.
    last_modified_date: ?i64 = null,

    /// The OTA update ARN.
    ota_update_arn: ?[]const u8 = null,

    /// A list of files associated with the OTA update.
    ota_update_files: ?[]const OTAUpdateFile = null,

    /// The OTA update ID.
    ota_update_id: ?[]const u8 = null,

    /// The status of the OTA update.
    ota_update_status: ?OTAUpdateStatus = null,

    /// The protocol used to transfer the OTA update image. Valid values are [HTTP],
    /// [MQTT], [HTTP, MQTT]. When both
    /// HTTP and MQTT are specified, the target device can choose the protocol.
    protocols: ?[]const Protocol = null,

    /// The targets of the OTA update.
    targets: ?[]const []const u8 = null,

    /// Specifies whether the OTA update will continue to run (CONTINUOUS), or will
    /// be complete after all those
    /// things specified as targets have completed the OTA update (SNAPSHOT). If
    /// continuous, the OTA update may also
    /// be run on a thing when a change is detected in a target. For example, an OTA
    /// update will run on a thing when
    /// the thing is added to a target group, even after the OTA update was
    /// completed by all things originally in
    /// the group.
    target_selection: ?TargetSelection = null,

    pub const json_field_names = .{
        .additional_parameters = "additionalParameters",
        .aws_iot_job_arn = "awsIotJobArn",
        .aws_iot_job_id = "awsIotJobId",
        .aws_job_executions_rollout_config = "awsJobExecutionsRolloutConfig",
        .aws_job_presigned_url_config = "awsJobPresignedUrlConfig",
        .creation_date = "creationDate",
        .description = "description",
        .error_info = "errorInfo",
        .last_modified_date = "lastModifiedDate",
        .ota_update_arn = "otaUpdateArn",
        .ota_update_files = "otaUpdateFiles",
        .ota_update_id = "otaUpdateId",
        .ota_update_status = "otaUpdateStatus",
        .protocols = "protocols",
        .targets = "targets",
        .target_selection = "targetSelection",
    };
};
