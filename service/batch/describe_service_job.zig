const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ServiceJobAttemptDetail = @import("service_job_attempt_detail.zig").ServiceJobAttemptDetail;
const LatestServiceJobAttempt = @import("latest_service_job_attempt.zig").LatestServiceJobAttempt;
const ServiceJobRetryStrategy = @import("service_job_retry_strategy.zig").ServiceJobRetryStrategy;
const ServiceJobType = @import("service_job_type.zig").ServiceJobType;
const ServiceJobStatus = @import("service_job_status.zig").ServiceJobStatus;
const ServiceJobTimeout = @import("service_job_timeout.zig").ServiceJobTimeout;

pub const DescribeServiceJobInput = struct {
    /// The job ID for the service job to describe.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
    };
};

pub const DescribeServiceJobOutput = struct {
    /// A list of job attempts associated with the service job.
    attempts: ?[]const ServiceJobAttemptDetail = null,

    /// The Unix timestamp (in milliseconds) for when the service job was created.
    created_at: ?i64 = null,

    /// Indicates whether the service job has been terminated.
    is_terminated: ?bool = null,

    /// The Amazon Resource Name (ARN) of the service job.
    job_arn: ?[]const u8 = null,

    /// The job ID for the service job.
    job_id: []const u8,

    /// The name of the service job.
    job_name: []const u8,

    /// The ARN of the job queue that the service job is associated with.
    job_queue: []const u8,

    /// The latest attempt associated with the service job.
    latest_attempt: ?LatestServiceJobAttempt = null,

    /// The retry strategy to use for failed service jobs that are submitted with
    /// this service job.
    retry_strategy: ?ServiceJobRetryStrategy = null,

    /// The scheduling priority of the service job.
    scheduling_priority: ?i32 = null,

    /// The type of service job. For SageMaker Training jobs, this value is
    /// `SAGEMAKER_TRAINING`.
    service_job_type: ServiceJobType,

    /// The request, in JSON, for the service that the `SubmitServiceJob` operation
    /// is queueing.
    service_request_payload: ?[]const u8 = null,

    /// The share identifier for the service job. This is used for fair-share
    /// scheduling.
    share_identifier: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the service job was started.
    started_at: i64,

    /// The current status of the service job.
    status: ServiceJobStatus,

    /// A short, human-readable string to provide more details for the current
    /// status of the service job.
    status_reason: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the service job stopped
    /// running.
    stopped_at: ?i64 = null,

    /// The tags that are associated with the service job. Each tag consists of a
    /// key and an optional value. For more information, see [Tagging your Batch
    /// resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timeout configuration for the service job.
    timeout_config: ?ServiceJobTimeout = null,

    pub const json_field_names = .{
        .attempts = "attempts",
        .created_at = "createdAt",
        .is_terminated = "isTerminated",
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_name = "jobName",
        .job_queue = "jobQueue",
        .latest_attempt = "latestAttempt",
        .retry_strategy = "retryStrategy",
        .scheduling_priority = "schedulingPriority",
        .service_job_type = "serviceJobType",
        .service_request_payload = "serviceRequestPayload",
        .share_identifier = "shareIdentifier",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
        .tags = "tags",
        .timeout_config = "timeoutConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServiceJobInput, options: Options) !DescribeServiceJobOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeServiceJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/describeservicejob";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"jobId\":");
    try aws.json.writeValue(@TypeOf(input.job_id), input.job_id, alloc, &body_buf);
    has_prev = true;

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeServiceJobOutput {
    var result: DescribeServiceJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeServiceJobOutput, body, alloc);
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
