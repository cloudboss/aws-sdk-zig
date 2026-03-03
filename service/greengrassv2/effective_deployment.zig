const EffectiveDeploymentExecutionStatus = @import("effective_deployment_execution_status.zig").EffectiveDeploymentExecutionStatus;
const EffectiveDeploymentStatusDetails = @import("effective_deployment_status_details.zig").EffectiveDeploymentStatusDetails;

/// Contains information about a deployment job that IoT Greengrass sends to a
/// Greengrass core device.
pub const EffectiveDeployment = struct {
    /// The status of the deployment job on the Greengrass core device.
    ///
    /// * `IN_PROGRESS` – The deployment job is running.
    ///
    /// * `QUEUED` – The deployment job is in the job queue and waiting to
    /// run.
    ///
    /// * `FAILED` – The deployment failed. For more information, see the
    /// `statusDetails` field.
    ///
    /// * `COMPLETED` – The deployment to an IoT thing was completed
    /// successfully.
    ///
    /// * `TIMED_OUT` – The deployment didn't complete in the allotted time.
    ///
    /// * `CANCELED` – The deployment was canceled by the user.
    ///
    /// * `REJECTED` – The deployment was rejected. For more information, see
    /// the `statusDetails` field.
    ///
    /// * `SUCCEEDED` – The deployment to an IoT thing group was completed
    /// successfully.
    core_device_execution_status: EffectiveDeploymentExecutionStatus,

    /// The time at which the deployment was created, expressed in ISO 8601 format.
    creation_timestamp: i64,

    /// The ID of the deployment.
    deployment_id: []const u8,

    /// The name of the deployment.
    deployment_name: []const u8,

    /// The description of the deployment job.
    description: ?[]const u8 = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the IoT job that applies the deployment to target devices.
    iot_job_arn: ?[]const u8 = null,

    /// The ID of the IoT job that applies the deployment to target devices.
    iot_job_id: ?[]const u8 = null,

    /// The time at which the deployment job was last modified, expressed in ISO
    /// 8601
    /// format.
    modified_timestamp: i64,

    /// The reason code for the update, if the job was updated.
    reason: ?[]const u8 = null,

    /// The status details that explain why a deployment has an error. This response
    /// will be null
    /// if the deployment is in a success state.
    status_details: ?EffectiveDeploymentStatusDetails = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the target IoT thing or thing group.
    target_arn: []const u8,

    pub const json_field_names = .{
        .core_device_execution_status = "coreDeviceExecutionStatus",
        .creation_timestamp = "creationTimestamp",
        .deployment_id = "deploymentId",
        .deployment_name = "deploymentName",
        .description = "description",
        .iot_job_arn = "iotJobArn",
        .iot_job_id = "iotJobId",
        .modified_timestamp = "modifiedTimestamp",
        .reason = "reason",
        .status_details = "statusDetails",
        .target_arn = "targetArn",
    };
};
