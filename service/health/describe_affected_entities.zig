const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EntityFilter = @import("entity_filter.zig").EntityFilter;
const AffectedEntity = @import("affected_entity.zig").AffectedEntity;

pub const DescribeAffectedEntitiesInput = struct {
    /// Values to narrow the results returned. At least one event ARN is required.
    filter: EntityFilter,

    /// The locale (language) to return information in. English (en) is the default
    /// and the only supported value at this time.
    locale: ?[]const u8 = null,

    /// The maximum number of items to return in one batch, between 1 and 100,
    /// inclusive.
    max_results: ?i32 = null,

    /// If the results of a search are large, only a portion of the
    /// results are returned, and a `nextToken` pagination token is returned in the
    /// response. To
    /// retrieve the next batch of results, reissue the search request and include
    /// the returned token.
    /// When all results have been returned, the response does not contain a
    /// pagination token value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeAffectedEntitiesOutput = struct {
    /// The entities that match the filter criteria.
    entities: ?[]const AffectedEntity = null,

    /// If the results of a search are large, only a portion of the
    /// results are returned, and a `nextToken` pagination token is returned in the
    /// response. To
    /// retrieve the next batch of results, reissue the search request and include
    /// the returned token.
    /// When all results have been returned, the response does not contain a
    /// pagination token value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entities = "entities",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAffectedEntitiesInput, options: CallOptions) !DescribeAffectedEntitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "health");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAffectedEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health", "Health", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHealth_20160804.DescribeAffectedEntities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAffectedEntitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAffectedEntitiesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedLocale")) {
        return .{ .arena = arena, .kind = .{ .unsupported_locale = .{
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
