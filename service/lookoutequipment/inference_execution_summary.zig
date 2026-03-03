const S3Object = @import("s3_object.zig").S3Object;
const InferenceInputConfiguration = @import("inference_input_configuration.zig").InferenceInputConfiguration;
const InferenceOutputConfiguration = @import("inference_output_configuration.zig").InferenceOutputConfiguration;
const InferenceExecutionStatus = @import("inference_execution_status.zig").InferenceExecutionStatus;

/// Contains information about the specific inference execution, including input
/// and output
/// data configuration, inference scheduling information, status, and so on.
pub const InferenceExecutionSummary = struct {
    /// The S3 object that the inference execution results were uploaded to.
    customer_result_object: ?S3Object = null,

    /// Indicates the time reference in the dataset at which the inference execution
    /// stopped.
    data_end_time: ?i64 = null,

    /// Specifies configuration information for the input data for the inference
    /// scheduler,
    /// including delimiter, format, and dataset location.
    data_input_configuration: ?InferenceInputConfiguration = null,

    /// Specifies configuration information for the output results from for the
    /// inference
    /// execution, including the output Amazon S3 location.
    data_output_configuration: ?InferenceOutputConfiguration = null,

    /// Indicates the time reference in the dataset at which the inference execution
    /// began.
    data_start_time: ?i64 = null,

    /// Specifies the reason for failure when an inference execution has failed.
    failed_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the inference scheduler being used for the
    /// inference
    /// execution.
    inference_scheduler_arn: ?[]const u8 = null,

    /// The name of the inference scheduler being used for the inference execution.
    inference_scheduler_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the machine learning model used for the
    /// inference
    /// execution.
    model_arn: ?[]const u8 = null,

    /// The name of the machine learning model being used for the inference
    /// execution.
    model_name: ?[]const u8 = null,

    /// The model version used for the inference execution.
    model_version: ?i64 = null,

    /// The Amazon Resource Number (ARN) of the model version used for the inference
    /// execution.
    model_version_arn: ?[]const u8 = null,

    /// Indicates the start time at which the inference scheduler began the specific
    /// inference
    /// execution.
    scheduled_start_time: ?i64 = null,

    /// Indicates the status of the inference execution.
    status: ?InferenceExecutionStatus = null,

    pub const json_field_names = .{
        .customer_result_object = "CustomerResultObject",
        .data_end_time = "DataEndTime",
        .data_input_configuration = "DataInputConfiguration",
        .data_output_configuration = "DataOutputConfiguration",
        .data_start_time = "DataStartTime",
        .failed_reason = "FailedReason",
        .inference_scheduler_arn = "InferenceSchedulerArn",
        .inference_scheduler_name = "InferenceSchedulerName",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .model_version = "ModelVersion",
        .model_version_arn = "ModelVersionArn",
        .scheduled_start_time = "ScheduledStartTime",
        .status = "Status",
    };
};
