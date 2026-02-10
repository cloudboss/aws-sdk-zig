const EventBridgeConfiguration = @import("event_bridge_configuration.zig").EventBridgeConfiguration;
const LambdaFunctionConfiguration = @import("lambda_function_configuration.zig").LambdaFunctionConfiguration;
const QueueConfiguration = @import("queue_configuration.zig").QueueConfiguration;
const TopicConfiguration = @import("topic_configuration.zig").TopicConfiguration;

/// A container for specifying the notification configuration of the bucket. If
/// this element is empty,
/// notifications are turned off for the bucket.
pub const NotificationConfiguration = struct {
    /// Enables delivery of events to Amazon EventBridge.
    event_bridge_configuration: ?EventBridgeConfiguration,

    /// Describes the Lambda functions to invoke and the events for which to invoke
    /// them.
    lambda_function_configurations: ?[]const LambdaFunctionConfiguration,

    /// The Amazon Simple Queue Service queues to publish messages to and the events
    /// for which to publish
    /// messages.
    queue_configurations: ?[]const QueueConfiguration,

    /// The topic to which notifications are sent and the events for which
    /// notifications are
    /// generated.
    topic_configurations: ?[]const TopicConfiguration,
};
