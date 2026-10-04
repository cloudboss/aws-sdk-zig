const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Stream = @import("stream.zig").Stream;

pub const ListStreamsInput = struct {
    /// The name of the keyspace for which to list streams. If specified, only
    /// streams associated with tables in this keyspace are returned. If omitted,
    /// streams from all keyspaces are included in the results.
    keyspace_name: ?[]const u8 = null,

    /// The maximum number of streams to return in a single `ListStreams` request.
    /// The default value is 100. The minimum value is 1 and the maximum value is
    /// 100.
    max_results: ?i32 = null,

    /// An optional pagination token provided by a previous `ListStreams` operation.
    /// If this parameter is specified, the response includes only records beyond
    /// the token, up to the value specified by `maxResults`.
    next_token: ?[]const u8 = null,

    /// The name of the table for which to list streams. Must be used together with
    /// `keyspaceName`. If specified, only streams associated with this specific
    /// table are returned.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .keyspace_name = "keyspaceName",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .table_name = "tableName",
    };
};

pub const ListStreamsOutput = struct {
    /// A pagination token that can be used in a subsequent `ListStreams` request.
    /// This token is returned if the response contains more streams than can be
    /// returned in a single response based on the `maxResults` parameter.
    next_token: ?[]const u8 = null,

    /// An array of stream objects, each containing summary information about a
    /// stream including its ARN, status, and associated table information. This
    /// list includes all streams that match the request criteria.
    streams: ?[]const Stream = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .streams = "streams",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStreamsInput, options: CallOptions) !ListStreamsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStreamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra-streams", "KeyspacesStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesStreams.ListStreams");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStreamsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListStreamsOutput, body, allocator);
}
