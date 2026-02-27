const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ServiceJobRetryStrategy = @import("service_job_retry_strategy.zig").ServiceJobRetryStrategy;
const ServiceJobType = @import("service_job_type.zig").ServiceJobType;
const ServiceJobTimeout = @import("service_job_timeout.zig").ServiceJobTimeout;

pub const SubmitServiceJobInput = struct {
    /// A unique identifier for the request. This token is used to ensure
    /// idempotency of requests. If this parameter is specified and two submit
    /// requests with identical payloads and `clientToken`s are received, these
    /// requests are considered the same request and the second request is rejected.
    client_token: ?[]const u8 = null,

    /// The name of the service job. It can be up to 128 characters long. It can
    /// contain uppercase and lowercase letters, numbers, hyphens (-), and
    /// underscores (_).
    job_name: []const u8,

    /// The job queue into which the service job is submitted. You can specify
    /// either the name or the ARN of the queue. The job queue must have the type
    /// `SAGEMAKER_TRAINING`.
    job_queue: []const u8,

    /// The retry strategy to use for failed service jobs that are submitted with
    /// this service job request.
    retry_strategy: ?ServiceJobRetryStrategy = null,

    /// The scheduling priority of the service job. Valid values are integers
    /// between 0 and 9999.
    scheduling_priority: ?i32 = null,

    /// The type of service job. For SageMaker Training jobs, specify
    /// `SAGEMAKER_TRAINING`.
    service_job_type: ServiceJobType,

    /// The request, in JSON, for the service that the SubmitServiceJob operation is
    /// queueing.
    service_request_payload: []const u8,

    /// The share identifier for the service job. Don't specify this parameter if
    /// the job
    /// queue doesn't have a fair-share scheduling policy. If the job queue has a
    /// fair-share
    /// scheduling policy, then this parameter must be specified.
    share_identifier: ?[]const u8 = null,

    /// The tags that you apply to the service job request. Each tag consists of a
    /// key and an optional value. For more information, see [Tagging your Batch
    /// resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timeout configuration for the service job. If none is specified, Batch
    /// defers to the default timeout of the underlying service handling the job.
    timeout_config: ?ServiceJobTimeout = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .job_name = "jobName",
        .job_queue = "jobQueue",
        .retry_strategy = "retryStrategy",
        .scheduling_priority = "schedulingPriority",
        .service_job_type = "serviceJobType",
        .service_request_payload = "serviceRequestPayload",
        .share_identifier = "shareIdentifier",
        .tags = "tags",
        .timeout_config = "timeoutConfig",
    };
};

pub const SubmitServiceJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the service job.
    job_arn: ?[]const u8 = null,

    /// The unique identifier for the service job.
    job_id: []const u8,

    /// The name of the service job.
    job_name: []const u8,

    pub const json_field_names = .{
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_name = "jobName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SubmitServiceJobInput, options: Options) !SubmitServiceJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

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

fn serializeRequest(alloc: std.mem.Allocator, input: SubmitServiceJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/submitservicejob";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"jobQueue\":");
    try aws.json.writeValue(@TypeOf(input.job_queue), input.job_queue, alloc, &body_buf);
    has_prev = true;
    if (input.retry_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"retryStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.scheduling_priority) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"schedulingPriority\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"serviceJobType\":");
    try aws.json.writeValue(@TypeOf(input.service_job_type), input.service_job_type, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"serviceRequestPayload\":");
    try aws.json.writeValue(@TypeOf(input.service_request_payload), input.service_request_payload, alloc, &body_buf);
    has_prev = true;
    if (input.share_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"shareIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.timeout_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"timeoutConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SubmitServiceJobOutput {
    var result: SubmitServiceJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SubmitServiceJobOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
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
