const DeploymentLifecycleHookStage = @import("deployment_lifecycle_hook_stage.zig").DeploymentLifecycleHookStage;

/// A deployment lifecycle hook runs custom logic at specific stages of the
/// deployment process. Currently, you can use Lambda functions as hook targets.
///
/// For more information, see [Lifecycle hooks for Amazon ECS service
/// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-lifecycle-hooks.html) in the *
/// Amazon Elastic Container Service Developer Guide*.
pub const DeploymentLifecycleHook = struct {
    /// Use this field to specify custom parameters that Amazon ECS will pass to
    /// your hook target invocations (such as a Lambda function).
    hook_details: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hook target. Currently, only Lambda
    /// function ARNs are supported.
    ///
    /// You must provide this parameter when configuring a deployment lifecycle
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
    ///
    /// * PRE_SCALE_UP
    ///
    /// The green service revision has not started. The blue service revision is
    /// handling 100% of the production traffic. There is no test traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    ///
    /// * POST_SCALE_UP
    ///
    /// The green service revision has started. The blue service revision is
    /// handling 100% of the production traffic. There is no test traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    ///
    /// * TEST_TRAFFIC_SHIFT
    ///
    /// The blue and green service revisions are running. The blue service revision
    /// handles 100% of the production traffic. The green service revision is
    /// migrating from 0% to 100% of test traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    ///
    /// * POST_TEST_TRAFFIC_SHIFT
    ///
    /// The test traffic shift is complete. The green service revision handles 100%
    /// of the test traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    ///
    /// * PRODUCTION_TRAFFIC_SHIFT
    ///
    /// Production traffic is shifting to the green service revision. The green
    /// service revision is migrating from 0% to 100% of production traffic.
    ///
    /// You can use a lifecycle hook for this stage.
    ///
    /// * POST_PRODUCTION_TRAFFIC_SHIFT
    ///
    /// The production traffic shift is complete.
    ///
    /// You can use a lifecycle hook for this stage.
    ///
    /// You must provide this parameter when configuring a deployment lifecycle
    /// hook.
    lifecycle_stages: ?[]const DeploymentLifecycleHookStage = null,

    /// The Amazon Resource Name (ARN) of the IAM role that grants Amazon ECS
    /// permission to call Lambda functions on your behalf.
    ///
    /// For more information, see [Permissions required
    /// for Lambda functions in Amazon ECS blue/green
    /// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/blue-green-permissions.html) in the *
    /// Amazon Elastic Container Service Developer Guide*.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .hook_details = "hookDetails",
        .hook_target_arn = "hookTargetArn",
        .lifecycle_stages = "lifecycleStages",
        .role_arn = "roleArn",
    };
};
