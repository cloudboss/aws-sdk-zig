const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Autotune = @import("autotune.zig").Autotune;
const HyperParameterTuningJobConfig = @import("hyper_parameter_tuning_job_config.zig").HyperParameterTuningJobConfig;
const Tag = @import("tag.zig").Tag;
const HyperParameterTrainingJobDefinition = @import("hyper_parameter_training_job_definition.zig").HyperParameterTrainingJobDefinition;
const HyperParameterTuningJobWarmStartConfig = @import("hyper_parameter_tuning_job_warm_start_config.zig").HyperParameterTuningJobWarmStartConfig;

pub const CreateHyperParameterTuningJobInput = struct {
    /// Configures SageMaker Automatic model tuning (AMT) to automatically find
    /// optimal parameters for the following fields:
    ///
    /// *
    ///   [ParameterRanges](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobConfig.html#sagemaker-Type-HyperParameterTuningJobConfig-ParameterRanges): The names and ranges of parameters that a hyperparameter tuning job can optimize.
    /// *
    ///   [ResourceLimits](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ResourceLimits.html): The maximum resources that can be used for a training job. These resources include the maximum number of training jobs, the maximum runtime of a tuning job, and the maximum number of training jobs to run at the same time.
    /// *
    ///   [TrainingJobEarlyStoppingType](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobConfig.html#sagemaker-Type-HyperParameterTuningJobConfig-TrainingJobEarlyStoppingType): A flag that specifies whether or not to use early stopping for training jobs launched by a hyperparameter tuning job.
    /// *
    ///   [RetryStrategy](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTrainingJobDefinition.html#sagemaker-Type-HyperParameterTrainingJobDefinition-RetryStrategy): The number of times to retry a training job.
    /// *
    ///   [Strategy](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobConfig.html): Specifies how hyperparameter tuning chooses the combinations of hyperparameter values to use for the training jobs that it launches.
    /// *
    ///   [ConvergenceDetected](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ConvergenceDetected.html): A flag to indicate that Automatic model tuning (AMT) has detected model convergence.
    autotune: ?Autotune = null,

    /// The
    /// [HyperParameterTuningJobConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobConfig.html) object that describes the tuning job, including the search strategy, the objective metric used to evaluate training jobs, ranges of parameters to search, and resource limits for the tuning job. For more information, see [How Hyperparameter Tuning Works](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-how-it-works.html).
    hyper_parameter_tuning_job_config: HyperParameterTuningJobConfig,

    /// The name of the tuning job. This name is the prefix for the names of all
    /// training jobs that this tuning job launches. The name must be unique within
    /// the same Amazon Web Services account and Amazon Web Services Region. The
    /// name must have 1 to 32 characters. Valid characters are a-z, A-Z, 0-9, and :
    /// + = @ _ % - (hyphen). The name is not case sensitive.
    hyper_parameter_tuning_job_name: []const u8,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    ///
    /// Tags that you specify for the tuning job are also added to all training jobs
    /// that the tuning job launches.
    tags: ?[]const Tag = null,

    /// The
    /// [HyperParameterTrainingJobDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTrainingJobDefinition.html) object that describes the training jobs that this tuning job launches, including static hyperparameters, input data configuration, output data configuration, resource configuration, and stopping condition.
    training_job_definition: ?HyperParameterTrainingJobDefinition = null,

    /// A list of the
    /// [HyperParameterTrainingJobDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTrainingJobDefinition.html) objects launched for this tuning job.
    training_job_definitions: ?[]const HyperParameterTrainingJobDefinition = null,

    /// Specifies the configuration for starting the hyperparameter tuning job using
    /// one or more previous tuning jobs as a starting point. The results of
    /// previous tuning jobs are used to inform which combinations of
    /// hyperparameters to search over in the new tuning job.
    ///
    /// All training jobs launched by the new hyperparameter tuning job are
    /// evaluated by using the objective metric. If you specify
    /// `IDENTICAL_DATA_AND_ALGORITHM` as the `WarmStartType` value for the warm
    /// start configuration, the training job that performs the best in the new
    /// tuning job is compared to the best training jobs from the parent tuning
    /// jobs. From these, the training job that performs the best as measured by the
    /// objective metric is returned as the overall best training job.
    ///
    /// All training jobs launched by parent hyperparameter tuning jobs and the new
    /// hyperparameter tuning jobs count against the limit of training jobs for the
    /// tuning job.
    warm_start_config: ?HyperParameterTuningJobWarmStartConfig = null,

    pub const json_field_names = .{
        .autotune = "Autotune",
        .hyper_parameter_tuning_job_config = "HyperParameterTuningJobConfig",
        .hyper_parameter_tuning_job_name = "HyperParameterTuningJobName",
        .tags = "Tags",
        .training_job_definition = "TrainingJobDefinition",
        .training_job_definitions = "TrainingJobDefinitions",
        .warm_start_config = "WarmStartConfig",
    };
};

pub const CreateHyperParameterTuningJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the tuning job. SageMaker assigns an ARN
    /// to a hyperparameter tuning job when you create it.
    hyper_parameter_tuning_job_arn: []const u8,

    pub const json_field_names = .{
        .hyper_parameter_tuning_job_arn = "HyperParameterTuningJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHyperParameterTuningJobInput, options: CallOptions) !CreateHyperParameterTuningJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHyperParameterTuningJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateHyperParameterTuningJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHyperParameterTuningJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateHyperParameterTuningJobOutput, body, allocator);
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
