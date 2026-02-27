const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChangeSummary = @import("change_summary.zig").ChangeSummary;
const FailureCode = @import("failure_code.zig").FailureCode;
const Intent = @import("intent.zig").Intent;
const ChangeStatus = @import("change_status.zig").ChangeStatus;

pub const DescribeChangeSetInput = struct {
    /// Required. The catalog related to the request. Fixed value:
    /// `AWSMarketplace`
    catalog: []const u8,

    /// Required. The unique identifier for the `StartChangeSet` request that you
    /// want to describe the details for.
    change_set_id: []const u8,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .change_set_id = "ChangeSetId",
    };
};

pub const DescribeChangeSetOutput = struct {
    /// An array of `ChangeSummary` objects.
    change_set: ?[]const ChangeSummary = null,

    /// The ARN associated with the unique identifier for the change set referenced
    /// in this
    /// request.
    change_set_arn: ?[]const u8 = null,

    /// Required. The unique identifier for the change set referenced in this
    /// request.
    change_set_id: ?[]const u8 = null,

    /// The optional name provided in the `StartChangeSet` request. If you do not
    /// provide a name, one is set by default.
    change_set_name: ?[]const u8 = null,

    /// The date and time, in ISO 8601 format (2018-02-27T13:45:22Z), the request
    /// transitioned
    /// to a terminal state. The change cannot transition to a different state. Null
    /// if the
    /// request is not in a terminal state.
    end_time: ?[]const u8 = null,

    /// Returned if the change set is in `FAILED` status. Can be either
    /// `CLIENT_ERROR`, which means that there are issues with the request (see
    /// the `ErrorDetailList`), or `SERVER_FAULT`, which means that there
    /// is a problem in the system, and you should retry your request.
    failure_code: ?FailureCode = null,

    /// Returned if there is a failure on the change set, but that failure is not
    /// related to
    /// any of the changes in the request.
    failure_description: ?[]const u8 = null,

    /// The optional intent provided in the `StartChangeSet` request. If you do not
    /// provide an intent, `APPLY` is set by default.
    intent: ?Intent = null,

    /// The date and time, in ISO 8601 format (2018-02-27T13:45:22Z), the request
    /// started.
    start_time: ?[]const u8 = null,

    /// The status of the change request.
    status: ?ChangeStatus = null,

    pub const json_field_names = .{
        .change_set = "ChangeSet",
        .change_set_arn = "ChangeSetArn",
        .change_set_id = "ChangeSetId",
        .change_set_name = "ChangeSetName",
        .end_time = "EndTime",
        .failure_code = "FailureCode",
        .failure_description = "FailureDescription",
        .intent = "Intent",
        .start_time = "StartTime",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChangeSetInput, options: Options) !DescribeChangeSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "marketplacecatalog");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("marketplacecatalog", "Marketplace Catalog", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/DescribeChangeSet";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "catalog=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.catalog);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "changeSetId=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.change_set_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeChangeSetOutput {
    var result: DescribeChangeSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeChangeSetOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_supported_exception = .{
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
