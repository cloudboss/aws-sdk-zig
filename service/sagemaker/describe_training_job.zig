const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AlgorithmSpecification = @import("algorithm_specification.zig").AlgorithmSpecification;
const CheckpointConfig = @import("checkpoint_config.zig").CheckpointConfig;
const DebugHookConfig = @import("debug_hook_config.zig").DebugHookConfig;
const DebugRuleConfiguration = @import("debug_rule_configuration.zig").DebugRuleConfiguration;
const DebugRuleEvaluationStatus = @import("debug_rule_evaluation_status.zig").DebugRuleEvaluationStatus;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const MetricData = @import("metric_data.zig").MetricData;
const InfraCheckConfig = @import("infra_check_config.zig").InfraCheckConfig;
const Channel = @import("channel.zig").Channel;
const MlflowConfig = @import("mlflow_config.zig").MlflowConfig;
const MlflowDetails = @import("mlflow_details.zig").MlflowDetails;
const ModelArtifacts = @import("model_artifacts.zig").ModelArtifacts;
const ModelPackageConfig = @import("model_package_config.zig").ModelPackageConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const ProfilerConfig = @import("profiler_config.zig").ProfilerConfig;
const ProfilerRuleConfiguration = @import("profiler_rule_configuration.zig").ProfilerRuleConfiguration;
const ProfilerRuleEvaluationStatus = @import("profiler_rule_evaluation_status.zig").ProfilerRuleEvaluationStatus;
const ProfilingStatus = @import("profiling_status.zig").ProfilingStatus;
const TrainingProgressInfo = @import("training_progress_info.zig").TrainingProgressInfo;
const RemoteDebugConfig = @import("remote_debug_config.zig").RemoteDebugConfig;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const SecondaryStatus = @import("secondary_status.zig").SecondaryStatus;
const SecondaryStatusTransition = @import("secondary_status_transition.zig").SecondaryStatusTransition;
const ServerlessJobConfig = @import("serverless_job_config.zig").ServerlessJobConfig;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const TensorBoardOutputConfig = @import("tensor_board_output_config.zig").TensorBoardOutputConfig;
const TrainingJobStatus = @import("training_job_status.zig").TrainingJobStatus;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const WarmPoolStatus = @import("warm_pool_status.zig").WarmPoolStatus;

pub const DescribeTrainingJobInput = struct {
    /// The name of the training job.
    training_job_name: []const u8,

    pub const json_field_names = .{
        .training_job_name = "TrainingJobName",
    };
};

