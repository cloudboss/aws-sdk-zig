const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const RegisterClientInput = struct {
    /// The friendly name of the client.
    client_name: []const u8,

    /// The type of client. The service supports only `public` as a client type.
    /// Anything other than public will be rejected by the service.
    client_type: []const u8,

    /// This IAM Identity Center application ARN is used to define
    /// administrator-managed configuration for
    /// public client access to resources. At authorization, the scopes, grants, and
    /// redirect URI
    /// available to this client will be restricted by this application resource.
    entitled_application_arn: ?[]const u8 = null,

    /// The list of OAuth 2.0 grant types that are defined by the client. This list
    /// is used to
    /// restrict the token granting flows available to the client. Supports the
    /// following OAuth 2.0
    /// grant types: Authorization Code, Device Code, and Refresh Token.
    ///
    /// * Authorization Code - `authorization_code`
    ///
    /// * Device Code - `urn:ietf:params:oauth:grant-type:device_code`
    ///
    /// * Refresh Token - `refresh_token`
    grant_types: ?[]const []const u8 = null,

    /// The IAM Identity Center Issuer URL associated with an instance of IAM
    /// Identity Center. This value is needed for user
    /// access to resources through the client.
    issuer_url: ?[]const u8 = null,

    /// The list of redirect URI that are defined by the client. At completion of
    /// authorization,
    /// this list is used to restrict what locations the user agent can be
    /// redirected back to.
    redirect_uris: ?[]const []const u8 = null,

    /// The list of scopes that are defined by the client. Upon authorization, this
    /// list is used
    /// to restrict permissions when granting an access token.
    scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .client_name = "clientName",
        .client_type = "clientType",
        .entitled_application_arn = "entitledApplicationArn",
        .grant_types = "grantTypes",
        .issuer_url = "issuerUrl",
        .redirect_uris = "redirectUris",
        .scopes = "scopes",
    };
};

pub const RegisterClientOutput = struct {
    /// An endpoint that the client can use to request authorization.
    authorization_endpoint: ?[]const u8 = null,

    /// The unique identifier string for each client. This client uses this
    /// identifier to get
    /// authenticated by the service in subsequent calls.
    client_id: ?[]const u8 = null,

    /// Indicates the time at which the `clientId` and `clientSecret` were
    /// issued.
    client_id_issued_at: ?i64 = null,

    /// A secret string generated for the client. The client will use this string to
    /// get
    /// authenticated by the service in subsequent calls.
    client_secret: ?[]const u8 = null,

    /// Indicates the time at which the `clientId` and `clientSecret` will
    /// become invalid.
    client_secret_expires_at: ?i64 = null,

    /// An endpoint that the client can use to create tokens.
    token_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_endpoint = "authorizationEndpoint",
        .client_id = "clientId",
        .client_id_issued_at = "clientIdIssuedAt",
        .client_secret = "clientSecret",
        .client_secret_expires_at = "clientSecretExpiresAt",
        .token_endpoint = "tokenEndpoint",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterClientInput, options: CallOptions) !RegisterClientOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sso-oauth");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterClientInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("oidc", "SSO OIDC", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/client/register";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientName\":");
    try aws.json.writeValue(@TypeOf(input.client_name), input.client_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientType\":");
    try aws.json.writeValue(@TypeOf(input.client_type), input.client_type, allocator, &body_buf);
    has_prev = true;
    if (input.entitled_application_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"entitledApplicationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.grant_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"grantTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.issuer_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"issuerUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.redirect_uris) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"redirectUris\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scopes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scopes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterClientOutput {
    var result: RegisterClientOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterClientOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthorizationPendingException")) {
        return .{ .arena = arena, .kind = .{ .authorization_pending_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClientException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClientMetadataException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_metadata_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGrantException")) {
        return .{ .arena = arena, .kind = .{ .invalid_grant_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRedirectUriException")) {
        return .{ .arena = arena, .kind = .{ .invalid_redirect_uri_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestRegionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidScopeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_scope_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SlowDownException")) {
        return .{ .arena = arena, .kind = .{ .slow_down_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedGrantTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_grant_type_exception = .{
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
