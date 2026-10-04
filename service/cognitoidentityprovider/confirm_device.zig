const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceSecretVerifierConfigType = @import("device_secret_verifier_config_type.zig").DeviceSecretVerifierConfigType;

pub const ConfirmDeviceInput = struct {
    /// A valid access token that Amazon Cognito issued to the currently signed-in
    /// user. Must include a scope claim for
    /// `aws.cognito.signin.user.admin`.
    access_token: []const u8,

    /// The unique identifier, or device key, of the device that you want to update
    /// the status
    /// for.
    device_key: []const u8,

    /// A friendly name for the device, for example `MyMobilePhone`.
    device_name: ?[]const u8 = null,

    /// The configuration of the device secret verifier.
    device_secret_verifier_config: ?DeviceSecretVerifierConfigType = null,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .device_key = "DeviceKey",
        .device_name = "DeviceName",
        .device_secret_verifier_config = "DeviceSecretVerifierConfig",
    };
};

pub const ConfirmDeviceOutput = struct {
    /// When `true`, your user must confirm that they want to remember the device.
    /// Prompt the user for an answer.
    ///
    /// When `false`, immediately sets the device as remembered and eligible for
    /// device authentication.
    ///
    /// You can configure your user pool to always remember devices, in which case
    /// this
    /// response is `false`, or to allow users to opt in, in which case this
    /// response
    /// is `true`. Configure this option under *Device tracking*
    /// in the *Sign-in* menu of your user pool.
    user_confirmation_necessary: ?bool = null,

    pub const json_field_names = .{
        .user_confirmation_necessary = "UserConfirmationNecessary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConfirmDeviceInput, options: CallOptions) !ConfirmDeviceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ConfirmDeviceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.ConfirmDevice");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ConfirmDeviceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ConfirmDeviceOutput, body, allocator);
}
