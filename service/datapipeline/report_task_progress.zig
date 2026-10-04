const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Field = @import("field.zig").Field;

pub const ReportTaskProgressInput = struct {
    /// Key-value pairs that define the properties of the ReportTaskProgressInput
    /// object.
    fields: ?[]const Field = null,

    /// The ID of the task assigned to the task runner. This value is provided in
    /// the response for PollForTask.
    task_id: []const u8,

    pub const json_field_names = .{
        .fields = "fields",
        .task_id = "taskId",
    };
};

pub const ReportTaskProgressOutput = struct {
    /// If true, the calling task runner should cancel processing of the task. The
    /// task runner does not need to call SetTaskStatus for canceled tasks.
    canceled: ?bool = null,

    pub const json_field_names = .{
        .canceled = "canceled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReportTaskProgressInput, options: CallOptions) !ReportTaskProgressOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ReportTaskProgressInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.ReportTaskProgress");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReportTaskProgressOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ReportTaskProgressOutput, body, allocator);
}
