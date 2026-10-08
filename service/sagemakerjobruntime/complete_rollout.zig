const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompletionStatus = @import("completion_status.zig").CompletionStatus;

pub const CompleteRolloutInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The job ARN.
    job_arn: []const u8,

    /// The target status for the trajectory. Defaults to READY if not specified.
    /// Set to FAILED if the rollout encountered an error and the trajectory should
    /// not be used for processing.
    status: ?CompletionStatus = null,

    /// The trajectory ID to mark as complete.
    trajectory_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .job_arn = "JobArn",
        .status = "Status",
        .trajectory_id = "TrajectoryId",
    };
};

pub const CompleteRolloutOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompleteRolloutInput, options: CallOptions) !CompleteRolloutOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CompleteRolloutInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("job-runtime.sagemaker", "SagemakerJobRuntime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/complete-rollout";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TrajectoryId\":");
    try aws.json.writeValue(@TypeOf(input.trajectory_id), input.trajectory_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "X-Amzn-SageMaker-Job-Arn", input.job_arn);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompleteRolloutOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CompleteRolloutOutput = .{};

    return result;
}
