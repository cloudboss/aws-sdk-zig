const DeploymentLifecycleHookStage = @import("deployment_lifecycle_hook_stage.zig").DeploymentLifecycleHookStage;
const DeploymentLifecycleHookTargetType = @import("deployment_lifecycle_hook_target_type.zig").DeploymentLifecycleHookTargetType;
const DeploymentLifecycleHookTimeoutConfiguration = @import("deployment_lifecycle_hook_timeout_configuration.zig").DeploymentLifecycleHookTimeoutConfiguration;

/// A deployment lifecycle hook runs custom logic or pauses the deployment at
/// specific stages of the deployment process. You can use Lambda functions or
/// pause hooks as hook targets.
///
/// For more information, see [Lifecycle hooks for Amazon ECS service
/// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-lifecycle-hooks.html) in the * Amazon Elastic Container Service Developer Guide*.
pub const DeploymentLifecycleHook = struct {
    /// Use this field to specify custom parameters that Amazon ECS passes to your
    /// Lambda function on each invocation. This field is not used for `PAUSE`
    /// hooks.
    hook_details: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hook target. For `AWS_LAMBDA` hooks,
    /// this is the Lambda function ARN. This field is not applicable for `PAUSE`
    /// hooks.
    ///
    /// You must provide this parameter when configuring an `AWS_LAMBDA` lifecycle
    /// hook.
    hook_target_arn: ?[]const u8 = null,

    /// The lifecycle stages at which to run the hook. Choose from these valid
    /// values:
    ///
    /// * RECONCILE_SERVICE
    ///
    /// The reconciliation stage that only happens when you start a new service
    /// deployment with more than 1 service revision in an ACTIVE state.
    ///
    /// You can use a lifecycle hook for this stage.
    /// * PRE_SCALE_UP
    ///
    /// The green service revision has not started. The blue service revision is
    /// handling 100% of the production traffic. There is no test traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    /// * POST_SCALE_UP
    ///
    /// The green service revision has started. The blue service revision is
    /// handling 100% of the production traffic. There is no test traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    /// * TEST_TRAFFIC_SHIFT
    ///
    /// The blue and green service revisions are running. The blue service revision
    /// handles 100% of the production traffic. The green service revision is
    /// migrating from 0% to 100% of test traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    /// * POST_TEST_TRAFFIC_SHIFT
    ///
    /// The test traffic shift is complete. The green service revision handles 100%
    /// of the test traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    /// * PRE_PRODUCTION_TRAFFIC_SHIFT
    ///
    /// Occurs before production traffic shift. For linear and canary deployments,
    /// this stage is invoked before every traffic shift step.
    ///
    /// You can use a lifecycle hook for this stage.
    /// * PRODUCTION_TRAFFIC_SHIFT
    ///
    /// Production traffic is shifting to the green service revision. The green
    /// service revision is migrating from 0% to 100% of production traffic. For
    /// linear and canary deployments, this stage is invoked at every traffic shift
    /// step.
    ///
    /// You can use a lifecycle hook for this stage.
    /// * POST_PRODUCTION_TRAFFIC_SHIFT
    ///
    /// The production traffic shift is complete.
    ///
    /// You can use a lifecycle hook for this stage.
    ///
    /// `PAUSE` hooks cannot be configured at `TEST_TRAFFIC_SHIFT` or
    /// `PRODUCTION_TRAFFIC_SHIFT` stages. These stages are only valid for
    /// `AWS_LAMBDA` hooks.
    ///
    /// You must provide this parameter when configuring a deployment lifecycle
    /// hook.
    lifecycle_stages: ?[]const DeploymentLifecycleHookStage = null,

    /// The Amazon Resource Name (ARN) of the IAM role that grants Amazon ECS
    /// permission to call Lambda functions on your behalf.
    ///
    /// For more information, see [Permissions required for Lambda functions in
    /// Amazon ECS blue/green
    /// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/blue-green-permissions.html) in the * Amazon Elastic Container Service Developer Guide*.
    role_arn: ?[]const u8 = null,

    /// The type of action the lifecycle hook performs. Valid values are:
    ///
    /// * `AWS_LAMBDA` - Invokes a Lambda function at the specified lifecycle stage.
    ///   This is the default value.
    /// * `PAUSE` - Pauses the deployment at the specified lifecycle stage until you
    ///   call `ContinueServiceDeployment` to continue or roll back.
    ///
    /// This field is optional. If not specified, the default value is `AWS_LAMBDA`.
    target_type: ?DeploymentLifecycleHookTargetType = null,

    /// The timeout configuration for the lifecycle hook. This specifies how long
    /// Amazon ECS waits before taking the timeout action if the hook is not
    /// resolved.
    timeout_configuration: ?DeploymentLifecycleHookTimeoutConfiguration = null,

    pub const json_field_names = .{
        .hook_details = "hookDetails",
        .hook_target_arn = "hookTargetArn",
        .lifecycle_stages = "lifecycleStages",
        .role_arn = "roleArn",
        .target_type = "targetType",
        .timeout_configuration = "timeoutConfiguration",
    };
};
