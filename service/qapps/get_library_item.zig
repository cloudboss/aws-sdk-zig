const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Category = @import("category.zig").Category;

pub const GetLibraryItemInput = struct {
    /// The unique identifier of the Amazon Q App associated with the library item.
    app_id: ?[]const u8 = null,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The unique identifier of the library item to retrieve.
    library_item_id: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .instance_id = "instanceId",
        .library_item_id = "libraryItemId",
    };
};

pub const GetLibraryItemOutput = struct {
    /// The unique identifier of the Q App associated with the library item.
    app_id: []const u8,

    /// The version of the Q App associated with the library item.
    app_version: i32,

    /// The categories associated with the library item for discovery.
    categories: ?[]const Category = null,

    /// The date and time the library item was created.
    created_at: i64,

    /// The user who created the library item.
    created_by: []const u8,

    /// Whether the current user has rated the library item.
    is_rated_by_user: ?bool = null,

    /// Indicates whether the library item has been verified.
    is_verified: ?bool = null,

    /// The unique identifier of the library item.
    library_item_id: []const u8,

    /// The number of ratings the library item has received from users.
    rating_count: i32,

    /// The status of the library item, such as "Published".
    status: []const u8,

    /// The date and time the library item was last updated.
    updated_at: ?i64 = null,

    /// The user who last updated the library item.
    updated_by: ?[]const u8 = null,

    /// The number of users who have associated the Q App with their account.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLibraryItemInput, options: CallOptions) !GetLibraryItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLibraryItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/catalog.getItem";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.app_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "appId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "libraryItemId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.library_item_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLibraryItemOutput {
    var result: GetLibraryItemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetLibraryItemOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
