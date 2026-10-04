const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobExecutionSummary = @import("job_execution_summary.zig").JobExecutionSummary;

pub const GetPendingJobExecutionsInput = struct {
    /// The name of the thing that is executing the job.
    thing_name: []const u8,

    pub const json_field_names = .{
        .thing_name = "thingName",
    };
};

pub const GetPendingJobExecutionsOutput = struct {
    /// A list of JobExecutionSummary objects with status IN_PROGRESS.
    in_progress_jobs: ?[]const JobExecutionSummary = null,

    /// A list of JobExecutionSummary objects with status QUEUED.
    queued_jobs: ?[]const JobExecutionSummary = null,

    pub const json_field_names = .{
        .in_progress_jobs = "inProgressJobs",
        .queued_jobs = "queuedJobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPendingJobExecutionsInput, options: CallOptions) !GetPendingJobExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot-jobs-data", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPendingJobExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.jobs.iot", "IoT Jobs Data Plane", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPendingJobExecutionsOutput {
    var result: GetPendingJobExecutionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPendingJobExecutionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
