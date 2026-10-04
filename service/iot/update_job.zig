const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AbortConfig = @import("abort_config.zig").AbortConfig;
const JobExecutionsRetryConfig = @import("job_executions_retry_config.zig").JobExecutionsRetryConfig;
const JobExecutionsRolloutConfig = @import("job_executions_rollout_config.zig").JobExecutionsRolloutConfig;
const PresignedUrlConfig = @import("presigned_url_config.zig").PresignedUrlConfig;
const TimeoutConfig = @import("timeout_config.zig").TimeoutConfig;

pub const UpdateJobInput = struct {
    /// Allows you to create criteria to abort a job.
    abort_config: ?AbortConfig = null,

    /// A short text description of the job.
    description: ?[]const u8 = null,

    /// Allows you to create the criteria to retry a job.
    job_executions_retry_config: ?JobExecutionsRetryConfig = null,

    /// Allows you to create a staged rollout of the job.
    job_executions_rollout_config: ?JobExecutionsRolloutConfig = null,

    /// The ID of the job to be updated.
    job_id: []const u8,

    /// The namespace used to indicate that a job is a customer-managed job.
    ///
    /// When you specify a value for this parameter, Amazon Web Services IoT Core
    /// sends jobs notifications to
    /// MQTT topics that contain the value in the following format.
    ///
    /// `$aws/things/*THING_NAME*/jobs/*JOB_ID*/notify-namespace-*NAMESPACE_ID*/`
    ///
    /// The `namespaceId` feature is only supported by IoT Greengrass at this time.
    /// For
    /// more information, see [Setting up IoT Greengrass core
    /// devices.](https://docs.aws.amazon.com/greengrass/v2/developerguide/setting-up.html)
    namespace_id: ?[]const u8 = null,

    /// Configuration information for pre-signed S3 URLs.
    presigned_url_config: ?PresignedUrlConfig = null,

    /// Specifies the amount of time each device has to finish its execution of the
    /// job. The
    /// timer is started when the job execution status is set to `IN_PROGRESS`. If
    /// the job execution status is not set to another terminal state before the
    /// time expires,
    /// it will be automatically set to `TIMED_OUT`.
    timeout_config: ?TimeoutConfig = null,

    pub const json_field_names = .{
        .abort_config = "abortConfig",
        .description = "description",
        .job_executions_retry_config = "jobExecutionsRetryConfig",
        .job_executions_rollout_config = "jobExecutionsRolloutConfig",
        .job_id = "jobId",
        .namespace_id = "namespaceId",
        .presigned_url_config = "presignedUrlConfig",
        .timeout_config = "timeoutConfig",
    };
};

pub const UpdateJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateJobInput, options: CallOptions) !UpdateJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.namespace_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "namespaceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.abort_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"abortConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_executions_retry_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobExecutionsRetryConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_executions_rollout_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobExecutionsRolloutConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.presigned_url_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"presignedUrlConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.timeout_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeoutConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateJobOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateJobOutput = .{};

    return result;
}
