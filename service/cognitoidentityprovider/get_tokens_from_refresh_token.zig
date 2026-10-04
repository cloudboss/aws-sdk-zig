const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthenticationResultType = @import("authentication_result_type.zig").AuthenticationResultType;

pub const GetTokensFromRefreshTokenInput = struct {
    /// The app client that issued the refresh token to the user who wants to
    /// request new
    /// tokens.
    client_id: []const u8,

    /// A map of custom key-value pairs that you can provide as input for any custom
    /// workflows
    /// that this action triggers. You create custom workflows by assigning Lambda
    /// functions
    /// to user pool triggers.
    ///
    /// When Amazon Cognito invokes any of these functions, it passes a JSON
    /// payload, which the
    /// function receives as input. This payload contains a `clientMetadata`
    /// attribute that provides the data that you assigned to the ClientMetadata
    /// parameter in
    /// your request. In your function code, you can process the `clientMetadata`
    /// value to enhance your workflow for your specific needs.
    ///
    /// To review the Lambda trigger types that Amazon Cognito invokes at runtime
    /// with API requests, see [
    /// Connecting API actions to Lambda
    /// triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-working-with-lambda-triggers.html#lambda-triggers-by-event) in the *Amazon Cognito Developer Guide*.
    ///
    /// When you use the `ClientMetadata` parameter, note that Amazon Cognito won't
    /// do the
    /// following:
    ///
    /// * Store the `ClientMetadata` value. This data is available only
    /// to Lambda triggers that are assigned to a user pool to support custom
    /// workflows. If your user pool configuration doesn't include triggers, the
    /// `ClientMetadata` parameter serves no purpose.
    ///
    /// * Validate the `ClientMetadata` value.
    ///
    /// * Encrypt the `ClientMetadata` value. Don't send sensitive
    /// information in this parameter.
    client_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The client secret of the requested app client, if the client has a secret.
    client_secret: ?[]const u8 = null,

    /// When you enable device remembering, Amazon Cognito issues a device key that
    /// you can use for
    /// device authentication that bypasses multi-factor authentication (MFA). To
    /// implement
    /// `GetTokensFromRefreshToken` in a user pool with device remembering, you
    /// must capture the device key from the initial authentication request. If your
    /// application
    /// doesn't provide the key of a registered device, Amazon Cognito issues a new
    /// one. You must
    /// provide the confirmed device key in this request if device remembering is
    /// enabled in
    /// your user pool.
    ///
    /// For more information about device remembering, see [Working with
    /// devices](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-device-tracking.html).
    device_key: ?[]const u8 = null,

    /// A valid refresh token that can authorize the request for new tokens. When
    /// refresh
    /// token rotation is active in the requested app client, this token is
    /// invalidated after
    /// the request is complete and after an optional grace period.
    refresh_token: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .client_metadata = "ClientMetadata",
        .client_secret = "ClientSecret",
        .device_key = "DeviceKey",
        .refresh_token = "RefreshToken",
    };
};

pub const GetTokensFromRefreshTokenOutput = struct {
    authentication_result: ?AuthenticationResultType = null,

    pub const json_field_names = .{
        .authentication_result = "AuthenticationResult",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTokensFromRefreshTokenInput, options: CallOptions) !GetTokensFromRefreshTokenOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTokensFromRefreshTokenInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.GetTokensFromRefreshToken");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTokensFromRefreshTokenOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTokensFromRefreshTokenOutput, body, allocator);
}
