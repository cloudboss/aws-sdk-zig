const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const RegisterOidcConfigTestInput = struct {
    /// The CA certificate for secure communication with the OIDC provider
    /// (optional).
    certificate: ?[]const u8 = null,

    /// Additional authentication parameters to include in the test (optional).
    extra_auth_params: ?[]const u8 = null,

    /// The issuer URL of the OIDC provider to test.
    issuer: []const u8,

    /// The ID of the Wickr network for which the OIDC configuration will be tested.
    network_id: []const u8,

    /// The OAuth scopes to test with the OIDC provider.
    scopes: []const u8,

    pub const json_field_names = .{
        .certificate = "certificate",
        .extra_auth_params = "extraAuthParams",
        .issuer = "issuer",
        .network_id = "networkId",
        .scopes = "scopes",
    };
};

pub const RegisterOidcConfigTestOutput = struct {
    /// The authorization endpoint URL discovered from the OIDC provider.
    authorization_endpoint: ?[]const u8 = null,

    /// The end session endpoint URL for logging out users from the OIDC provider.
    end_session_endpoint: ?[]const u8 = null,

    /// The OAuth grant types supported by the OIDC provider.
    grant_types_supported: ?[]const []const u8 = null,

    /// The issuer URL confirmed by the OIDC provider.
    issuer: ?[]const u8 = null,

    /// The logout endpoint URL for terminating user sessions.
    logout_endpoint: ?[]const u8 = null,

    /// Indicates whether the provider supports Microsoft multi-refresh tokens.
    microsoft_multi_refresh_token: ?bool = null,

    /// The OAuth response types supported by the OIDC provider.
    response_types_supported: ?[]const []const u8 = null,

    /// The token revocation endpoint URL for invalidating tokens.
    revocation_endpoint: ?[]const u8 = null,

    /// The OAuth scopes supported by the OIDC provider.
    scopes_supported: ?[]const []const u8 = null,

    /// The token endpoint URL discovered from the OIDC provider.
    token_endpoint: ?[]const u8 = null,

    /// The authentication methods supported by the token endpoint.
    token_endpoint_auth_methods_supported: ?[]const []const u8 = null,

    /// The user info endpoint URL discovered from the OIDC provider.
    userinfo_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_endpoint = "authorizationEndpoint",
        .end_session_endpoint = "endSessionEndpoint",
        .grant_types_supported = "grantTypesSupported",
        .issuer = "issuer",
        .logout_endpoint = "logoutEndpoint",
        .microsoft_multi_refresh_token = "microsoftMultiRefreshToken",
        .response_types_supported = "responseTypesSupported",
        .revocation_endpoint = "revocationEndpoint",
        .scopes_supported = "scopesSupported",
        .token_endpoint = "tokenEndpoint",
        .token_endpoint_auth_methods_supported = "tokenEndpointAuthMethodsSupported",
        .userinfo_endpoint = "userinfoEndpoint",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterOidcConfigTestInput, options: Options) !RegisterOidcConfigTestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "wickr");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: RegisterOidcConfigTestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wickr", "Wickr", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/networks/");
    try path_buf.appendSlice(alloc, input.network_id);
    try path_buf.appendSlice(alloc, "/oidc/test");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.certificate) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"certificate\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.extra_auth_params) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"extraAuthParams\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"issuer\":");
    try aws.json.writeValue(@TypeOf(input.issuer), input.issuer, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"scopes\":");
    try aws.json.writeValue(@TypeOf(input.scopes), input.scopes, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RegisterOidcConfigTestOutput {
    var result: RegisterOidcConfigTestOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterOidcConfigTestOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestError")) {
        return .{ .arena = arena, .kind = .{ .bad_request_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenError")) {
        return .{ .arena = arena, .kind = .{ .forbidden_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RateLimitError")) {
        return .{ .arena = arena, .kind = .{ .rate_limit_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundError")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedError")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationError")) {
        return .{ .arena = arena, .kind = .{ .validation_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
