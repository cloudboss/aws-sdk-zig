const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const EcsParameters = @import("ecs_parameters.zig").EcsParameters;
const EventBridgeParameters = @import("event_bridge_parameters.zig").EventBridgeParameters;
const KinesisParameters = @import("kinesis_parameters.zig").KinesisParameters;
const RetryPolicy = @import("retry_policy.zig").RetryPolicy;
const SageMakerPipelineParameters = @import("sage_maker_pipeline_parameters.zig").SageMakerPipelineParameters;
const SqsParameters = @import("sqs_parameters.zig").SqsParameters;

/// The schedule's target. EventBridge Scheduler supports templated target that
/// invoke common API operations, as well as universal targets that you can
/// customize to
/// invoke over 6,000 API operations across more than 270 services. You can only
/// specify one templated or universal target for a schedule.
pub const Target = struct {
    /// The Amazon Resource Name (ARN) of the target.
    arn: []const u8,

    /// An object that contains information about an Amazon SQS queue that
    /// EventBridge Scheduler uses as a dead-letter queue for your schedule. If
    /// specified, EventBridge Scheduler delivers failed events that could not be
    /// successfully delivered to a target to the queue.
    dead_letter_config: ?DeadLetterConfig = null,

    /// The templated target type for the Amazon ECS [
    /// `RunTask`
    /// ](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_RunTask.html) API operation.
    ecs_parameters: ?EcsParameters = null,

    /// The templated target type for the EventBridge [
    /// `PutEvents`
    /// ](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutEvents.html) API operation.
    event_bridge_parameters: ?EventBridgeParameters = null,

    /// The text, or well-formed JSON, passed to the target. If you are configuring
    /// a templated Lambda, AWS Step Functions, or Amazon EventBridge target,
    /// the input must be a well-formed JSON. For all other target types, a JSON is
    /// not required. If you do not specify anything for this field, EventBridge
    /// Scheduler
    /// delivers a default notification to the target.
    input: ?[]const u8 = null,

    /// The templated target type for the Amazon Kinesis [
    /// `PutRecord`
    /// ](kinesis/latest/APIReference/API_PutRecord.html) API operation.
    kinesis_parameters: ?KinesisParameters = null,

    /// A `RetryPolicy` object that includes information about the retry policy
    /// settings, including the maximum age of an event, and the maximum number of
    /// times EventBridge Scheduler will try to deliver the event to a target.
    retry_policy: ?RetryPolicy = null,

    /// The Amazon Resource Name (ARN) of the IAM role that EventBridge Scheduler
    /// will use for this target when the schedule is invoked.
    role_arn: []const u8,

    /// The templated target type for the Amazon SageMaker [
    /// `StartPipelineExecution`
    /// ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_StartPipelineExecution.html) API operation.
    sage_maker_pipeline_parameters: ?SageMakerPipelineParameters = null,

    /// The templated target type for the Amazon SQS [
    /// `SendMessage`
    /// ](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SendMessage.html) API operation.
    /// Contains the message group ID to use when the target is a FIFO queue. If you
    /// specify an Amazon SQS FIFO queue as a target, the queue must have
    /// content-based deduplication enabled.
    /// For more information, see [Using the Amazon SQS message deduplication
    /// ID](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-messagededuplicationid-property.html) in the
    /// *Amazon SQS Developer Guide*.
    sqs_parameters: ?SqsParameters = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .dead_letter_config = "DeadLetterConfig",
        .ecs_parameters = "EcsParameters",
        .event_bridge_parameters = "EventBridgeParameters",
        .input = "Input",
        .kinesis_parameters = "KinesisParameters",
        .retry_policy = "RetryPolicy",
        .role_arn = "RoleArn",
        .sage_maker_pipeline_parameters = "SageMakerPipelineParameters",
        .sqs_parameters = "SqsParameters",
    };
};
