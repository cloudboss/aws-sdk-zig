const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LibraryItemStatus = @import("library_item_status.zig").LibraryItemStatus;
const Category = @import("category.zig").Category;

pub const UpdateLibraryItemInput = struct {
    /// The new categories to associate with the library item.
    categories: ?[]const []const u8 = null,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The unique identifier of the library item to update.
    library_item_id: []const u8,

    /// The new status to set for the library item, such as "Published" or "Hidden".
    status: ?LibraryItemStatus = null,

    pub const json_field_names = .{
        .categories = "categories",
        .instance_id = "instanceId",
        .library_item_id = "libraryItemId",
        .status = "status",
    };
};

pub const UpdateLibraryItemOutput = struct {
    /// The unique identifier of the Q App associated with the library item.
    app_id: []const u8,

    /// The version of the Q App associated with the library item.
    app_version: i32,

    /// The categories associated with the updated library item.
    categories: ?[]const Category = null,

    /// The date and time the library item was originally created.
    created_at: i64,

    /// The user who originally created the library item.
    created_by: []const u8,

    /// Whether the current user has rated the library item.
    is_rated_by_user: ?bool = null,

    /// Indicates whether the library item has been verified.
    is_verified: ?bool = null,

    /// The unique identifier of the updated library item.
    library_item_id: []const u8,

    /// The number of ratings the library item has received.
    rating_count: i32,

    /// The new status of the updated library item.
    status: []const u8,

    /// The date and time the library item was last updated.
    updated_at: ?i64 = null,

    /// The user who last updated the library item.
    updated_by: ?[]const u8 = null,

    /// The number of users who have the associated Q App.
    user_count: ?i32 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_version = "appVersion",
        .categories = "categories",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .is_rated_by_user = "isRatedByUser",
        .is_verified = "isVerified",
        .library_item_id = "libraryItemId",
        .rating_count = "ratingCount",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .user_count = "userCount",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLibraryItemInput, options: Options) !UpdateLibraryItemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "qapps");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateLibraryItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qapps", "QApps", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/catalog.updateItem";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.categories) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"categories\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"libraryItemId\":");
    try aws.json.writeValue(@TypeOf(input.library_item_id), input.library_item_id, alloc, &body_buf);
    has_prev = true;
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    try request.headers.put(alloc, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateLibraryItemOutput {
    var result: UpdateLibraryItemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateLibraryItemOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ContentTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .content_too_large_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
