const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InferenceSpecification = @import("inference_specification.zig").InferenceSpecification;
const Tag = @import("tag.zig").Tag;
const TrainingSpecification = @import("training_specification.zig").TrainingSpecification;
const AlgorithmValidationSpecification = @import("algorithm_validation_specification.zig").AlgorithmValidationSpecification;

pub const CreateAlgorithmInput = struct {
    /// A description of the algorithm.
    algorithm_description: ?[]const u8 = null,

    /// The name of the algorithm.
    algorithm_name: []const u8,

    /// Whether to certify the algorithm so that it can be listed in Amazon Web
    /// Services Marketplace.
    certify_for_marketplace: ?bool = null,

    /// Specifies details about inference jobs that the algorithm runs, including
    /// the following:
    ///
    /// * The Amazon ECR paths of containers that contain the inference code and
    ///   model artifacts.
    /// * The instance types that the algorithm supports for transform jobs and
    ///   real-time endpoints used for inference.
    /// * The input and output content formats that the algorithm supports for
    ///   inference.
    inference_specification: ?InferenceSpecification = null,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    /// Specifies details about training jobs run by this algorithm, including the
    /// following:
    ///
    /// * The Amazon ECR path of the container and the version digest of the
    ///   algorithm.
    /// * The hyperparameters that the algorithm supports.
    /// * The instance types that the algorithm supports for training.
    /// * Whether the algorithm supports distributed training.
    /// * The metrics that the algorithm emits to Amazon CloudWatch.
    /// * Which metrics that the algorithm emits can be used as the objective metric
    ///   for hyperparameter tuning jobs.
    /// * The input channels that the algorithm supports for training data. For
    ///   example, an algorithm might support `train`, `validation`, and `test`
    ///   channels.
    training_specification: TrainingSpecification,

    /// Specifies configurations for one or more training jobs and that SageMaker
    /// runs to test the algorithm's training code and, optionally, one or more
    /// batch transform jobs that SageMaker runs to test the algorithm's inference
    /// code.
    validation_specification: ?AlgorithmValidationSpecification = null,

    pub const json_field_names = .{
        .algorithm_description = "AlgorithmDescription",
        .algorithm_name = "AlgorithmName",
        .certify_for_marketplace = "CertifyForMarketplace",
        .inference_specification = "InferenceSpecification",
        .tags = "Tags",
        .training_specification = "TrainingSpecification",
        .validation_specification = "ValidationSpecification",
    };
};

pub const CreateAlgorithmOutput = struct {
    /// The Amazon Resource Name (ARN) of the new algorithm.
    algorithm_arn: []const u8,

    pub const json_field_names = .{
        .algorithm_arn = "AlgorithmArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAlgorithmInput, options: CallOptions) !CreateAlgorithmOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAlgorithmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateAlgorithm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAlgorithmOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAlgorithmOutput, body, allocator);
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
