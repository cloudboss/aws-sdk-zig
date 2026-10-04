const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KeyspaceSummary = @import("keyspace_summary.zig").KeyspaceSummary;

pub const ListKeyspacesInput = struct {
    /// The total number of keyspaces to return in the output. If the total number
    /// of keyspaces available is more than the value specified, a `NextToken` is
    /// provided in the output. To resume pagination, provide the `NextToken` value
    /// as an argument of a subsequent API invocation.
    max_results: ?i32 = null,

    /// The pagination token. To resume pagination, provide the `NextToken` value as
    /// argument of a subsequent API invocation.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListKeyspacesOutput = struct {
    /// A list of keyspaces.
    keyspaces: ?[]const KeyspaceSummary = null,

    /// A token to specify where to start paginating. This is the `NextToken` from a
    /// previously truncated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .keyspaces = "keyspaces",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListKeyspacesInput, options: CallOptions) !ListKeyspacesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cassandra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListKeyspacesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra", "Keyspaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesService.ListKeyspaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListKeyspacesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListKeyspacesOutput, body, allocator);
}
