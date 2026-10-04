const HarnessHookEventBridgeTarget = @import("harness_hook_event_bridge_target.zig").HarnessHookEventBridgeTarget;
const HarnessHookLambdaTarget = @import("harness_hook_lambda_target.zig").HarnessHookLambdaTarget;
const HarnessHookSnsTarget = @import("harness_hook_sns_target.zig").HarnessHookSnsTarget;

/// The target that receives lifecycle hook events. Specify one target type.
pub const HarnessHookTarget = union(enum) {
    /// An Amazon EventBridge hook target that sends the hook event without waiting
    /// for a response.
    event_bridge: ?HarnessHookEventBridgeTarget,
    /// A Lambda hook target that invokes an AWS Lambda function synchronously and
    /// waits for its response.
    lambda: ?HarnessHookLambdaTarget,
    /// An Amazon SNS hook target that publishes the hook event without waiting for
    /// a response.
    sns: ?HarnessHookSnsTarget,

    pub const json_field_names = .{
        .event_bridge = "eventBridge",
        .lambda = "lambda",
        .sns = "sns",
    };
};
