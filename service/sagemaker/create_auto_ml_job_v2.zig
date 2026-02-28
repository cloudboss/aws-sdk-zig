const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoMLComputeConfig = @import("auto_ml_compute_config.zig").AutoMLComputeConfig;
const AutoMLJobChannel = @import("auto_ml_job_channel.zig").AutoMLJobChannel;
const AutoMLJobObjective = @import("auto_ml_job_objective.zig").AutoMLJobObjective;
const AutoMLProblemTypeConfig = @import("auto_ml_problem_type_config.zig").AutoMLProblemTypeConfig;
const AutoMLDataSplitConfig = @import("auto_ml_data_split_config.zig").AutoMLDataSplitConfig;
const ModelDeployConfig = @import("model_deploy_config.zig").ModelDeployConfig;
const AutoMLOutputDataConfig = @import("auto_ml_output_data_config.zig").AutoMLOutputDataConfig;
const AutoMLSecurityConfig = @import("auto_ml_security_config.zig").AutoMLSecurityConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateAutoMLJobV2Input = struct {
    /// Specifies the compute configuration for the AutoML job V2.
    auto_ml_compute_config: ?AutoMLComputeConfig = null,

    /// An array of channel objects describing the input data and their location.
    /// Each channel is a named input source. Similar to the
    /// [InputDataConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateAutoMLJob.html#sagemaker-CreateAutoMLJob-request-InputDataConfig) attribute in the `CreateAutoMLJob` input parameters. The supported formats depend on the problem type:
    ///
    /// * For tabular problem types: `S3Prefix`, `ManifestFile`.
    /// * For image classification: `S3Prefix`, `ManifestFile`,
    ///   `AugmentedManifestFile`.
    /// * For text classification: `S3Prefix`.
    /// * For time-series forecasting: `S3Prefix`.
    /// * For text generation (LLMs fine-tuning): `S3Prefix`.
    auto_ml_job_input_data_config: []const AutoMLJobChannel,

    /// Identifies an Autopilot job. The name must be unique to your account and is
    /// case insensitive.
    auto_ml_job_name: []const u8,

    /// Specifies a metric to minimize or maximize as the objective of a job. If not
    /// specified, the default objective metric depends on the problem type. For the
    /// list of default values per problem type, see
    /// [AutoMLJobObjective](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLJobObjective.html).
    ///
    /// * For tabular problem types: You must either provide both the
    ///   `AutoMLJobObjective` and indicate the type of supervised learning problem
    ///   in `AutoMLProblemTypeConfig` (`TabularJobConfig.ProblemType`), or none at
    ///   all.
    /// * For text generation problem types (LLMs fine-tuning): Fine-tuning language
    ///   models in Autopilot does not require setting the `AutoMLJobObjective`
    ///   field. Autopilot fine-tunes LLMs without requiring multiple candidates to
    ///   be trained and evaluated. Instead, using your dataset, Autopilot directly
    ///   fine-tunes your target model to enhance a default objective metric, the
    ///   cross-entropy loss. After fine-tuning a language model, you can evaluate
    ///   the quality of its generated text using different metrics. For a list of
    ///   the available metrics, see [Metrics for fine-tuning LLMs in
    ///   Autopilot](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-llms-finetuning-metrics.html).
    auto_ml_job_objective: ?AutoMLJobObjective = null,

    /// Defines the configuration settings of one of the supported problem types.
    auto_ml_problem_type_config: AutoMLProblemTypeConfig,

    /// This structure specifies how to split the data into train and validation
    /// datasets.
    ///
    /// The validation and training datasets must contain the same headers. For jobs
    /// created by calling `CreateAutoMLJob`, the validation dataset must be less
    /// than 2 GB in size.
    ///
    /// This attribute must not be set for the time-series forecasting problem type,
    /// as Autopilot automatically splits the input dataset into training and
    /// validation sets.
    data_split_config: ?AutoMLDataSplitConfig = null,

    /// Specifies how to generate the endpoint name for an automatic one-click
    /// Autopilot model deployment.
    model_deploy_config: ?ModelDeployConfig = null,

    /// Provides information about encryption and the Amazon S3 output path needed
    /// to store artifacts from an AutoML job.
    output_data_config: AutoMLOutputDataConfig,

    /// The ARN of the role that is used to access the data.
    role_arn: []const u8,

    /// The security configuration for traffic encryption or Amazon VPC settings.
    security_config: ?AutoMLSecurityConfig = null,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, such as by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web
    /// ServicesResources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html). Tag keys must be unique per resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .auto_ml_compute_config = "AutoMLComputeConfig",
        .auto_ml_job_input_data_config = "AutoMLJobInputDataConfig",
        .auto_ml_job_name = "AutoMLJobName",
        .auto_ml_job_objective = "AutoMLJobObjective",
        .auto_ml_problem_type_config = "AutoMLProblemTypeConfig",
        .data_split_config = "DataSplitConfig",
        .model_deploy_config = "ModelDeployConfig",
        .output_data_config = "OutputDataConfig",
        .role_arn = "RoleArn",
        .security_config = "SecurityConfig",
        .tags = "Tags",
    };
};

pub const CreateAutoMLJobV2Output = struct {
    /// The unique ARN assigned to the AutoMLJob when it is created.
    auto_ml_job_arn: []const u8,

    pub const json_field_names = .{
        .auto_ml_job_arn = "AutoMLJobArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutoMLJobV2Input, options: Options) !CreateAutoMLJobV2Output {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAutoMLJobV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateAutoMLJobV2");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAutoMLJobV2Output {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAutoMLJobV2Output, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
