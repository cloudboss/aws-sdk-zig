const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Platform = @import("platform.zig").Platform;

pub const RegisterDeviceInput = struct {
    /// The unique ID for this identity.
    identity_id: []const u8,

    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by
    /// Amazon Cognito. Here, the ID of the pool that the identity belongs to.
    identity_pool_id: []const u8,

    /// The SNS platform type (e.g. GCM, SDM, APNS, APNS_SANDBOX).
    platform: Platform,

    /// The push token.
    token: []const u8,

    pub const json_field_names = .{
        .identity_id = "IdentityId",
        .identity_pool_id = "IdentityPoolId",
        .platform = "Platform",
        .token = "Token",
    };
};

pub const RegisterDeviceOutput = struct {
    /// The unique ID generated for this device by Cognito.
    device_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_id = "DeviceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterDeviceInput, options: CallOptions) !RegisterDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-sync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-sync", "Cognito Sync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/identitypools/");
    try path_buf.appendSlice(allocator, input.identity_pool_id);
    try path_buf.appendSlice(allocator, "/identity/");
    try path_buf.appendSlice(allocator, input.identity_id);
    try path_buf.appendSlice(allocator, "/device");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Platform\":");
    try aws.json.writeValue(@TypeOf(input.platform), input.platform, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Token\":");
    try aws.json.writeValue(@TypeOf(input.token), input.token, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterDeviceOutput {
    var result: RegisterDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterDeviceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
