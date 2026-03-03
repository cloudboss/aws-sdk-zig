const PipeTargetBatchJobParameters = @import("pipe_target_batch_job_parameters.zig").PipeTargetBatchJobParameters;
const PipeTargetCloudWatchLogsParameters = @import("pipe_target_cloud_watch_logs_parameters.zig").PipeTargetCloudWatchLogsParameters;
const PipeTargetEcsTaskParameters = @import("pipe_target_ecs_task_parameters.zig").PipeTargetEcsTaskParameters;
const PipeTargetEventBridgeEventBusParameters = @import("pipe_target_event_bridge_event_bus_parameters.zig").PipeTargetEventBridgeEventBusParameters;
const PipeTargetHttpParameters = @import("pipe_target_http_parameters.zig").PipeTargetHttpParameters;
const PipeTargetKinesisStreamParameters = @import("pipe_target_kinesis_stream_parameters.zig").PipeTargetKinesisStreamParameters;
const PipeTargetLambdaFunctionParameters = @import("pipe_target_lambda_function_parameters.zig").PipeTargetLambdaFunctionParameters;
const PipeTargetRedshiftDataParameters = @import("pipe_target_redshift_data_parameters.zig").PipeTargetRedshiftDataParameters;
const PipeTargetSageMakerPipelineParameters = @import("pipe_target_sage_maker_pipeline_parameters.zig").PipeTargetSageMakerPipelineParameters;
const PipeTargetSqsQueueParameters = @import("pipe_target_sqs_queue_parameters.zig").PipeTargetSqsQueueParameters;
const PipeTargetStateMachineParameters = @import("pipe_target_state_machine_parameters.zig").PipeTargetStateMachineParameters;
const PipeTargetTimestreamParameters = @import("pipe_target_timestream_parameters.zig").PipeTargetTimestreamParameters;

/// The parameters required to set up a target for your pipe.
///
/// For more information about pipe target parameters, including how to use
/// dynamic path parameters, see [Target
/// parameters](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-pipes-event-target.html) in the *Amazon EventBridge User Guide*.
pub const PipeTargetParameters = struct {
    /// The parameters for using an Batch job as a target.
    batch_job_parameters: ?PipeTargetBatchJobParameters = null,

    /// The parameters for using an CloudWatch Logs log stream as a target.
    cloud_watch_logs_parameters: ?PipeTargetCloudWatchLogsParameters = null,

    /// The parameters for using an Amazon ECS task as a target.
    ecs_task_parameters: ?PipeTargetEcsTaskParameters = null,

    /// The parameters for using an EventBridge event bus as a target.
    event_bridge_event_bus_parameters: ?PipeTargetEventBridgeEventBusParameters = null,

    /// These are custom parameter to be used when the target is an API Gateway REST
    /// APIs or
    /// EventBridge ApiDestinations.
    http_parameters: ?PipeTargetHttpParameters = null,

    /// Valid JSON text passed to the target. In this case, nothing from the event
    /// itself is
    /// passed to the target. For more information, see [The JavaScript Object
    /// Notation (JSON)
    /// Data Interchange Format](http://www.rfc-editor.org/rfc/rfc7159.txt).
    ///
    /// To remove an input template, specify an empty string.
    input_template: ?[]const u8 = null,

    /// The parameters for using a Kinesis stream as a target.
    kinesis_stream_parameters: ?PipeTargetKinesisStreamParameters = null,

    /// The parameters for using a Lambda function as a target.
    lambda_function_parameters: ?PipeTargetLambdaFunctionParameters = null,

    /// These are custom parameters to be used when the target is a Amazon Redshift
    /// cluster to invoke the
    /// Amazon Redshift Data API BatchExecuteStatement.
    redshift_data_parameters: ?PipeTargetRedshiftDataParameters = null,

    /// The parameters for using a SageMaker pipeline as a target.
    sage_maker_pipeline_parameters: ?PipeTargetSageMakerPipelineParameters = null,

    /// The parameters for using a Amazon SQS stream as a target.
    sqs_queue_parameters: ?PipeTargetSqsQueueParameters = null,

    /// The parameters for using a Step Functions state machine as a target.
    step_function_state_machine_parameters: ?PipeTargetStateMachineParameters = null,

    /// The parameters for using a Timestream for LiveAnalytics table as a
    /// target.
    timestream_parameters: ?PipeTargetTimestreamParameters = null,

    pub const json_field_names = .{
        .batch_job_parameters = "BatchJobParameters",
        .cloud_watch_logs_parameters = "CloudWatchLogsParameters",
        .ecs_task_parameters = "EcsTaskParameters",
        .event_bridge_event_bus_parameters = "EventBridgeEventBusParameters",
        .http_parameters = "HttpParameters",
        .input_template = "InputTemplate",
        .kinesis_stream_parameters = "KinesisStreamParameters",
        .lambda_function_parameters = "LambdaFunctionParameters",
        .redshift_data_parameters = "RedshiftDataParameters",
        .sage_maker_pipeline_parameters = "SageMakerPipelineParameters",
        .sqs_queue_parameters = "SqsQueueParameters",
        .step_function_state_machine_parameters = "StepFunctionStateMachineParameters",
        .timestream_parameters = "TimestreamParameters",
    };
};
