const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLibraryItemInput, options: CallOptions) !UpdateLibraryItemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLibraryItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/catalog.updateItem";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.categories) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"categories\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"libraryItemId\":");
    try aws.json.writeValue(@TypeOf(input.library_item_id), input.library_item_id, allocator, &body_buf);
    has_prev = true;
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLibraryItemOutput {
    const result: UpdateLibraryItemOutput = try aws.json.parseJsonObject(
        UpdateLibraryItemOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
