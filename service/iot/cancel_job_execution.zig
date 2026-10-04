const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelJobExecutionInput = struct {
    /// (Optional) The expected current version of the job execution. Each time you
    /// update
    /// the job execution, its version is incremented. If the version of the job
    /// execution
    /// stored in Jobs does not match, the update is rejected with a VersionMismatch
    /// error, and
    /// an ErrorResponse that contains the current job execution status data is
    /// returned. (This
    /// makes it unnecessary to perform a separate DescribeJobExecution request in
    /// order to
    /// obtain the job execution status data.)
    expected_version: ?i64 = null,

    /// (Optional) If `true` the job execution will be canceled if it has status
    /// IN_PROGRESS or QUEUED, otherwise the job execution will be canceled only if
    /// it has
    /// status QUEUED. If you attempt to cancel a job execution that is IN_PROGRESS,
    /// and you do
    /// not set `force` to `true`, then an
    /// `InvalidStateTransitionException` will be thrown. The default is
    /// `false`.
    ///
    /// Canceling a job execution which is "IN_PROGRESS", will cause the device to
    /// be
    /// unable to update the job execution status. Use caution and ensure that the
    /// device is
    /// able to recover to a valid state.
    force: ?bool = null,

    /// The ID of the job to be canceled.
    job_id: []const u8,

    /// A collection of name/value pairs that describe the status of the job
    /// execution. If
    /// not specified, the statusDetails are unchanged. You can specify at most 10
    /// name/value
    /// pairs.
    status_details: ?[]const aws.map.StringMapEntry = null,

    /// The name of the thing whose execution of the job will be canceled.
    thing_name: []const u8,

    pub const json_field_names = .{
        .expected_version = "expectedVersion",
        .force = "force",
        .job_id = "jobId",
        .status_details = "statusDetails",
        .thing_name = "thingName",
    };
};

pub const CancelJobExecutionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelJobExecutionInput, options: CallOptions) !CancelJobExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelJobExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
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

    if (input.expected_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expectedVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"statusDetails\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelJobExecutionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CancelJobExecutionOutput = .{};

    return result;
}
