const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociatedApplication = @import("associated_application.zig").AssociatedApplication;
const ServerDetail = @import("server_detail.zig").ServerDetail;

pub const GetServerDetailsInput = struct {
    /// The maximum number of items to include in the response. The maximum value is
    /// 100.
    max_results: ?i32 = null,

    /// The token from a previous call that you use to retrieve the next set of
    /// results. For example,
    /// if a previous call to this action returned 100 items, but you set
    /// `maxResults` to 10. You'll receive a set of 10 results along
    /// with a token. You then use the returned token to retrieve the next set of
    /// 10.
    next_token: ?[]const u8 = null,

    /// The ID of the server.
    server_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .server_id = "serverId",
    };
};

pub const GetServerDetailsOutput = struct {
    /// The associated application group the server belongs to, as defined in AWS
    /// Application Discovery Service.
    associated_applications: ?[]const AssociatedApplication = null,

    /// The token you use to retrieve the next set of results, or null if there are
    /// no more results.
    next_token: ?[]const u8 = null,

    /// Detailed information about the server.
    server_detail: ?ServerDetail = null,

    pub const json_field_names = .{
        .associated_applications = "associatedApplications",
        .next_token = "nextToken",
        .server_detail = "serverDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServerDetailsInput, options: CallOptions) !GetServerDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServerDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/get-server-details/");
    try path_buf.appendSlice(allocator, input.server_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServerDetailsOutput {
    var result: GetServerDetailsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetServerDetailsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
