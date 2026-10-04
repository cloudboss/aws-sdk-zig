const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobExecution = @import("job_execution.zig").JobExecution;

pub const DescribeJobExecutionInput = struct {
    /// A string (consisting of the digits "0" through "9" which is used to specify
    /// a
    /// particular job execution on a particular device.
    execution_number: ?i64 = null,

    /// The unique identifier you assigned to this job when it was created.
    job_id: []const u8,

    /// The name of the thing on which the job execution is running.
    thing_name: []const u8,

    pub const json_field_names = .{
        .execution_number = "executionNumber",
        .job_id = "jobId",
        .thing_name = "thingName",
    };
};

pub const DescribeJobExecutionOutput = struct {
    /// Information about the job execution.
    execution: ?JobExecution = null,

    pub const json_field_names = .{
        .execution = "execution",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeJobExecutionInput, options: CallOptions) !DescribeJobExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeJobExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.execution_number) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "executionNumber=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeJobExecutionOutput {
    var result: DescribeJobExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeJobExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
