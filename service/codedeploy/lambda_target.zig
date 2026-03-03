const LambdaFunctionInfo = @import("lambda_function_info.zig").LambdaFunctionInfo;
const LifecycleEvent = @import("lifecycle_event.zig").LifecycleEvent;
const TargetStatus = @import("target_status.zig").TargetStatus;

/// Information about the target Lambda function during an Lambda deployment.
pub const LambdaTarget = struct {
    /// The unique ID of a deployment.
    deployment_id: ?[]const u8 = null,

    /// A `LambdaFunctionInfo` object that describes a target Lambda
    /// function.
    lambda_function_info: ?LambdaFunctionInfo = null,

    /// The date and time when the target Lambda function was updated by a
    /// deployment.
    last_updated_at: ?i64 = null,

    /// The lifecycle events of the deployment to this target Lambda function.
    lifecycle_events: ?[]const LifecycleEvent = null,

    /// The status an Lambda deployment's target Lambda function.
    status: ?TargetStatus = null,

    /// The Amazon Resource Name (ARN) of the target.
    target_arn: ?[]const u8 = null,

    /// The unique ID of a deployment target that has a type of `lambdaTarget`.
    target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .lambda_function_info = "lambdaFunctionInfo",
        .last_updated_at = "lastUpdatedAt",
        .lifecycle_events = "lifecycleEvents",
        .status = "status",
        .target_arn = "targetArn",
        .target_id = "targetId",
    };
};
