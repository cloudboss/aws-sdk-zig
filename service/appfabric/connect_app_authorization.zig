const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthRequest = @import("auth_request.zig").AuthRequest;
const AppAuthorizationSummary = @import("app_authorization_summary.zig").AppAuthorizationSummary;

pub const ConnectAppAuthorizationInput = struct {
    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// app
    /// authorization to use for the request.
    app_authorization_identifier: []const u8,

    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// app bundle
    /// that contains the app authorization to use for the request.
    app_bundle_identifier: []const u8,

    /// Contains OAuth2 authorization information.
    ///
    /// This is required if the app authorization for the request is configured with
    /// an OAuth2
    /// (`oauth2`) authorization type.
    auth_request: ?AuthRequest = null,

    pub const json_field_names = .{
        .app_authorization_identifier = "appAuthorizationIdentifier",
        .app_bundle_identifier = "appBundleIdentifier",
        .auth_request = "authRequest",
    };
};

pub const ConnectAppAuthorizationOutput = struct {
    /// Contains a summary of the app authorization.
    app_authorization_summary: ?AppAuthorizationSummary = null,

    pub const json_field_names = .{
        .app_authorization_summary = "appAuthorizationSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConnectAppAuthorizationInput, options: CallOptions) !ConnectAppAuthorizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ConnectAppAuthorizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appfabric", "AppFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/appbundles/");
    try path_buf.appendSlice(allocator, input.app_bundle_identifier);
    try path_buf.appendSlice(allocator, "/appauthorizations/");
    try path_buf.appendSlice(allocator, input.app_authorization_identifier);
    try path_buf.appendSlice(allocator, "/connect");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auth_request) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authRequest\":");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ConnectAppAuthorizationOutput {
    const result: ConnectAppAuthorizationOutput = try aws.json.parseJsonObject(
        ConnectAppAuthorizationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
