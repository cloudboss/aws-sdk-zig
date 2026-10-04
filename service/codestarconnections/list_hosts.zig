const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Host = @import("host.zig").Host;

pub const ListHostsInput = struct {
    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned `nextToken` value.
    max_results: ?i32 = null,

    /// The token that was returned from the previous `ListHosts` call, which can be
    /// used to return the next set of hosts in the list.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListHostsOutput = struct {
    /// A list of hosts and the details for each host, such as status, endpoint, and
    /// provider
    /// type.
    hosts: ?[]const Host = null,

    /// A token that can be used in the next `ListHosts` call. To view all items in
    /// the
    /// list, continue to call this operation with each subsequent token until no
    /// more
    /// `nextToken` values are returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .hosts = "Hosts",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListHostsInput, options: CallOptions) !ListHostsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codestar-connections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListHostsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-connections", "CodeStar connections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeStar_connections_20191201.ListHosts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListHostsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListHostsOutput, body, allocator);
}
