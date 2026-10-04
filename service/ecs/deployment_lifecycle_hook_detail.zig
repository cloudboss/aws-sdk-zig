const DeploymentLifecycleHookStatus = @import("deployment_lifecycle_hook_status.zig").DeploymentLifecycleHookStatus;
const DeploymentLifecycleHookTargetType = @import("deployment_lifecycle_hook_target_type.zig").DeploymentLifecycleHookTargetType;
const DeploymentLifecycleHookAction = @import("deployment_lifecycle_hook_action.zig").DeploymentLifecycleHookAction;

/// The details of a deployment lifecycle hook that is active during a service
/// deployment.
///
/// You can view lifecycle hook details by calling
/// [DescribeServiceDeployments](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeServiceDeployments.html).
pub const DeploymentLifecycleHookDetail = struct {
    /// The time when the lifecycle hook times out. If the hook has not been
    /// completed by this time, Amazon ECS takes the timeout action.
    expires_at: ?i64 = null,

    /// The ID of the lifecycle hook. Use this value when calling
    /// `ContinueServiceDeployment` to continue or roll back a paused deployment.
    hook_id: ?[]const u8 = null,

    /// The status of the lifecycle hook. Valid values include `AWAITING_ACTION`,
    /// `IN_PROGRESS`, `SUCCEEDED`, `FAILED`, and `TIMED_OUT`.
    status: ?DeploymentLifecycleHookStatus = null,

    /// The Amazon Resource Name (ARN) of the hook target. For `AWS_LAMBDA` hooks,
    /// this is the Lambda function ARN. For `PAUSE` hooks, this field is not set.
    target_arn: ?[]const u8 = null,

    /// The type of action the lifecycle hook performs, such as `AWS_LAMBDA` or
    /// `PAUSE`.
    target_type: ?DeploymentLifecycleHookTargetType = null,

    /// The action Amazon ECS takes when the lifecycle hook times out. Valid values
    /// are `CONTINUE` and `ROLLBACK`.
    timeout_action: ?DeploymentLifecycleHookAction = null,

    pub const json_field_names = .{
        .expires_at = "expiresAt",
        .hook_id = "hookId",
        .status = "status",
        .target_arn = "targetArn",
        .target_type = "targetType",
        .timeout_action = "timeoutAction",
    };
};
