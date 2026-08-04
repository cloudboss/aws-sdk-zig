const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const eventScopeCode = @import("event_scope_code.zig").eventScopeCode;

pub const DescribeAffectedAccountsForOrganizationInput = struct {
    /// The unique identifier for the event. The event ARN has the
    /// `arn:aws:health:*event-region*::event/*SERVICE*/*EVENT_TYPE_CODE*/*EVENT_TYPE_PLUS_ID*
    /// `
    /// format.
    ///
    /// For example, an event ARN might look like the following:
    ///
    /// `arn:aws:health:us-east-1::event/EC2/EC2_INSTANCE_RETIREMENT_SCHEDULED/EC2_INSTANCE_RETIREMENT_SCHEDULED_ABC123-DEF456`
    event_arn: []const u8,

    /// The maximum number of items to return in one batch, between 10 and 100,
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
        .event_arn = "eventArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeAffectedAccountsForOrganizationOutput = struct {
    /// A JSON set of elements of the affected accounts.
    affected_accounts: ?[]const []const u8 = null,

    /// This parameter specifies if the Health event is a public Amazon Web Services
    /// service event or an account-specific event.
    ///
    /// * If the `eventScopeCode` value is `PUBLIC`, then the
    /// `affectedAccounts` value is always empty.
    ///
    /// * If the `eventScopeCode` value is `ACCOUNT_SPECIFIC`, then
    /// the `affectedAccounts` value lists the affected Amazon Web Services accounts
    /// in your
    /// organization. For example, if an event affects a service such as Amazon
    /// Elastic Compute Cloud and you
    /// have Amazon Web Services accounts that use that service, those account IDs
    /// appear in the
    /// response.
    ///
    /// * If the `eventScopeCode` value is `NONE`, then the
    /// `eventArn` that you specified in the request is invalid or doesn't
    /// exist.
    event_scope_code: ?eventScopeCode = null,

    /// If the results of a search are large, only a portion of the
    /// results are returned, and a `nextToken` pagination token is returned in the
    /// response. To
    /// retrieve the next batch of results, reissue the search request and include
    /// the returned token.
    /// When all results have been returned, the response does not contain a
    /// pagination token value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .affected_accounts = "affectedAccounts",
        .event_scope_code = "eventScopeCode",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAffectedAccountsForOrganizationInput, options: CallOptions) !DescribeAffectedAccountsForOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAffectedAccountsForOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health", "Health", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHealth_20160804.DescribeAffectedAccountsForOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAffectedAccountsForOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAffectedAccountsForOrganizationOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.ConcurrentModificationException = aws.json.parseJsonObject(errors.ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationToken")) {
        const parsed_error: ?errors.InvalidPaginationToken = aws.json.parseJsonObject(errors.InvalidPaginationToken, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_pagination_token = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedLocale")) {
        const parsed_error: ?errors.UnsupportedLocale = aws.json.parseJsonObject(errors.UnsupportedLocale, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_locale = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
