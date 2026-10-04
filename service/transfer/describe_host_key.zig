const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribedHostKey = @import("described_host_key.zig").DescribedHostKey;

pub const DescribeHostKeyInput = struct {
    /// The identifier of the host key that you want described.
    host_key_id: []const u8,

    /// The identifier of the server that contains the host key that you want
    /// described.
    server_id: []const u8,

    pub const json_field_names = .{
        .host_key_id = "HostKeyId",
        .server_id = "ServerId",
    };
};

pub const DescribeHostKeyOutput = struct {
    /// Returns the details for the specified host key.
    host_key: ?DescribedHostKey = null,

    pub const json_field_names = .{
        .host_key = "HostKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHostKeyInput, options: CallOptions) !DescribeHostKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHostKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.DescribeHostKey");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHostKeyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeHostKeyOutput, body, allocator);
}
