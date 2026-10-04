const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LibraryItemMember = @import("library_item_member.zig").LibraryItemMember;

pub const ListLibraryItemsInput = struct {
    /// Optional category to filter the library items by.
    category_id: ?[]const u8 = null,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The maximum number of library items to return in the response.
    limit: ?i32 = null,

    /// The token to request the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .category_id = "categoryId",
        .instance_id = "instanceId",
        .limit = "limit",
        .next_token = "nextToken",
    };
};

pub const ListLibraryItemsOutput = struct {
    /// The list of library items meeting the request criteria.
    library_items: ?[]const LibraryItemMember = null,

    /// The token to use to request the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .library_items = "libraryItems",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLibraryItemsInput, options: CallOptions) !ListLibraryItemsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLibraryItemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/catalog.list";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.category_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "categoryId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.limit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "limit=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLibraryItemsOutput {
    var result: ListLibraryItemsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListLibraryItemsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
