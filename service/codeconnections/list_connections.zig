const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderType = @import("provider_type.zig").ProviderType;
const Connection = @import("connection.zig").Connection;

pub const ListConnectionsInput = struct {
    /// Filters the list of connections to those associated with a specified host.
    host_arn_filter: ?[]const u8 = null,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned `nextToken` value.
    max_results: ?i32 = null,

    /// The token that was returned from the previous `ListConnections` call, which
    /// can be used to return the next set of connections in the list.
    next_token: ?[]const u8 = null,

    /// Filters the list of connections to those associated with a specified
    /// provider, such as
    /// Bitbucket.
    provider_type_filter: ?ProviderType = null,

    pub const json_field_names = .{
        .host_arn_filter = "HostArnFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .provider_type_filter = "ProviderTypeFilter",
    };
};

pub const ListConnectionsOutput = struct {
    /// A list of connections and the details for each connection, such as status,
    /// owner, and
    /// provider type.
    connections: ?[]const Connection = null,

    /// A token that can be used in the next `ListConnections` call. To view all
    /// items in the list, continue to call this operation with each subsequent
    /// token until no more
    /// `nextToken` values are returned.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connections = "Connections",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectionsInput, options: CallOptions) !ListConnectionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeconnections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeconnections", "CodeConnections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.ListConnections");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListConnectionsOutput, body, allocator);
}
