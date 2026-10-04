const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelJobInput = struct {
    /// An optional comment string describing why the job was canceled.
    comment: ?[]const u8 = null,

    /// (Optional) If `true` job executions with status "IN_PROGRESS" and
    /// "QUEUED" are canceled, otherwise only job executions with status "QUEUED"
    /// are canceled.
    /// The default is `false`.
    ///
    /// Canceling a job which is "IN_PROGRESS", will cause a device which is
    /// executing the
    /// job to be unable to update the job execution status. Use caution and ensure
    /// that each
    /// device executing a job which is canceled is able to recover to a valid
    /// state.
    force: ?bool = null,

    /// The unique identifier you assigned to this job when it was created.
    job_id: []const u8,

    /// (Optional)A reason code string that explains why the job was canceled.
    reason_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .comment = "comment",
        .force = "force",
        .job_id = "jobId",
        .reason_code = "reasonCode",
    };
};

pub const CancelJobOutput = struct {
    /// A short text description of the job.
    description: ?[]const u8 = null,

    /// The job ARN.
    job_arn: ?[]const u8 = null,

    /// The unique identifier you assigned to this job when it was created.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .job_arn = "jobArn",
        .job_id = "jobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelJobInput, options: CallOptions) !CancelJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/cancel");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.force) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "force=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"comment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reason_code) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reasonCode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelJobOutput {
    const result: CancelJobOutput = try aws.json.parseJsonObject(
        CancelJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
