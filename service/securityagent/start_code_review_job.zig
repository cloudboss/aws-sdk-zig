const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiffSource = @import("diff_source.zig").DiffSource;
const JobStatus = @import("job_status.zig").JobStatus;

pub const StartCodeReviewJobInput = struct {
    /// The unique identifier of the agent space.
    agent_space_id: []const u8,

    /// The unique identifier of the code review to start a job for.
    code_review_id: []const u8,

    /// Source of the diff for a differential scan. When present, the job analyzes
    /// only the changed lines instead of performing a full scan.
    diff_source: ?DiffSource = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .code_review_id = "codeReviewId",
        .diff_source = "diffSource",
    };
};

pub const StartCodeReviewJobOutput = struct {
    /// The unique identifier of the agent space.
    agent_space_id: ?[]const u8 = null,

    /// The unique identifier of the code review.
    code_review_id: []const u8,

    /// The unique identifier of the started code review job.
    code_review_job_id: []const u8,

    /// The date and time the code review job was created, in UTC format.
    created_at: ?i64 = null,

    /// The current status of the code review job.
    status: ?JobStatus = null,

    /// The title of the code review job.
    title: ?[]const u8 = null,

    /// The date and time the code review job was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .code_review_id = "codeReviewId",
        .code_review_job_id = "codeReviewJobId",
        .created_at = "createdAt",
        .status = "status",
        .title = "title",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCodeReviewJobInput, options: CallOptions) !StartCodeReviewJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCodeReviewJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartCodeReviewJob";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentSpaceId\":");
    try aws.json.writeValue(@TypeOf(input.agent_space_id), input.agent_space_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"codeReviewId\":");
    try aws.json.writeValue(@TypeOf(input.code_review_id), input.code_review_id, allocator, &body_buf);
    has_prev = true;
    if (input.diff_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"diffSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCodeReviewJobOutput {
    const result: StartCodeReviewJobOutput = try aws.json.parseJsonObject(
        StartCodeReviewJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
