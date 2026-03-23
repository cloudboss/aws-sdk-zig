const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EndpointDisplayContentResponse = @import("endpoint_display_content_response.zig").EndpointDisplayContentResponse;
const RestEndpointIdentifier = @import("rest_endpoint_identifier.zig").RestEndpointIdentifier;
const Status = @import("status.zig").Status;
const StatusException = @import("status_exception.zig").StatusException;
const TryItState = @import("try_it_state.zig").TryItState;

pub const GetProductRestEndpointPageInput = struct {
    /// The query parameter to include raw display content.
    include_raw_display_content: ?[]const u8 = null,

    /// The portal product identifier.
    portal_product_id: []const u8,

    /// The product REST endpoint identifier.
    product_rest_endpoint_page_id: []const u8,

    /// The account ID of the resource owner of the portal product.
    resource_owner_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_raw_display_content = "IncludeRawDisplayContent",
        .portal_product_id = "PortalProductId",
        .product_rest_endpoint_page_id = "ProductRestEndpointPageId",
        .resource_owner_account_id = "ResourceOwnerAccountId",
    };
};

pub const GetProductRestEndpointPageOutput = struct {
    /// The content of the product REST endpoint page.
    display_content: ?EndpointDisplayContentResponse = null,

    /// The timestamp when the product REST endpoint page was last modified.
    last_modified: ?i64 = null,

    /// The ARN of the product REST endpoint page.
    product_rest_endpoint_page_arn: ?[]const u8 = null,

    /// The product REST endpoint page identifier.
    product_rest_endpoint_page_id: ?[]const u8 = null,

    /// The raw display content of the product REST endpoint page.
    raw_display_content: ?[]const u8 = null,

    /// The REST endpoint identifier.
    rest_endpoint_identifier: ?RestEndpointIdentifier = null,

    /// The status of the product REST endpoint page.
    status: ?Status = null,

    /// The status exception information.
    status_exception: ?StatusException = null,

    /// The try it state.
    try_it_state: ?TryItState = null,

    pub const json_field_names = .{
        .display_content = "DisplayContent",
        .last_modified = "LastModified",
        .product_rest_endpoint_page_arn = "ProductRestEndpointPageArn",
        .product_rest_endpoint_page_id = "ProductRestEndpointPageId",
        .raw_display_content = "RawDisplayContent",
        .rest_endpoint_identifier = "RestEndpointIdentifier",
        .status = "Status",
        .status_exception = "StatusException",
        .try_it_state = "TryItState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProductRestEndpointPageInput, options: CallOptions) !GetProductRestEndpointPageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProductRestEndpointPageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/portalproducts/");
    try path_buf.appendSlice(allocator, input.portal_product_id);
    try path_buf.appendSlice(allocator, "/productrestendpointpages/");
    try path_buf.appendSlice(allocator, input.product_rest_endpoint_page_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.include_raw_display_content) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeRawDisplayContent=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.resource_owner_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "resourceOwnerAccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProductRestEndpointPageOutput {
    var result: GetProductRestEndpointPageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetProductRestEndpointPageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
