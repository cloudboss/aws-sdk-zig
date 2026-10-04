const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListedAccess = @import("listed_access.zig").ListedAccess;

pub const ListAccessesInput = struct {
    /// The maximum number of items to return.
    max_results: ?i32 = null,

    /// When you can get additional results from the `ListAccesses` call, a
    /// `NextToken` parameter is returned in the output. You can then pass in a
    /// subsequent command to the `NextToken` parameter to continue listing
    /// additional accesses.
    next_token: ?[]const u8 = null,

    /// A system-assigned unique identifier for a server that has users assigned to
    /// it.
    server_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .server_id = "ServerId",
    };
};

pub const ListAccessesOutput = struct {
    /// Returns the accesses and their properties for the `ServerId` value that you
    /// specify.
    accesses: ?[]const ListedAccess = null,

    /// When you can get additional results from the `ListAccesses` call, a
    /// `NextToken` parameter is returned in the output. You can then pass in a
    /// subsequent command to the `NextToken` parameter to continue listing
    /// additional accesses.
    next_token: ?[]const u8 = null,

    /// A system-assigned unique identifier for a server that has users assigned to
    /// it.
    server_id: []const u8,

    pub const json_field_names = .{
        .accesses = "Accesses",
        .next_token = "NextToken",
        .server_id = "ServerId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccessesInput, options: CallOptions) !ListAccessesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccessesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ListAccesses");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccessesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListAccessesOutput, body, allocator);
}
