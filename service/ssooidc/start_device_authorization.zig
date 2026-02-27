const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const StartDeviceAuthorizationInput = struct {
    /// The unique identifier string for the client that is registered with IAM
    /// Identity Center. This value
    /// should come from the persisted result of the RegisterClient API
    /// operation.
    client_id: []const u8,

    /// A secret string that is generated for the client. This value should come
    /// from the
    /// persisted result of the RegisterClient API operation.
    client_secret: []const u8,

    /// The URL for the Amazon Web Services access portal. For more information, see
    /// [Using
    /// the Amazon Web Services access
    /// portal](https://docs.aws.amazon.com/singlesignon/latest/userguide/using-the-portal.html) in the *IAM Identity Center User Guide*.
    start_url: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
        .start_url = "startUrl",
    };
};

pub const StartDeviceAuthorizationOutput = struct {
    /// The short-lived code that is used by the device when polling for a session
    /// token.
    device_code: ?[]const u8 = null,

    /// Indicates the number of seconds in which the verification code will become
    /// invalid.
    expires_in: i32 = 0,

    /// Indicates the number of seconds the client must wait between attempts when
    /// polling for a
    /// session.
    interval: i32 = 0,

    /// A one-time user verification code. This is needed to authorize an in-use
    /// device.
    user_code: ?[]const u8 = null,

    /// The URI of the verification page that takes the `userCode` to authorize the
    /// device.
    verification_uri: ?[]const u8 = null,

    /// An alternate URL that the client can use to automatically launch a browser.
    /// This process
    /// skips the manual step in which the user visits the verification page and
    /// enters their
    /// code.
    verification_uri_complete: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_code = "deviceCode",
        .expires_in = "expiresIn",
        .interval = "interval",
        .user_code = "userCode",
        .verification_uri = "verificationUri",
        .verification_uri_complete = "verificationUriComplete",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDeviceAuthorizationInput, options: Options) !StartDeviceAuthorizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ssooidc");

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

fn serializeRequest(alloc: std.mem.Allocator, input: StartDeviceAuthorizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssooidc", "SSO OIDC", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/device_authorization";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"clientId\":");
    try aws.json.writeValue(@TypeOf(input.client_id), input.client_id, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"clientSecret\":");
    try aws.json.writeValue(@TypeOf(input.client_secret), input.client_secret, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"startUrl\":");
    try aws.json.writeValue(@TypeOf(input.start_url), input.start_url, alloc, &body_buf);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartDeviceAuthorizationOutput {
    var result: StartDeviceAuthorizationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartDeviceAuthorizationOutput, body, alloc);
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
