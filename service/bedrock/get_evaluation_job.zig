const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ApplicationType = @import("application_type.zig").ApplicationType;
const EvaluationConfig = @import("evaluation_config.zig").EvaluationConfig;
const EvaluationInferenceConfig = @import("evaluation_inference_config.zig").EvaluationInferenceConfig;
const EvaluationJobType = @import("evaluation_job_type.zig").EvaluationJobType;
const EvaluationOutputDataConfig = @import("evaluation_output_data_config.zig").EvaluationOutputDataConfig;
const EvaluationJobStatus = @import("evaluation_job_status.zig").EvaluationJobStatus;

pub const GetEvaluationJobInput = struct {
    /// The Amazon Resource Name (ARN) of the evaluation job you want get
    /// information on.
    job_identifier: []const u8,

    pub const json_field_names = .{
        .job_identifier = "jobIdentifier",
    };
};

pub const GetEvaluationJobOutput = struct {
    /// Specifies whether the evaluation job is for evaluating a model or evaluating
    /// a knowledge base (retrieval and response generation).
    application_type: ?ApplicationType = null,

    /// The time the evaluation job was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the customer managed encryption key
    /// specified when the evaluation job was created.
    customer_encryption_key_id: ?[]const u8 = null,

    /// Contains the configuration details of either an automated or human-based
    /// evaluation job.
    evaluation_config: ?EvaluationConfig = null,

    /// A list of strings that specify why the evaluation job failed to create.
    failure_messages: ?[]const []const u8 = null,

    /// Contains the configuration details of the inference model used for the
    /// evaluation job.
    inference_config: ?EvaluationInferenceConfig = null,

    /// The Amazon Resource Name (ARN) of the evaluation job.
    job_arn: []const u8,

    /// The description of the evaluation job.
    job_description: ?[]const u8 = null,

    /// The name for the evaluation job.
    job_name: []const u8,

    /// Specifies whether the evaluation job is automated or human-based.
    job_type: EvaluationJobType,

    /// The time the evaluation job was last modified.
    last_modified_time: ?i64 = null,

    /// Contains the configuration details of the Amazon S3 bucket for storing the
    /// results of the evaluation job.
    output_data_config: ?EvaluationOutputDataConfig = null,

    /// The Amazon Resource Name (ARN) of the IAM service role used in the
    /// evaluation job.
    role_arn: []const u8,

    /// The current status of the evaluation job.
    status: EvaluationJobStatus,

    pub const json_field_names = .{
        .application_type = "applicationType",
        .creation_time = "creationTime",
        .customer_encryption_key_id = "customerEncryptionKeyId",
        .evaluation_config = "evaluationConfig",
        .failure_messages = "failureMessages",
        .inference_config = "inferenceConfig",
        .job_arn = "jobArn",
        .job_description = "jobDescription",
        .job_name = "jobName",
        .job_type = "jobType",
        .last_modified_time = "lastModifiedTime",
        .output_data_config = "outputDataConfig",
        .role_arn = "roleArn",
        .status = "status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEvaluationJobInput, options: Options) !GetEvaluationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetEvaluationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/evaluation-jobs/");
    try path_buf.appendSlice(alloc, input.job_identifier);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetEvaluationJobOutput {
    var result: GetEvaluationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEvaluationJobOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
