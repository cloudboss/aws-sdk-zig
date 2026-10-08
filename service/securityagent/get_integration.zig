const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Provider = @import("provider.zig").Provider;
const ProviderType = @import("provider_type.zig").ProviderType;

pub const GetIntegrationInput = struct {
    /// The unique identifier of the integration to retrieve.
    integration_id: []const u8,

    pub const json_field_names = .{
        .integration_id = "integrationId",
    };
};

pub const GetIntegrationOutput = struct {
    /// The display name of the integration.
    display_name: ?[]const u8 = null,

    /// The installation identifier from the integration provider.
    installation_id: []const u8,

    /// The unique identifier of the integration.
    integration_id: []const u8,

    /// The identifier of the AWS KMS key used to encrypt data associated with the
    /// integration.
    kms_key_id: ?[]const u8 = null,

    /// The name of the private connection used to reach the integration's
    /// self-hosted instance over private networking, if one is configured.
    private_connection_name: ?[]const u8 = null,

    /// The integration provider.
    provider: Provider,

    /// The type of the integration provider.
    provider_type: ProviderType,

    /// The HTTPS URL of the customer self-hosted instance, such as a GitHub
    /// Enterprise Server or self-managed GitLab instance. This value is absent for
    /// SaaS integrations.
    target_url: ?[]const u8 = null,

    /// The payload URL of the integration's webhook, once it has been created. The
    /// signing secret is never returned on a read.
    webhook_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .installation_id = "installationId",
        .integration_id = "integrationId",
        .kms_key_id = "kmsKeyId",
        .private_connection_name = "privateConnectionName",
        .provider = "provider",
        .provider_type = "providerType",
        .target_url = "targetUrl",
        .webhook_url = "webhookUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIntegrationInput, options: CallOptions) !GetIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetIntegration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"integrationId\":");
    try aws.json.writeValue(@TypeOf(input.integration_id), input.integration_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIntegrationOutput {
    const result: GetIntegrationOutput = try aws.json.parseJsonObject(
        GetIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
