const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecretReference = @import("secret_reference.zig").SecretReference;
const SecretSourceType = @import("secret_source_type.zig").SecretSourceType;
const Secret = @import("secret.zig").Secret;

pub const CreateApiKeyCredentialProviderInput = struct {
    /// The API key to use for authentication. This value is encrypted and stored
    /// securely.
    api_key: ?[]const u8 = null,

    /// A reference to the Amazon Web Services Secrets Manager secret that stores
    /// the API key. This includes the secret ID and the JSON key used to extract
    /// the API key value from the secret. Required when `apiKeySecretSource` is set
    /// to `EXTERNAL`.
    api_key_secret_config: ?SecretReference = null,

    /// The source type of the API key secret. Use `MANAGED` if the secret is
    /// managed by the service, or `EXTERNAL` if you manage the secret yourself in
    /// Amazon Web Services Secrets Manager.
    api_key_secret_source: ?SecretSourceType = null,

    /// The name of the API key credential provider. The name must be unique within
    /// your account.
    name: []const u8,

    /// A map of tag keys and values to assign to the API key credential provider.
    /// Tags enable you to categorize your resources in different ways, for example,
    /// by purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .api_key = "apiKey",
        .api_key_secret_config = "apiKeySecretConfig",
        .api_key_secret_source = "apiKeySecretSource",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateApiKeyCredentialProviderOutput = struct {
    /// The Amazon Resource Name (ARN) of the secret containing the API key.
    api_key_secret_arn: ?Secret = null,

    /// The JSON key used to extract the API key value from the Amazon Web Services
    /// Secrets Manager secret.
    api_key_secret_json_key: ?[]const u8 = null,

    /// The source type of the API key secret. Either `MANAGED` if the secret is
    /// managed by the service, or `EXTERNAL` if managed by the user in Amazon Web
    /// Services Secrets Manager.
    api_key_secret_source: ?SecretSourceType = null,

    /// The Amazon Resource Name (ARN) of the created API key credential provider.
    credential_provider_arn: []const u8,

    /// The name of the created API key credential provider.
    name: []const u8,

    pub const json_field_names = .{
        .api_key_secret_arn = "apiKeySecretArn",
        .api_key_secret_json_key = "apiKeySecretJsonKey",
        .api_key_secret_source = "apiKeySecretSource",
        .credential_provider_arn = "credentialProviderArn",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApiKeyCredentialProviderInput, options: CallOptions) !CreateApiKeyCredentialProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApiKeyCredentialProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/CreateApiKeyCredentialProvider";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.api_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"apiKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.api_key_secret_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"apiKeySecretConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.api_key_secret_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"apiKeySecretSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApiKeyCredentialProviderOutput {
    const result: CreateApiKeyCredentialProviderOutput = try aws.json.parseJsonObject(
        CreateApiKeyCredentialProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
