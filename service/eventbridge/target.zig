const AppSyncParameters = @import("app_sync_parameters.zig").AppSyncParameters;
const BatchParameters = @import("batch_parameters.zig").BatchParameters;
const DeadLetterConfig = @import("dead_letter_config.zig").DeadLetterConfig;
const EcsParameters = @import("ecs_parameters.zig").EcsParameters;
const HttpParameters = @import("http_parameters.zig").HttpParameters;
const InputTransformer = @import("input_transformer.zig").InputTransformer;
const KinesisParameters = @import("kinesis_parameters.zig").KinesisParameters;
const RedshiftDataParameters = @import("redshift_data_parameters.zig").RedshiftDataParameters;
const RetryPolicy = @import("retry_policy.zig").RetryPolicy;
const RunCommandParameters = @import("run_command_parameters.zig").RunCommandParameters;
const SageMakerPipelineParameters = @import("sage_maker_pipeline_parameters.zig").SageMakerPipelineParameters;
const SqsParameters = @import("sqs_parameters.zig").SqsParameters;

/// Targets are the resources to be invoked when a rule is triggered. For a
/// complete list of
/// services and resources that can be set as a target, see
/// [PutTargets](https://docs.aws.amazon.com/eventbridge/latest/APIReference/API_PutTargets.html).
///
/// If you are setting the event bus of another account as the target, and that
/// account
/// granted permission to your account through an organization instead of
/// directly by the account
/// ID, then you must specify a `RoleArn` with proper permissions in the
/// `Target` structure. For more information, see [Sending and
/// Receiving Events Between Amazon Web Services
/// Accounts](https://docs.aws.amazon.com/eventbridge/latest/userguide/eventbridge-cross-account-event-delivery.html) in the *Amazon EventBridge User Guide*.
pub const Target = struct {
    /// Contains the GraphQL operation to be parsed and executed, if the event
    /// target is an
    /// AppSync API.
    app_sync_parameters: ?AppSyncParameters,

    /// The Amazon Resource Name (ARN) of the target.
    arn: []const u8,

    /// If the event target is an Batch job, this contains the job definition, job
    /// name, and other parameters. For more information, see
    /// [Jobs](https://docs.aws.amazon.com/batch/latest/userguide/jobs.html) in the
    /// *Batch
    /// User Guide*.
    batch_parameters: ?BatchParameters,

    /// The `DeadLetterConfig` that defines the target queue to send dead-letter
    /// queue
    /// events to.
    dead_letter_config: ?DeadLetterConfig,

    /// Contains the Amazon ECS task definition and task count to be used, if the
    /// event target is
    /// an Amazon ECS task. For more information about Amazon ECS tasks, see [Task
    /// Definitions
    /// ](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_defintions.html) in the *Amazon EC2 Container Service Developer
    /// Guide*.
    ecs_parameters: ?EcsParameters,

    /// Contains the HTTP parameters to use when the target is a API Gateway
    /// endpoint or
    /// EventBridge ApiDestination.
    ///
    /// If you specify an API Gateway API or EventBridge ApiDestination as a target,
    /// you can use this parameter to specify headers, path parameters, and query
    /// string keys/values
    /// as part of your target invoking request. If you're using ApiDestinations,
    /// the corresponding
    /// Connection can also have these values configured. In case of any conflicting
    /// keys, values from
    /// the Connection take precedence.
    http_parameters: ?HttpParameters,

    /// The ID of the target within the specified rule. Use this ID to reference the
    /// target when
    /// updating the rule. We recommend using a memorable and unique string.
    id: []const u8,

    /// Valid JSON text passed to the target. In this case, nothing from the event
    /// itself is
    /// passed to the target. For more information, see [The JavaScript Object
    /// Notation (JSON) Data
    /// Interchange Format](http://www.rfc-editor.org/rfc/rfc7159.txt).
    input: ?[]const u8,

    /// The value of the JSONPath that is used for extracting part of the matched
    /// event when
    /// passing it to the target. You may use JSON dot notation or bracket notation.
    /// For more
    /// information about JSON paths, see
    /// [JSONPath](http://goessner.net/articles/JsonPath/).
    input_path: ?[]const u8,

    /// Settings to enable you to provide custom input to a target based on certain
    /// event data.
    /// You can extract one or more key-value pairs from the event and then use that
    /// data to send
    /// customized input to the target.
    input_transformer: ?InputTransformer,

    /// The custom parameter you can use to control the shard assignment, when the
    /// target is a
    /// Kinesis data stream. If you do not include this parameter, the default is to
    /// use the
    /// `eventId` as the partition key.
    kinesis_parameters: ?KinesisParameters,

    /// Contains the Amazon Redshift Data API parameters to use when the target is a
    /// Amazon Redshift cluster.
    ///
    /// If you specify a Amazon Redshift Cluster as a Target, you can use this to
    /// specify
    /// parameters to invoke the Amazon Redshift Data API ExecuteStatement based on
    /// EventBridge events.
    redshift_data_parameters: ?RedshiftDataParameters,

    /// The retry policy configuration to use
    /// for the dead-letter queue.
    retry_policy: ?RetryPolicy,

    /// The Amazon Resource Name (ARN) of the IAM role to be used for this target
    /// when the rule is triggered. If
    /// one rule triggers multiple targets, you can use a different IAM role for
    /// each target.
    role_arn: ?[]const u8,

    /// Parameters used when you are using the rule to invoke Amazon EC2 Run
    /// Command.
    run_command_parameters: ?RunCommandParameters,

    /// Contains the SageMaker AI Model Building Pipeline parameters to start
    /// execution of a
    /// SageMaker AI Model Building Pipeline.
    ///
    /// If you specify a SageMaker AI Model Building Pipeline as a target, you can
    /// use this
    /// to specify parameters to start a pipeline execution based on EventBridge
    /// events.
    sage_maker_pipeline_parameters: ?SageMakerPipelineParameters,

    /// Contains the message group ID to use when the target is a FIFO queue.
    ///
    /// If you specify an SQS FIFO queue as a target, the queue must have
    /// content-based
    /// deduplication enabled.
    sqs_parameters: ?SqsParameters,

    pub const json_field_names = .{
        .app_sync_parameters = "AppSyncParameters",
        .arn = "Arn",
        .batch_parameters = "BatchParameters",
        .dead_letter_config = "DeadLetterConfig",
        .ecs_parameters = "EcsParameters",
        .http_parameters = "HttpParameters",
        .id = "Id",
        .input = "Input",
        .input_path = "InputPath",
        .input_transformer = "InputTransformer",
        .kinesis_parameters = "KinesisParameters",
        .redshift_data_parameters = "RedshiftDataParameters",
        .retry_policy = "RetryPolicy",
        .role_arn = "RoleArn",
        .run_command_parameters = "RunCommandParameters",
        .sage_maker_pipeline_parameters = "SageMakerPipelineParameters",
        .sqs_parameters = "SqsParameters",
    };
};
