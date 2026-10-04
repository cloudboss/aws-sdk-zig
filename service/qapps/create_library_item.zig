const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateLibraryItemInput = struct {
    /// The unique identifier of the Amazon Q App to publish to the library.
    app_id: []const u8,

    /// The version of the Amazon Q App to publish to the library.
    app_version: i32,

    /// The categories to associate with the library item for easier discovery.
    categories: []const []const u8,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .app_version = "appVersion",
        .categories = "categories",
        .instance_id = "instanceId",
    };
};

pub const CreateLibraryItemOutput = struct {
    /// The date and time the library item was created.
    created_at: i64,

    /// The user who created the library item.
    created_by: []const u8,

    /// Indicates whether the library item has been verified.
    is_verified: ?bool = null,

    /// The unique identifier of the new library item.
    library_item_id: []const u8,

    /// The number of ratings the library item has received from users.
    rating_count: i32,

    /// The status of the new library item, such as "Published".
    status: []const u8,

    /// The date and time the library item was last updated.
    updated_at: ?i64 = null,

    /// The user who last updated the library item.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .is_verified = "isVerified",
        .library_item_id = "libraryItemId",
        .rating_count = "ratingCount",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLibraryItemInput, options: CallOptions) !CreateLibraryItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLibraryItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/catalog.createItem";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appId\":");
    try aws.json.writeValue(@TypeOf(input.app_id), input.app_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appVersion\":");
    try aws.json.writeValue(@TypeOf(input.app_version), input.app_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"categories\":");
    try aws.json.writeValue(@TypeOf(input.categories), input.categories, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLibraryItemOutput {
    var result: CreateLibraryItemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateLibraryItemOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
