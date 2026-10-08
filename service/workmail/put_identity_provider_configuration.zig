const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProviderAuthenticationMode = @import("identity_provider_authentication_mode.zig").IdentityProviderAuthenticationMode;
const IdentityCenterConfiguration = @import("identity_center_configuration.zig").IdentityCenterConfiguration;
const PersonalAccessTokenConfiguration = @import("personal_access_token_configuration.zig").PersonalAccessTokenConfiguration;

pub const PutIdentityProviderConfigurationInput = struct {
    /// The authentication mode used in WorkMail.
    authentication_mode: IdentityProviderAuthenticationMode,

    /// The details of the IAM Identity Center configuration.
    identity_center_configuration: IdentityCenterConfiguration,

    /// The ID of the WorkMail Organization.
    organization_id: []const u8,

    /// The details of the Personal Access Token configuration.
    personal_access_token_configuration: PersonalAccessTokenConfiguration,

    pub const json_field_names = .{
        .authentication_mode = "AuthenticationMode",
        .identity_center_configuration = "IdentityCenterConfiguration",
        .organization_id = "OrganizationId",
        .personal_access_token_configuration = "PersonalAccessTokenConfiguration",
    };
};

pub const PutIdentityProviderConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIdentityProviderConfigurationInput, options: CallOptions) !PutIdentityProviderConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workmail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutIdentityProviderConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.PutIdentityProviderConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutIdentityProviderConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
