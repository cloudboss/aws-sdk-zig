const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParallelDataStatus = @import("parallel_data_status.zig").ParallelDataStatus;

pub const DeleteParallelDataInput = struct {
    /// The name of the parallel data resource that is being deleted.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DeleteParallelDataOutput = struct {
    /// The name of the parallel data resource that is being deleted.
    name: ?[]const u8 = null,

    /// The status of the parallel data deletion.
    status: ?ParallelDataStatus = null,

    pub const json_field_names = .{
        .name = "Name",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteParallelDataInput, options: CallOptions) !DeleteParallelDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "translate", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteParallelDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("translate", "Translate", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShineFrontendService_20170701.DeleteParallelData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteParallelDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteParallelDataOutput, body, allocator);
}
