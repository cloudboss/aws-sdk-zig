const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AutoMLJobConfig = @import("auto_ml_job_config.zig").AutoMLJobConfig;
const AutoMLJobObjective = @import("auto_ml_job_objective.zig").AutoMLJobObjective;
const AutoMLChannel = @import("auto_ml_channel.zig").AutoMLChannel;
const ModelDeployConfig = @import("model_deploy_config.zig").ModelDeployConfig;
const AutoMLOutputDataConfig = @import("auto_ml_output_data_config.zig").AutoMLOutputDataConfig;
const ProblemType = @import("problem_type.zig").ProblemType;
const Tag = @import("tag.zig").Tag;

pub const CreateAutoMLJobInput = struct {
    /// A collection of settings used to configure an AutoML job.
    auto_ml_job_config: ?AutoMLJobConfig = null,

    /// Identifies an Autopilot job. The name must be unique to your account and is
    /// case insensitive.
    auto_ml_job_name: []const u8,

    /// Specifies a metric to minimize or maximize as the objective of a job. If not
    /// specified, the default objective metric depends on the problem type. See
    /// [AutoMLJobObjective](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLJobObjective.html) for the default values.
    auto_ml_job_objective: ?AutoMLJobObjective = null,

    /// Generates possible candidates without training the models. A candidate is a
    /// combination of data preprocessors, algorithms, and algorithm parameter
    /// settings.
    generate_candidate_definitions_only: ?bool = null,

    /// An array of channel objects that describes the input data and its location.
    /// Each channel is a named input source. Similar to `InputDataConfig` supported
    /// by
    /// [HyperParameterTrainingJobDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTrainingJobDefinition.html). Format(s) supported: CSV, Parquet. A minimum of 500 rows is required for the training dataset. There is not a minimum number of rows required for the validation dataset.
    input_data_config: []const AutoMLChannel,

    /// Specifies how to generate the endpoint name for an automatic one-click
    /// Autopilot model deployment.
    model_deploy_config: ?ModelDeployConfig = null,

    /// Provides information about encryption and the Amazon S3 output path needed
    /// to store artifacts from an AutoML job. Format(s) supported: CSV.
    output_data_config: AutoMLOutputDataConfig,

    /// Defines the type of supervised learning problem available for the
    /// candidates. For more information, see [ SageMaker Autopilot problem
    /// types](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-datasets-problem-types.html#autopilot-problem-types).
    problem_type: ?ProblemType = null,

    /// The ARN of the role that is used to access the data.
    role_arn: []const u8,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web
    /// ServicesResources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html). Tag keys must be unique per resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .auto_ml_job_config = "AutoMLJobConfig",
        .auto_ml_job_name = "AutoMLJobName",
        .auto_ml_job_objective = "AutoMLJobObjective",
        .generate_candidate_definitions_only = "GenerateCandidateDefinitionsOnly",
        .input_data_config = "InputDataConfig",
        .model_deploy_config = "ModelDeployConfig",
        .output_data_config = "OutputDataConfig",
        .problem_type = "ProblemType",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateAutoMLJobOutput = struct {
    /// The unique ARN assigned to the AutoML job when it is created.
    auto_ml_job_arn: []const u8,

    pub const json_field_names = .{
        .auto_ml_job_arn = "AutoMLJobArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAutoMLJobInput, options: Options) !CreateAutoMLJobOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAutoMLJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateAutoMLJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAutoMLJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAutoMLJobOutput, body, alloc);
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
