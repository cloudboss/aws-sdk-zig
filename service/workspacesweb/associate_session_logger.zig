const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateSessionLoggerInput = struct {
    /// The ARN of the portal to associate to the session logger ARN.
    portal_arn: []const u8,

    /// The ARN of the session logger to associate to the portal ARN.
    session_logger_arn: []const u8,

    pub const json_field_names = .{
        .portal_arn = "portalArn",
        .session_logger_arn = "sessionLoggerArn",
    };
};

pub const AssociateSessionLoggerOutput = struct {
    /// The ARN of the portal.
    portal_arn: []const u8,

    /// The ARN of the session logger.
    session_logger_arn: []const u8,

    pub const json_field_names = .{
        .portal_arn = "portalArn",
        .session_logger_arn = "sessionLoggerArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateSessionLoggerInput, options: CallOptions) !AssociateSessionLoggerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateSessionLoggerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-web", "WorkSpaces Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/portals/");
    try path_buf.appendSlice(allocator, input.portal_arn);
    try path_buf.appendSlice(allocator, "/sessionLogger");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "sessionLoggerArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.session_logger_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateSessionLoggerOutput {
    const result: AssociateSessionLoggerOutput = try aws.json.parseJsonObject(
        AssociateSessionLoggerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
