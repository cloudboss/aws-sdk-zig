const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const GroupingAttributeDefinition = @import("grouping_attribute_definition.zig").GroupingAttributeDefinition;

pub const ListGroupingAttributeDefinitionsInput = struct {
    /// The Amazon Web Services account ID to retrieve grouping attribute
    /// definitions for. Use this when accessing grouping configurations from a
    /// different account in cross-account monitoring scenarios.
    aws_account_id: ?[]const u8 = null,

    /// If you are using this operation in a monitoring account, specify `true` to
    /// include grouping attributes from source accounts in the returned data.
    include_linked_accounts: ?bool = null,

    /// Include this value, if it was returned by the previous operation, to get the
    /// next set of grouping attribute definitions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .include_linked_accounts = "IncludeLinkedAccounts",
        .next_token = "NextToken",
    };
};

pub const ListGroupingAttributeDefinitionsOutput = struct {
    /// An array of structures, where each structure contains information about one
    /// grouping attribute definition, including the grouping name, source keys, and
    /// default values.
    grouping_attribute_definitions: ?[]const GroupingAttributeDefinition = null,

    /// Include this value in your next use of this API to get the next set of
    /// grouping attribute definitions.
    next_token: ?[]const u8 = null,

    /// The timestamp when the grouping configuration was last updated. When used in
    /// a raw HTTP Query API, it is formatted as epoch time in seconds.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .grouping_attribute_definitions = "GroupingAttributeDefinitions",
        .next_token = "NextToken",
        .updated_at = "UpdatedAt",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGroupingAttributeDefinitionsInput, options: Options) !ListGroupingAttributeDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationsignals");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListGroupingAttributeDefinitionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationsignals", "Application Signals", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/grouping-attribute-definitions";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.aws_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "AwsAccountId=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.include_linked_accounts) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "IncludeLinkedAccounts=");
        try query_buf.appendSlice(alloc, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "NextToken=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListGroupingAttributeDefinitionsOutput {
    var result: ListGroupingAttributeDefinitionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListGroupingAttributeDefinitionsOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
