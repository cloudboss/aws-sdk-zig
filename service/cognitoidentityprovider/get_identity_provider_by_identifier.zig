const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProviderType = @import("identity_provider_type.zig").IdentityProviderType;

pub const GetIdentityProviderByIdentifierInput = struct {
    /// The identifier that you assigned to your user pool. The identifier is an
    /// alternative
    /// name for an IdP that is distinct from the IdP name. For example, an IdP with
    /// a name of
    /// `MyIdP` might have an identifier of the email domain
    /// `example.com`.
    idp_identifier: []const u8,

    /// The ID of the user pool where you want to get information about the IdP.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .idp_identifier = "IdpIdentifier",
        .user_pool_id = "UserPoolId",
    };
};

pub const GetIdentityProviderByIdentifierOutput = struct {
    /// The configuration of the IdP in your user pool. Includes additional
    /// identifiers, the
    /// IdP name and type, and trust-relationship details like the issuer URL.
    identity_provider: ?IdentityProviderType = null,

    pub const json_field_names = .{
        .identity_provider = "IdentityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityProviderByIdentifierInput, options: CallOptions) !GetIdentityProviderByIdentifierOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityProviderByIdentifierInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.GetIdentityProviderByIdentifier");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityProviderByIdentifierOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetIdentityProviderByIdentifierOutput, body, allocator);
}
