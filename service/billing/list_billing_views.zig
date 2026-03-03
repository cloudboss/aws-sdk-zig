const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ActiveTimeRange = @import("active_time_range.zig").ActiveTimeRange;
const BillingViewType = @import("billing_view_type.zig").BillingViewType;
const StringSearch = @import("string_search.zig").StringSearch;
const BillingViewListElement = @import("billing_view_list_element.zig").BillingViewListElement;

pub const ListBillingViewsInput = struct {
    /// The time range for the billing views listed. `PRIMARY` billing view is
    /// always listed. `BILLING_GROUP` billing views are listed for time ranges when
    /// the associated billing group resource in Billing Conductor is active. The
    /// time range must be within one calendar month.
    active_time_range: ?ActiveTimeRange = null,

    /// The Amazon Resource Name (ARN) that can be used to uniquely identify the
    /// billing view.
    arns: ?[]const []const u8 = null,

    /// The type of billing view.
    billing_view_types: ?[]const BillingViewType = null,

    /// The maximum number of billing views to retrieve. Default is 100.
    max_results: ?i32 = null,

    /// Filters the list of billing views by name. You can specify search criteria
    /// to match billing view names based on the search option provided.
    names: ?[]const StringSearch = null,

    /// The pagination token that is used on subsequent calls to list billing views.
    next_token: ?[]const u8 = null,

    /// The list of owners of the billing view.
    owner_account_id: ?[]const u8 = null,

    /// Filters the results to include only billing views that use the specified
    /// account as a source.
    source_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_time_range = "activeTimeRange",
        .arns = "arns",
        .billing_view_types = "billingViewTypes",
        .max_results = "maxResults",
        .names = "names",
        .next_token = "nextToken",
        .owner_account_id = "ownerAccountId",
        .source_account_id = "sourceAccountId",
    };
};

pub const ListBillingViewsOutput = struct {
    /// A list of `BillingViewListElement` retrieved.
    billing_views: ?[]const BillingViewListElement = null,

    /// The pagination token to use on subsequent calls to list billing views.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_views = "billingViews",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBillingViewsInput, options: CallOptions) !ListBillingViewsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "billing");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBillingViewsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billing", "Billing", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBilling.ListBillingViews");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBillingViewsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListBillingViewsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "BillingViewHealthStatusException")) {
        return .{ .arena = arena, .kind = .{ .billing_view_health_status_exception = .{
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
