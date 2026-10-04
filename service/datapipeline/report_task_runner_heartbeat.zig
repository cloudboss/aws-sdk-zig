const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ReportTaskRunnerHeartbeatInput = struct {
    /// The public DNS name of the task runner.
    hostname: ?[]const u8 = null,

    /// The ID of the task runner. This value should be unique across your AWS
    /// account. In the case of AWS Data Pipeline Task Runner
    /// launched on a resource managed by AWS Data Pipeline, the web service
    /// provides a unique identifier when it launches the application.
    /// If you have written a custom task runner, you should assign a unique
    /// identifier for the task runner.
    taskrunner_id: []const u8,

    /// The type of task the task runner is configured to accept and process. The
    /// worker group is set as a field on objects in the pipeline when they are
    /// created.
    /// You can only specify a single value for `workerGroup`. There are no wildcard
    /// values permitted in `workerGroup`; the string
    /// must be an exact, case-sensitive, match.
    worker_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .hostname = "hostname",
        .taskrunner_id = "taskrunnerId",
        .worker_group = "workerGroup",
    };
};

pub const ReportTaskRunnerHeartbeatOutput = struct {
    /// Indicates whether the calling task runner should terminate.
    terminate: ?bool = null,

    pub const json_field_names = .{
        .terminate = "terminate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReportTaskRunnerHeartbeatInput, options: CallOptions) !ReportTaskRunnerHeartbeatOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datapipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ReportTaskRunnerHeartbeatInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.ReportTaskRunnerHeartbeat");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReportTaskRunnerHeartbeatOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ReportTaskRunnerHeartbeatOutput, body, allocator);
}
