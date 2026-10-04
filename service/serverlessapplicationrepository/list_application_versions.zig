const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VersionSummary = @import("version_summary.zig").VersionSummary;

pub const ListApplicationVersionsInput = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_id: []const u8,

    /// The total number of items to return.
    max_items: ?i32 = null,

    /// A token to specify where to start paginating.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .max_items = "MaxItems",
        .next_token = "NextToken",
    };
};

pub const ListApplicationVersionsOutput = struct {
    /// The token to request the next page of results.
    next_token: ?[]const u8 = null,

    /// An array of version summaries for the application.
    versions: ?[]const VersionSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .versions = "Versions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListApplicationVersionsInput, options: CallOptions) !ListApplicationVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "serverlessrepo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListApplicationVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("serverlessrepo", "ServerlessApplicationRepository", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxItems=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListApplicationVersionsOutput {
    var result: ListApplicationVersionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListApplicationVersionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
