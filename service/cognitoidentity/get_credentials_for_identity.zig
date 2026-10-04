const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Credentials = @import("credentials.zig").Credentials;

pub const GetCredentialsForIdentityInput = struct {
    /// The Amazon Resource Name (ARN) of the role to be assumed when multiple roles
    /// were
    /// received in the token from the identity provider. For example, a SAML-based
    /// identity
    /// provider. This parameter is optional for identity providers that do not
    /// support role
    /// customization.
    custom_role_arn: ?[]const u8 = null,

    /// A unique identifier in the format REGION:GUID.
    identity_id: []const u8,

    /// A set of optional name-value pairs that map provider names to provider
    /// tokens. The
    /// name-value pair will follow the syntax "provider_name":
    /// "provider_user_identifier".
    ///
    /// Logins should not be specified when trying to get credentials for an
    /// unauthenticated
    /// identity.
    ///
    /// The Logins parameter is required when using identities associated with
    /// external
    /// identity providers such as Facebook. For examples of `Logins` maps, see the
    /// code
    /// examples in the [External Identity
    /// Providers](https://docs.aws.amazon.com/cognito/latest/developerguide/external-identity-providers.html) section of the Amazon Cognito Developer Guide.
    logins: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .custom_role_arn = "CustomRoleArn",
        .identity_id = "IdentityId",
        .logins = "Logins",
    };
};

pub const GetCredentialsForIdentityOutput = struct {
    /// Credentials for the provided identity ID.
    credentials: ?Credentials = null,

    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .credentials = "Credentials",
        .identity_id = "IdentityId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCredentialsForIdentityInput, options: CallOptions) !GetCredentialsForIdentityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-identity", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCredentialsForIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-identity", "Cognito Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.GetCredentialsForIdentity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCredentialsForIdentityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCredentialsForIdentityOutput, body, allocator);
}
