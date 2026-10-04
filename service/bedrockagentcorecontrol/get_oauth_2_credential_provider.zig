const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Secret = @import("secret.zig").Secret;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;
const CredentialProviderVendorType = @import("credential_provider_vendor_type.zig").CredentialProviderVendorType;
const Oauth2ProviderConfigOutput = @import("oauth_2_provider_config_output.zig").Oauth2ProviderConfigOutput;
const Status = @import("status.zig").Status;

pub const GetOauth2CredentialProviderInput = struct {
    /// The name of the OAuth2 credential provider to retrieve.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const GetOauth2CredentialProviderOutput = struct {
    /// Callback URL to register on the OAuth2 credential provider as an allowed
    /// callback URL. This URL is where the OAuth2 authorization server redirects
    /// users after they complete the authorization flow.
    callback_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the client secret in Amazon Web Services
    /// Secrets Manager.
    client_secret_arn: ?Secret = null,

    /// The JSON key used to extract the client secret value from the Amazon Web
    /// Services Secrets Manager secret.
    client_secret_json_key: ?[]const u8 = null,

    /// The source type of the client secret. Either `MANAGED` if the secret is
    /// managed by the service, or `EXTERNAL` if managed by the user in Amazon Web
    /// Services Secrets Manager.
    client_secret_source: ?SecretSourceType = null,

    /// The timestamp when the OAuth2 credential provider was created.
    created_time: i64,

    /// ARN of the credential provider requested.
    credential_provider_arn: []const u8,

    /// The vendor of the OAuth2 credential provider.
    credential_provider_vendor: CredentialProviderVendorType,

    /// The reason for failure if the OAuth2 credential provider is in a failed
    /// state.
    failure_reason: ?[]const u8 = null,

    /// The timestamp when the OAuth2 credential provider was last updated.
    last_updated_time: i64,

    /// The name of the OAuth2 credential provider.
    name: []const u8,

    /// The configuration output for the OAuth2 provider.
    oauth_2_provider_config_output: ?Oauth2ProviderConfigOutput = null,

    /// The current status of the OAuth2 credential provider.
    status: ?Status = null,

    pub const json_field_names = .{
        .callback_url = "callbackUrl",
        .client_secret_arn = "clientSecretArn",
        .client_secret_json_key = "clientSecretJsonKey",
        .client_secret_source = "clientSecretSource",
        .created_time = "createdTime",
        .credential_provider_arn = "credentialProviderArn",
        .credential_provider_vendor = "credentialProviderVendor",
        .failure_reason = "failureReason",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .oauth_2_provider_config_output = "oauth2ProviderConfigOutput",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOauth2CredentialProviderInput, options: CallOptions) !GetOauth2CredentialProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOauth2CredentialProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/GetOauth2CredentialProvider";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOauth2CredentialProviderOutput {
    const result: GetOauth2CredentialProviderOutput = try aws.json.parseJsonObject(
        GetOauth2CredentialProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
