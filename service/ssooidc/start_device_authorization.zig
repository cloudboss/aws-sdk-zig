const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

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
    expires_in: ?i32 = null,

    /// Indicates the number of seconds the client must wait between attempts when
    /// polling for a
    /// session.
    interval: ?i32 = null,

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDeviceAuthorizationInput, options: CallOptions) !StartDeviceAuthorizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso-oauth", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDeviceAuthorizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("oidc", "SSO OIDC", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/device_authorization";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientId\":");
    try aws.json.writeValue(@TypeOf(input.client_id), input.client_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientSecret\":");
    try aws.json.writeValue(@TypeOf(input.client_secret), input.client_secret, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"startUrl\":");
    try aws.json.writeValue(@TypeOf(input.start_url), input.start_url, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDeviceAuthorizationOutput {
    const result: StartDeviceAuthorizationOutput = try aws.json.parseJsonObject(
        StartDeviceAuthorizationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
