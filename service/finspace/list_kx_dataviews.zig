const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KxDataviewListEntry = @import("kx_dataview_list_entry.zig").KxDataviewListEntry;

pub const ListKxDataviewsInput = struct {
    /// The name of the database where the dataviews were created.
    database_name: []const u8,

    /// A unique identifier for the kdb environment, for which you want to retrieve
    /// a list of dataviews.
    environment_id: []const u8,

    /// The maximum number of results to return in this request.
    max_results: ?i32 = null,

    /// A token that indicates where a results page should begin.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .environment_id = "environmentId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListKxDataviewsOutput = struct {
    /// The list of kdb dataviews that are currently active for the given database.
    kx_dataviews: ?[]const KxDataviewListEntry = null,

    /// A token that indicates where a results page should begin.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .kx_dataviews = "kxDataviews",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListKxDataviewsInput, options: CallOptions) !ListKxDataviewsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListKxDataviewsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/databases/");
    try path_buf.appendSlice(allocator, input.database_name);
    try path_buf.appendSlice(allocator, "/dataviews");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListKxDataviewsOutput {
    const result: ListKxDataviewsOutput = try aws.json.parseJsonObject(
        ListKxDataviewsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
