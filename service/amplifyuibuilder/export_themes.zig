const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Theme = @import("theme.zig").Theme;

pub const ExportThemesInput = struct {
    /// The unique ID of the Amplify app to export the themes to.
    app_id: []const u8,

    /// The name of the backend environment that is part of the Amplify app.
    environment_name: []const u8,

    /// The token to request the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .environment_name = "environmentName",
        .next_token = "nextToken",
    };
};

pub const ExportThemesOutput = struct {
    /// Represents the configuration of the exported themes.
    entities: ?[]const Theme = null,

    /// The pagination token that's included if more results are available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entities = "entities",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportThemesInput, options: CallOptions) !ExportThemesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplifyuibuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportThemesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplifyuibuilder", "AmplifyUIBuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/export/app/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/environment/");
    try path_buf.appendSlice(allocator, input.environment_name);
    try path_buf.appendSlice(allocator, "/themes");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportThemesOutput {
    var result: ExportThemesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ExportThemesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
