const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TerminateJobsErrorDetail = @import("terminate_jobs_error_detail.zig").TerminateJobsErrorDetail;

pub const TerminateJobsInput = struct {
    /// An array of up to 50 Batch job IDs of the jobs to terminate.
    jobs: []const []const u8,

    /// A message to attach to the job that explains the reason for terminating it.
    /// This message is
    /// returned by future DescribeJobs operations on the job. It is also
    /// recorded in the Batch activity logs.
    ///
    /// This parameter has a limit of 1024 characters.
    reason: []const u8,

    pub const json_field_names = .{
        .jobs = "jobs",
        .reason = "reason",
    };
};

pub const TerminateJobsOutput = struct {
    /// A list of `TerminateJobsErrorDetail` items, one for each job that couldn't
    /// be
    /// terminated. Each item includes the job ID along with a code and message that
    /// describe why the
    /// job wasn't terminated.
    errors: ?[]const TerminateJobsErrorDetail = null,

    /// A list of the job IDs whose termination request was accepted.
    successful: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .errors = "errors",
        .successful = "successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TerminateJobsInput, options: CallOptions) !TerminateJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "batch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TerminateJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/terminatejobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobs\":");
    try aws.json.writeValue(@TypeOf(input.jobs), input.jobs, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"reason\":");
    try aws.json.writeValue(@TypeOf(input.reason), input.reason, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TerminateJobsOutput {
    const result: TerminateJobsOutput = try aws.json.parseJsonObject(
        TerminateJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
