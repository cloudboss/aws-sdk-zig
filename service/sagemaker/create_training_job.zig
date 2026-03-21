const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AlgorithmSpecification = @import("algorithm_specification.zig").AlgorithmSpecification;
const CheckpointConfig = @import("checkpoint_config.zig").CheckpointConfig;
const DebugHookConfig = @import("debug_hook_config.zig").DebugHookConfig;
const DebugRuleConfiguration = @import("debug_rule_configuration.zig").DebugRuleConfiguration;
const ExperimentConfig = @import("experiment_config.zig").ExperimentConfig;
const InfraCheckConfig = @import("infra_check_config.zig").InfraCheckConfig;
const Channel = @import("channel.zig").Channel;
const MlflowConfig = @import("mlflow_config.zig").MlflowConfig;
const ModelPackageConfig = @import("model_package_config.zig").ModelPackageConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const ProfilerConfig = @import("profiler_config.zig").ProfilerConfig;
const ProfilerRuleConfiguration = @import("profiler_rule_configuration.zig").ProfilerRuleConfiguration;
const RemoteDebugConfig = @import("remote_debug_config.zig").RemoteDebugConfig;
const ResourceConfig = @import("resource_config.zig").ResourceConfig;
const RetryStrategy = @import("retry_strategy.zig").RetryStrategy;
const ServerlessJobConfig = @import("serverless_job_config.zig").ServerlessJobConfig;
const SessionChainingConfig = @import("session_chaining_config.zig").SessionChainingConfig;
const StoppingCondition = @import("stopping_condition.zig").StoppingCondition;
const Tag = @import("tag.zig").Tag;
const TensorBoardOutputConfig = @import("tensor_board_output_config.zig").TensorBoardOutputConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const CreateTrainingJobInput = struct {
    /// The registry path of the Docker image that contains the training algorithm
    /// and algorithm-specific metadata, including the input mode. For more
    /// information about algorithms provided by SageMaker, see
    /// [Algorithms](https://docs.aws.amazon.com/sagemaker/latest/dg/algos.html).
    /// For information about providing your own algorithms, see [Using Your Own
    /// Algorithms with Amazon
    /// SageMaker](https://docs.aws.amazon.com/sagemaker/latest/dg/your-algorithms.html).
    algorithm_specification: ?AlgorithmSpecification = null,

    /// Contains information about the output location for managed spot training
    /// checkpoint data.
    checkpoint_config: ?CheckpointConfig = null,

    debug_hook_config: ?DebugHookConfig = null,

    /// Configuration information for Amazon SageMaker Debugger rules for debugging
    /// output tensors.
    debug_rule_configurations: ?[]const DebugRuleConfiguration = null,

    /// To encrypt all communications between ML compute instances in distributed
    /// training, choose `True`. Encryption provides greater security for
    /// distributed training, but training might take longer. How long it takes
    /// depends on the amount of communication between compute instances, especially
    /// if you use a deep learning algorithm in distributed training. For more
    /// information, see [Protect Communications Between ML Compute Instances in a
    /// Distributed Training
    /// Job](https://docs.aws.amazon.com/sagemaker/latest/dg/train-encrypt.html).
    enable_inter_container_traffic_encryption: ?bool = null,

    /// To train models using managed spot training, choose `True`. Managed spot
    /// training provides a fully managed and scalable infrastructure for training
    /// machine learning models. this option is useful when training jobs can be
    /// interrupted and when there is flexibility when the training job is run.
    ///
    /// The complete and intermediate results of jobs are stored in an Amazon S3
    /// bucket, and can be used as a starting point to train models incrementally.
    /// Amazon SageMaker provides metrics and logs in CloudWatch. They can be used
    /// to see when managed spot training jobs are running, interrupted, resumed, or
    /// completed.
    enable_managed_spot_training: ?bool = null,

    /// Isolates the training container. No inbound or outbound network calls can be
    /// made, except for calls between peers within a training cluster for
    /// distributed training. If you enable network isolation for training jobs that
    /// are configured to use a VPC, SageMaker downloads and uploads customer data
    /// and model artifacts through the specified VPC, but the training container
    /// does not have network access.
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

    /// Algorithm-specific parameters that influence the quality of the model. You
    /// set hyperparameters before you start the learning process. For a list of
    /// hyperparameters for each training algorithm provided by SageMaker, see
    /// [Algorithms](https://docs.aws.amazon.com/sagemaker/latest/dg/algos.html).
    ///
    /// You can specify a maximum of 100 hyperparameters. Each hyperparameter is a
    /// key-value pair. Each key and value is limited to 256 characters, as
    /// specified by the `Length Constraint`.
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any hyperparameter fields. As part of the shared
    /// responsibility model, you are responsible for any potential exposure,
    /// unauthorized access, or compromise of your sensitive data if caused by any
    /// security-sensitive information included in the request hyperparameter
    /// variable or plain text fields.
    hyper_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Contains information about the infrastructure health check configuration for
    /// the training job.
    infra_check_config: ?InfraCheckConfig = null,

    /// An array of `Channel` objects. Each channel is a named input source.
    /// `InputDataConfig` describes the input data and its location.
    ///
    /// Algorithms can accept input data from one or more channels. For example, an
    /// algorithm might have two channels of input data, `training_data` and
    /// `validation_data`. The configuration for each channel provides the S3, EFS,
    /// or FSx location where the input data is stored. It also provides information
    /// about the stored data: the MIME type, compression method, and whether the
    /// data is wrapped in RecordIO format.
    ///
    /// Depending on the input mode that the algorithm supports, SageMaker either
    /// copies input data files from an S3 bucket to a local directory in the Docker
    /// container, or makes it available as input streams. For example, if you
    /// specify an EFS location, input data files are available as input streams.
    /// They do not need to be downloaded.
    ///
    /// Your input must be in the same Amazon Web Services region as your training
    /// job.
    input_data_config: ?[]const Channel = null,

    /// The MLflow configuration using SageMaker managed MLflow.
    mlflow_config: ?MlflowConfig = null,

    /// The configuration for the model package.
    model_package_config: ?ModelPackageConfig = null,

    /// Specifies the path to the S3 location where you want to store model
    /// artifacts. SageMaker creates subfolders for the artifacts.
    output_data_config: OutputDataConfig,

    profiler_config: ?ProfilerConfig = null,

    /// Configuration information for Amazon SageMaker Debugger rules for profiling
    /// system and framework metrics.
    profiler_rule_configurations: ?[]const ProfilerRuleConfiguration = null,

    /// Configuration for remote debugging. To learn more about the remote debugging
    /// functionality of SageMaker, see [Access a training container through Amazon
    /// Web Services Systems Manager (SSM) for remote
    /// debugging](https://docs.aws.amazon.com/sagemaker/latest/dg/train-remote-debugging.html).
    remote_debug_config: ?RemoteDebugConfig = null,

    /// The resources, including the ML compute instances and ML storage volumes, to
    /// use for model training.
    ///
    /// ML storage volumes store model artifacts and incremental states. Training
    /// algorithms might also use ML storage volumes for scratch space. If you want
    /// SageMaker to use the ML storage volume to store the training data, choose
    /// `File` as the `TrainingInputMode` in the algorithm specification. For
    /// distributed training algorithms, specify an instance count greater than 1.
    resource_config: ?ResourceConfig = null,

    /// The number of times to retry the job when the job fails due to an
    /// `InternalServerError`.
    retry_strategy: ?RetryStrategy = null,

    /// The Amazon Resource Name (ARN) of an IAM role that SageMaker can assume to
    /// perform tasks on your behalf.
    ///
    /// During model training, SageMaker needs your permission to read input data
    /// from an S3 bucket, download a Docker image that contains training code,
    /// write model artifacts to an S3 bucket, write logs to Amazon CloudWatch Logs,
    /// and publish metrics to Amazon CloudWatch. You grant permissions for all of
    /// these tasks to an IAM role. For more information, see [SageMaker
    /// Roles](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-roles.html).
    ///
    /// To be able to pass this role to SageMaker, the caller of this API must have
    /// the `iam:PassRole` permission.
    role_arn: []const u8,

    /// The configuration for serverless training jobs.
    serverless_job_config: ?ServerlessJobConfig = null,

    /// Contains information about attribute-based access control (ABAC) for the
    /// training job.
    session_chaining_config: ?SessionChainingConfig = null,

    /// Specifies a limit to how long a model training job can run. It also
    /// specifies how long a managed Spot training job has to complete. When the job
    /// reaches the time limit, SageMaker ends the training job. Use this API to cap
    /// model training costs.
    ///
    /// To stop a job, SageMaker sends the algorithm the `SIGTERM` signal, which
    /// delays job termination for 120 seconds. Algorithms can use this 120-second
    /// window to save the model artifacts, so the results of training are not lost.
    stopping_condition: ?StoppingCondition = null,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    ///
    /// Do not include any security-sensitive information including account access
    /// IDs, secrets, or tokens in any tags. As part of the shared responsibility
    /// model, you are responsible for any potential exposure, unauthorized access,
    /// or compromise of your sensitive data if caused by any security-sensitive
    /// information included in the request tag variable or plain text fields.
    tags: ?[]const Tag = null,

    tensor_board_output_config: ?TensorBoardOutputConfig = null,

    /// The name of the training job. The name must be unique within an Amazon Web
    /// Services Region in an Amazon Web Services account.
    training_job_name: []const u8,

    /// A
    /// [VpcConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_VpcConfig.html) object that specifies the VPC that you want your training job to connect to. Control access to and from your training container by configuring the VPC. For more information, see [Protect Training Jobs by Using an Amazon Virtual Private Cloud](https://docs.aws.amazon.com/sagemaker/latest/dg/train-vpc.html).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .algorithm_specification = "AlgorithmSpecification",
        .checkpoint_config = "CheckpointConfig",
        .debug_hook_config = "DebugHookConfig",
        .debug_rule_configurations = "DebugRuleConfigurations",
        .enable_inter_container_traffic_encryption = "EnableInterContainerTrafficEncryption",
        .enable_managed_spot_training = "EnableManagedSpotTraining",
        .enable_network_isolation = "EnableNetworkIsolation",
        .environment = "Environment",
        .experiment_config = "ExperimentConfig",
        .hyper_parameters = "HyperParameters",
        .infra_check_config = "InfraCheckConfig",
        .input_data_config = "InputDataConfig",
        .mlflow_config = "MlflowConfig",
        .model_package_config = "ModelPackageConfig",
        .output_data_config = "OutputDataConfig",
        .profiler_config = "ProfilerConfig",
        .profiler_rule_configurations = "ProfilerRuleConfigurations",
        .remote_debug_config = "RemoteDebugConfig",
        .resource_config = "ResourceConfig",
        .retry_strategy = "RetryStrategy",
        .role_arn = "RoleArn",
        .serverless_job_config = "ServerlessJobConfig",
        .session_chaining_config = "SessionChainingConfig",
        .stopping_condition = "StoppingCondition",
        .tags = "Tags",
        .tensor_board_output_config = "TensorBoardOutputConfig",
        .training_job_name = "TrainingJobName",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateTrainingJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the training job.
    training_job_arn: []const u8,

    pub const json_field_names = .{
        .training_job_arn = "TrainingJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrainingJobInput, options: CallOptions) !CreateTrainingJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrainingJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateTrainingJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrainingJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateTrainingJobOutput, body, allocator);
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
