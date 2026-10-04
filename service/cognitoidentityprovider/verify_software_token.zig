const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VerifySoftwareTokenResponseType = @import("verify_software_token_response_type.zig").VerifySoftwareTokenResponseType;

pub const VerifySoftwareTokenInput = struct {
    /// A valid access token that Amazon Cognito issued to the currently signed-in
    /// user. Must include a scope claim for
    /// `aws.cognito.signin.user.admin`.
    access_token: ?[]const u8 = null,

    /// A friendly name for the device that's running the TOTP authenticator.
    friendly_device_name: ?[]const u8 = null,

    /// The session ID from an `AssociateSoftwareToken` request.
    session: ?[]const u8 = null,

    /// A TOTP that the user generated in their configured authenticator app.
    user_code: []const u8,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .friendly_device_name = "FriendlyDeviceName",
        .session = "Session",
        .user_code = "UserCode",
    };
};

pub const VerifySoftwareTokenOutput = struct {
    /// This session ID satisfies an `MFA_SETUP` challenge. Supply the session ID
    /// in your challenge response.
    session: ?[]const u8 = null,

    /// Amazon Cognito can accept or reject the code that you provide. This response
    /// parameter
    /// indicates the success of TOTP verification. Some reasons that this operation
    /// might
    /// return an error are clock skew on the user's device and excessive retries.
    status: ?VerifySoftwareTokenResponseType = null,

    pub const json_field_names = .{
        .session = "Session",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifySoftwareTokenInput, options: CallOptions) !VerifySoftwareTokenOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifySoftwareTokenInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.VerifySoftwareToken");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifySoftwareTokenOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(VerifySoftwareTokenOutput, body, allocator);
}
