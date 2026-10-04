const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchLoadTaskDescription = @import("batch_load_task_description.zig").BatchLoadTaskDescription;

pub const DescribeBatchLoadTaskInput = struct {
    /// The ID of the batch load task.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "TaskId",
    };
};

pub const DescribeBatchLoadTaskOutput = struct {
    /// Description of the batch load task.
    batch_load_task_description: ?BatchLoadTaskDescription = null,

    pub const json_field_names = .{
        .batch_load_task_description = "BatchLoadTaskDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBatchLoadTaskInput, options: CallOptions) !DescribeBatchLoadTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBatchLoadTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ingest.timestream", "Timestream Write", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.DescribeBatchLoadTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBatchLoadTaskOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeBatchLoadTaskOutput, body, allocator);
}
