const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListedHostKey = @import("listed_host_key.zig").ListedHostKey;

pub const ListHostKeysInput = struct {
    /// The maximum number of items to return.
    max_results: ?i32 = null,

    /// When there are additional results that were not returned, a `NextToken`
    /// parameter is returned. You can use that value for a subsequent call to
    /// `ListHostKeys` to continue listing results.
    next_token: ?[]const u8 = null,

    /// The identifier of the server that contains the host keys that you want to
    /// view.
    server_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .server_id = "ServerId",
    };
};

pub const ListHostKeysOutput = struct {
    /// Returns an array, where each item contains the details of a host key.
    host_keys: ?[]const ListedHostKey = null,

    /// Returns a token that you can use to call `ListHostKeys` again and receive
    /// additional results, if there are any.
    next_token: ?[]const u8 = null,

    /// Returns the server identifier that contains the listed host keys.
    server_id: []const u8,

    pub const json_field_names = .{
        .host_keys = "HostKeys",
        .next_token = "NextToken",
        .server_id = "ServerId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHostKeysInput, options: CallOptions) !ListHostKeysOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHostKeysInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.ListHostKeys");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHostKeysOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListHostKeysOutput, body, allocator);
}
