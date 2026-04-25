const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cassandra");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListStreamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra-streams", "KeyspacesStreams", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
