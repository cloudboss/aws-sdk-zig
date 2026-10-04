const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceType = @import("device_type.zig").DeviceType;

pub const GetDeviceInput = struct {
    /// A valid access token that Amazon Cognito issued to the currently signed-in
    /// user. Must include a scope claim for
    /// `aws.cognito.signin.user.admin`.
    access_token: ?[]const u8 = null,

    /// The key of the device that you want to get information about.
    device_key: []const u8,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .device_key = "DeviceKey",
    };
};

pub const GetDeviceOutput = struct {
    /// Details of the requested device. Includes device information, last-accessed
    /// and
    /// created dates, and the device key.
    device: ?DeviceType = null,

    pub const json_field_names = .{
        .device = "Device",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeviceInput, options: CallOptions) !GetDeviceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeviceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.GetDevice");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeviceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDeviceOutput, body, allocator);
}
