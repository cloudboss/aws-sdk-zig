const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const RegisterOidcConfigInput = struct {
    /// Custom identifier your end users will use to sign in with SSO.
    company_id: []const u8,

    /// A custom field mapping to extract the username from the OIDC token
    /// (optional).
    ///
    /// The customUsername is only required if you use something other than email as
    /// the username field.
    custom_username: ?[]const u8 = null,

    /// Additional authentication parameters to include in the OIDC flow (optional).
    extra_auth_params: ?[]const u8 = null,

    /// The issuer URL of the OIDC provider (e.g., 'https://login.example.com').
    issuer: []const u8,

    /// The ID of the Wickr network for which OIDC will be configured.
    network_id: []const u8,

    /// The OAuth scopes to request from the OIDC provider (e.g., 'openid profile
    /// email').
    scopes: []const u8,

    /// The client secret for authenticating with the OIDC provider (optional).
    secret: ?[]const u8 = null,

    /// The buffer time in minutes before the SSO token expires to refresh it
    /// (optional).
    sso_token_buffer_minutes: ?i32 = null,

    /// Unique identifier provided by your identity provider to authenticate the
    /// access request. Also referred to as clientID.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .company_id = "companyId",
        .custom_username = "customUsername",
        .extra_auth_params = "extraAuthParams",
        .issuer = "issuer",
        .network_id = "networkId",
        .scopes = "scopes",
        .secret = "secret",
        .sso_token_buffer_minutes = "ssoTokenBufferMinutes",
        .user_id = "userId",
    };
};

pub const RegisterOidcConfigOutput = struct {
    /// The unique identifier for the registered OIDC application.
    application_id: ?i32 = null,

    /// The name of the registered OIDC application.
    application_name: ?[]const u8 = null,

    /// The CA certificate used for secure communication with the OIDC provider.
    ca_certificate: ?[]const u8 = null,

    /// The OAuth client ID assigned to the application.
    client_id: ?[]const u8 = null,

    /// The OAuth client secret for the application.
    client_secret: ?[]const u8 = null,

    /// Custom identifier your end users will use to sign in with SSO.
    company_id: []const u8,

    /// The custom field mapping used for extracting the username.
    custom_username: ?[]const u8 = null,

    /// The additional authentication parameters configured for the OIDC flow.
    extra_auth_params: ?[]const u8 = null,

    /// The issuer URL of the OIDC provider.
    issuer: []const u8,

    /// The redirect URL configured for the OAuth flow.
    redirect_url: ?[]const u8 = null,

    /// The OAuth scopes configured for the application.
    scopes: []const u8,

    /// The client secret for authenticating with the OIDC provider.
    secret: ?[]const u8 = null,

    /// The buffer time in minutes before the SSO token expires.
    sso_token_buffer_minutes: ?i32 = null,

    /// The claim field being used as the user identifier.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .application_name = "applicationName",
        .ca_certificate = "caCertificate",
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .company_id = "companyId",
        .custom_username = "customUsername",
        .extra_auth_params = "extraAuthParams",
        .issuer = "issuer",
        .redirect_url = "redirectUrl",
        .scopes = "scopes",
        .secret = "secret",
        .sso_token_buffer_minutes = "ssoTokenBufferMinutes",
        .user_id = "userId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterOidcConfigInput, options: CallOptions) !RegisterOidcConfigOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterOidcConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/oidc/save");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"companyId\":");
    try aws.json.writeValue(@TypeOf(input.company_id), input.company_id, allocator, &body_buf);
    has_prev = true;
    if (input.custom_username) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customUsername\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.extra_auth_params) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"extraAuthParams\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"issuer\":");
    try aws.json.writeValue(@TypeOf(input.issuer), input.issuer, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scopes\":");
    try aws.json.writeValue(@TypeOf(input.scopes), input.scopes, allocator, &body_buf);
    has_prev = true;
    if (input.secret) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"secret\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sso_token_buffer_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ssoTokenBufferMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterOidcConfigOutput {
    var result: RegisterOidcConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterOidcConfigOutput, body, allocator);
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
