const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceRememberedStatusType = @import("device_remembered_status_type.zig").DeviceRememberedStatusType;

pub const AdminUpdateDeviceStatusInput = struct {
    /// The unique identifier, or device key, of the device that you want to update
    /// the status
    /// for.
    device_key: []const u8,

    /// To enable device authentication with the specified device, set to
    /// `remembered`.To disable, set to `not_remembered`.
    device_remembered_status: ?DeviceRememberedStatusType = null,

    /// The name of the user that you want to query or modify. The value of this
    /// parameter
    /// is typically your user's username, but it can be any of their alias
    /// attributes. If
    /// `username` isn't an alias attribute in your user pool, this value
    /// must be the `sub` of a local user or the username of a user from a
    /// third-party IdP.
    username: []const u8,

    /// The ID of the user pool where you want to change a user's device status.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .device_key = "DeviceKey",
        .device_remembered_status = "DeviceRememberedStatus",
        .username = "Username",
        .user_pool_id = "UserPoolId",
    };
};

pub const AdminUpdateDeviceStatusOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AdminUpdateDeviceStatusInput, options: CallOptions) !AdminUpdateDeviceStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AdminUpdateDeviceStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AdminUpdateDeviceStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AdminUpdateDeviceStatusOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