pub const DescribeTrainingJobOutput = struct {
    /// Information about the algorithm used for training, and algorithm metadata.
    algorithm_specification: ?AlgorithmSpecification = null,

    /// The Amazon Resource Name (ARN) of an AutoML job.
    auto_ml_job_arn: ?[]const u8 = null,

    /// The billable time in seconds. Billable time refers to the absolute
    /// wall-clock time.
    ///
    /// Multiply `BillableTimeInSeconds` by the number of instances
    /// (`InstanceCount`) in your training cluster to get the total compute time
    /// SageMaker bills you if you run distributed training. The formula is as
    /// follows: `BillableTimeInSeconds * InstanceCount` .
    ///
    /// You can calculate the savings from using managed spot training using the
    /// formula `(1 - BillableTimeInSeconds / TrainingTimeInSeconds) * 100`. For
    /// example, if `BillableTimeInSeconds` is 100 and `TrainingTimeInSeconds` is
    /// 500, the savings is 80%.
    billable_time_in_seconds: ?i32 = null,

    /// The billable token count for eligible serverless training jobs.
    billable_token_count: ?i64 = null,

    checkpoint_config: ?CheckpointConfig = null,

    /// A timestamp that indicates when the training job was created.
    creation_time: i64,

    debug_hook_config: ?DebugHookConfig = null,

    /// Configuration information for Amazon SageMaker Debugger rules for debugging
    /// output tensors.
    debug_rule_configurations: ?[]const DebugRuleConfiguration = null,

    /// Evaluation status of Amazon SageMaker Debugger rules for debugging on a
    /// training job.
    debug_rule_evaluation_statuses: ?[]const DebugRuleEvaluationStatus = null,

    /// To encrypt all communications between ML compute instances in distributed
    /// training, choose `True`. Encryption provides greater security for
    /// distributed training, but training might take longer. How long it takes
    /// depends on the amount of communication between compute instances, especially
    /// if you use a deep learning algorithms in distributed training.
    enable_inter_container_traffic_encryption: ?bool = null,

    /// A Boolean indicating whether managed spot training is enabled (`True`) or
    /// not (`False`).
    enable_managed_spot_training: ?bool = null,

    /// If you want to allow inbound or outbound network calls, except for calls
    /// between peers within a training cluster for distributed training, choose
    /// `True`. If you enable network isolation for training jobs that are
    /// configured to use a VPC, SageMaker downloads and uploads customer data and
    /// model artifacts through the specified VPC, but the training container does
    /// not have network access.
    enable_network_isolation: ?bool = null,

    /// The environment variables to set in the Docker container.
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any environment fields. As part of the shared
    /// responsibility model, you are responsible for any potential exposure,
    /// unauthorized access, or compromise of your sensitive data if caused by
    /// security-sensitive information included in the request environment variable
    /// or plain text fields.
    environment: ?[]const aws.map.StringMapEntry = null,

    experiment_config: ?ExperimentConfig = null,

    /// If the training job failed, the reason it failed.
    failure_reason: ?[]const u8 = null,

    /// A collection of `MetricData` objects that specify the names, values, and
    /// dates and times that the training algorithm emitted to Amazon CloudWatch.
    final_metric_data_list: ?[]const MetricData = null,

    /// Algorithm-specific parameters.
    hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the infrastructure health check configuration for
    /// the training job.
    infra_check_config: ?InfraCheckConfig = null,

    /// An array of `Channel` objects that describes each data input channel.
    input_data_config: ?[]const Channel = null,

    /// The Amazon Resource Name (ARN) of the SageMaker Ground Truth labeling job
    /// that created the transform or training job.
    labeling_job_arn: ?[]const u8 = null,

    /// A timestamp that indicates when the status of the training job was last
    /// modified.
    last_modified_time: ?i64 = null,

    /// The MLflow configuration using SageMaker managed MLflow.
    mlflow_config: ?MlflowConfig = null,

    /// The MLflow details of this job.
    mlflow_details: ?MlflowDetails = null,

    /// Information about the Amazon S3 location that is configured for storing
    /// model artifacts.
    model_artifacts: ?ModelArtifacts = null,

    /// The configuration for the model package.
    model_package_config: ?ModelPackageConfig = null,

    /// The S3 path where model artifacts that you configured when creating the job
    /// are stored. SageMaker creates subfolders for model artifacts.
    output_data_config: ?OutputDataConfig = null,

    /// The Amazon Resource Name (ARN) of the output model package containing model
    /// weights or checkpoints.
    output_model_package_arn: ?[]const u8 = null,

    profiler_config: ?ProfilerConfig = null,

    /// Configuration information for Amazon SageMaker Debugger rules for profiling
    /// system and framework metrics.
    profiler_rule_configurations: ?[]const ProfilerRuleConfiguration = null,

    /// Evaluation status of Amazon SageMaker Debugger rules for profiling on a
    /// training job.
    profiler_rule_evaluation_statuses: ?[]const ProfilerRuleEvaluationStatus = null,

    /// Profiling status of a training job.
    profiling_status: ?ProfilingStatus = null,

    /// The Serverless training job progress information.
    progress_info: ?TrainingProgressInfo = null,

    /// Configuration for remote debugging. To learn more about the remote debugging
    /// functionality of SageMaker, see [Access a training container through Amazon
    /// Web Services Systems Manager (SSM) for remote
    /// debugging](https://docs.aws.amazon.com/sagemaker/latest/dg/train-remote-debugging.html).
    remote_debug_config: ?RemoteDebugConfig = null,

    /// Resources, including ML compute instances and ML storage volumes, that are
    /// configured for model training.
    resource_config: ?ResourceConfig = null,

    /// The number of times to retry the job when the job fails due to an
    /// `InternalServerError`.
    retry_strategy: ?RetryStrategy = null,

    /// The Amazon Web Services Identity and Access Management (IAM) role configured
    /// for the training job.
    role_arn: ?[]const u8 = null,

    /// Provides detailed information about the state of the training job. For
    /// detailed information on the secondary status of the training job, see
    /// `StatusMessage` under
    /// [SecondaryStatusTransition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_SecondaryStatusTransition.html).
    ///
    /// SageMaker provides primary statuses and secondary statuses that apply to
    /// each of them:
    ///
    /// **InProgress**
    ///
    /// * `Starting` - Starting the training job.
    /// * `Pending` - The training job is waiting for compute capacity or compute
    ///   resource provision.
    /// * `Downloading` - An optional stage for algorithms that support `File`
    ///   training input mode. It indicates that data is being downloaded to the ML
    ///   storage volumes.
    /// * `Training` - Training is in progress.
    /// * `Interrupted` - The job stopped because the managed spot training
    ///   instances were interrupted.
    /// * `Uploading` - Training is complete and the model artifacts are being
    ///   uploaded to the S3 location.
    ///
    /// **Completed**
    ///
    /// * `Completed` - The training job has completed.
    ///
    /// **Failed**
    ///
    /// * `Failed` - The training job has failed. The reason for the failure is
    ///   returned in the `FailureReason` field of `DescribeTrainingJobResponse`.
    ///
    /// **Stopped**
    ///
    /// * `MaxRuntimeExceeded` - The job stopped because it exceeded the maximum
    ///   allowed runtime.
    /// * `MaxWaitTimeExceeded` - The job stopped because it exceeded the maximum
    ///   allowed wait time.
    /// * `Stopped` - The training job has stopped.
    ///
    /// **Stopping**
    ///
    /// * `Stopping` - Stopping the training job.
    ///
    /// Valid values for `SecondaryStatus` are subject to change.
    ///
    /// We no longer support the following secondary statuses:
    ///
    /// * `LaunchingMLInstances`
    /// * `PreparingTraining`
    /// * `DownloadingTrainingImage`
    secondary_status: SecondaryStatus,

    /// A history of all of the secondary statuses that the training job has
    /// transitioned through.
    secondary_status_transitions: ?[]const SecondaryStatusTransition = null,

    /// The configuration for serverless training jobs.
    serverless_job_config: ?ServerlessJobConfig = null,

    /// Specifies a limit to how long a model training job can run. It also
    /// specifies how long a managed Spot training job has to complete. When the job
    /// reaches the time limit, SageMaker ends the training job. Use this API to cap
    /// model training costs.
    ///
    /// To stop a job, SageMaker sends the algorithm the `SIGTERM` signal, which
    /// delays job termination for 120 seconds. Algorithms can use this 120-second
    /// window to save the model artifacts, so the results of training are not lost.
    stopping_condition: ?StoppingCondition = null,

    tensor_board_output_config: ?TensorBoardOutputConfig = null,

    /// Indicates the time when the training job ends on training instances. You are
    /// billed for the time interval between the value of `TrainingStartTime` and
    /// this time. For successful jobs and stopped jobs, this is the time after
    /// model artifacts are uploaded. For failed jobs, this is the time when
    /// SageMaker detects a job failure.
    training_end_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the training job.
    training_job_arn: []const u8,

    /// Name of the model training job.
    training_job_name: []const u8,

    /// The status of the training job.
    ///
    /// SageMaker provides the following training job statuses:
    ///
    /// * `InProgress` - The training is in progress.
    /// * `Completed` - The training job has completed.
    /// * `Failed` - The training job has failed. To see the reason for the failure,
    ///   see the `FailureReason` field in the response to a
    ///   `DescribeTrainingJobResponse` call.
    /// * `Stopping` - The training job is stopping.
    /// * `Stopped` - The training job has stopped.
    ///
    /// For more detailed information, see `SecondaryStatus`.
    training_job_status: TrainingJobStatus,

    /// Indicates the time when the training job starts on training instances. You
    /// are billed for the time interval between this time and the value of
    /// `TrainingEndTime`. The start time in CloudWatch Logs might be later than
    /// this time. The difference is due to the time it takes to download the
    /// training data and to the size of the training container.
    training_start_time: ?i64 = null,

    /// The training time in seconds.
    training_time_in_seconds: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the associated hyperparameter tuning job
    /// if the training job was launched by a hyperparameter tuning job.
    tuning_job_arn: ?[]const u8 = null,

    /// A
    /// [VpcConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VpcConfig.html) object that specifies the VPC that this training job has access to. For more information, see [Protect Training Jobs by Using an Amazon Virtual Private Cloud](https://docs.aws.amazon.com/sagemaker/latest/dg/train-vpc.html).
    vpc_config: ?VpcConfig = null,

    /// The status of the warm pool associated with the training job.
    warm_pool_status: ?WarmPoolStatus = null,

    pub const json_field_names = .{
        .algorithm_specification = "AlgorithmSpecification",
        .auto_ml_job_arn = "AutoMLJobArn",
        .billable_time_in_seconds = "BillableTimeInSeconds",
        .billable_token_count = "BillableTokenCount",
        .checkpoint_config = "CheckpointConfig",
        .creation_time = "CreationTime",
        .debug_hook_config = "DebugHookConfig",
        .debug_rule_configurations = "DebugRuleConfigurations",
        .debug_rule_evaluation_statuses = "DebugRuleEvaluationStatuses",
        .enable_inter_container_traffic_encryption = "EnableInterContainerTrafficEncryption",
        .enable_managed_spot_training = "EnableManagedSpotTraining",
        .enable_network_isolation = "EnableNetworkIsolation",
        .environment = "Environment",
        .experiment_config = "ExperimentConfig",
        .failure_reason = "FailureReason",
        .final_metric_data_list = "FinalMetricDataList",
        .hyper_parameters = "HyperParameters",
        .infra_check_config = "InfraCheckConfig",
        .input_data_config = "InputDataConfig",
        .labeling_job_arn = "LabelingJobArn",
        .last_modified_time = "LastModifiedTime",
        .mlflow_config = "MlflowConfig",
        .mlflow_details = "MlflowDetails",
        .model_artifacts = "ModelArtifacts",
        .model_package_config = "ModelPackageConfig",
        .output_data_config = "OutputDataConfig",
        .output_model_package_arn = "OutputModelPackageArn",
        .profiler_config = "ProfilerConfig",
        .profiler_rule_configurations = "ProfilerRuleConfigurations",
        .profiler_rule_evaluation_statuses = "ProfilerRuleEvaluationStatuses",
        .profiling_status = "ProfilingStatus",
        .progress_info = "ProgressInfo",
        .remote_debug_config = "RemoteDebugConfig",
        .resource_config = "ResourceConfig",
        .retry_strategy = "RetryStrategy",
        .role_arn = "RoleArn",
        .secondary_status = "SecondaryStatus",
        .secondary_status_transitions = "SecondaryStatusTransitions",
        .serverless_job_config = "ServerlessJobConfig",
        .stopping_condition = "StoppingCondition",
        .tensor_board_output_config = "TensorBoardOutputConfig",
        .training_end_time = "TrainingEndTime",
        .training_job_arn = "TrainingJobArn",
        .training_job_name = "TrainingJobName",
        .training_job_status = "TrainingJobStatus",
        .training_start_time = "TrainingStartTime",
        .training_time_in_seconds = "TrainingTimeInSeconds",
        .tuning_job_arn = "TuningJobArn",
        .vpc_config = "VpcConfig",
        .warm_pool_status = "WarmPoolStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrainingJobInput, options: CallOptions) !DescribeTrainingJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrainingJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeTrainingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrainingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeTrainingJobOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
