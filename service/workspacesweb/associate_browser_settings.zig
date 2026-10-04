const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateBrowserSettingsInput = struct {
    /// The ARN of the browser settings.
    browser_settings_arn: []const u8,

    /// The ARN of the web portal.
    portal_arn: []const u8,

    pub const json_field_names = .{
        .browser_settings_arn = "browserSettingsArn",
        .portal_arn = "portalArn",
    };
};

pub const AssociateBrowserSettingsOutput = struct {
    /// The ARN of the browser settings.
    browser_settings_arn: []const u8,

    /// The ARN of the web portal.
    portal_arn: []const u8,

    pub const json_field_names = .{
        .browser_settings_arn = "browserSettingsArn",
        .portal_arn = "portalArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateBrowserSettingsInput, options: CallOptions) !AssociateBrowserSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-web", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateBrowserSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-web", "WorkSpaces Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/portals/");
    try path_buf.appendSlice(allocator, input.portal_arn);
    try path_buf.appendSlice(allocator, "/browserSettings");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "browserSettingsArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.browser_settings_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateBrowserSettingsOutput {
    const result: AssociateBrowserSettingsOutput = try aws.json.parseJsonObject(
        AssociateBrowserSettingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
