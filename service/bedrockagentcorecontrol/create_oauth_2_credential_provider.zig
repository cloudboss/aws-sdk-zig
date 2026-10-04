const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CredentialProviderVendorType = @import("credential_provider_vendor_type.zig").CredentialProviderVendorType;
const Oauth2ProviderConfigInput = @import("oauth_2_provider_config_input.zig").Oauth2ProviderConfigInput;
const Secret = @import("secret.zig").Secret;
const Oauth2ProviderConfigOutput = @import("oauth_2_provider_config_output.zig").Oauth2ProviderConfigOutput;
const Status = @import("status.zig").Status;

pub const CreateOauth2CredentialProviderInput = struct {
    /// The vendor of the OAuth2 credential provider. This specifies which OAuth2
    /// implementation to use.
    credential_provider_vendor: CredentialProviderVendorType,

    /// The name of the OAuth2 credential provider. The name must be unique within
    /// your account.
    name: []const u8,

    /// The configuration settings for the OAuth2 provider, including client ID,
    /// client secret, and other vendor-specific settings.
    oauth_2_provider_config_input: Oauth2ProviderConfigInput,

    /// A map of tag keys and values to assign to the OAuth2 credential provider.
    /// Tags enable you to categorize your resources in different ways, for example,
    /// by purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .credential_provider_vendor = "credentialProviderVendor",
        .name = "name",
        .oauth_2_provider_config_input = "oauth2ProviderConfigInput",
        .tags = "tags",
    };
};

pub const CreateOauth2CredentialProviderOutput = struct {
    /// Callback URL to register on the OAuth2 credential provider as an allowed
    /// callback URL. This URL is where the OAuth2 authorization server redirects
    /// users after they complete the authorization flow.
    callback_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the client secret in AWS Secrets Manager.
    client_secret_arn: ?Secret = null,

    /// The Amazon Resource Name (ARN) of the OAuth2 credential provider.
    credential_provider_arn: []const u8,

    /// The name of the OAuth2 credential provider.
    name: []const u8,

    oauth_2_provider_config_output: ?Oauth2ProviderConfigOutput = null,

    /// The current status of the OAuth2 credential provider.
    status: ?Status = null,

    pub const json_field_names = .{
        .callback_url = "callbackUrl",
        .client_secret_arn = "clientSecretArn",
        .credential_provider_arn = "credentialProviderArn",
        .name = "name",
        .oauth_2_provider_config_output = "oauth2ProviderConfigOutput",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOauth2CredentialProviderInput, options: CallOptions) !CreateOauth2CredentialProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOauth2CredentialProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/CreateOauth2CredentialProvider";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"credentialProviderVendor\":");
    try aws.json.writeValue(@TypeOf(input.credential_provider_vendor), input.credential_provider_vendor, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"oauth2ProviderConfigInput\":");
    try aws.json.writeValue(@TypeOf(input.oauth_2_provider_config_input), input.oauth_2_provider_config_input, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOauth2CredentialProviderOutput {
    var result: CreateOauth2CredentialProviderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateOauth2CredentialProviderOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
