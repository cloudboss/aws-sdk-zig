const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderInput = @import("provider_input.zig").ProviderInput;
const Provider = @import("provider.zig").Provider;

pub const CreateIntegrationInput = struct {
    /// The provider-specific input required to create the integration.
    input: ProviderInput,

    /// The display name for the integration.
    integration_display_name: []const u8,

    /// The identifier of the AWS KMS key to use for encrypting data associated with
    /// the integration.
    kms_key_id: ?[]const u8 = null,

    /// The name of an active private connection used to reach a self-hosted
    /// provider instance over private networking. Specify this when the instance is
    /// not publicly reachable.
    private_connection_name: ?[]const u8 = null,

    /// The integration provider.
    provider: Provider,

    /// The tags to associate with the integration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .input = "input",
        .integration_display_name = "integrationDisplayName",
        .kms_key_id = "kmsKeyId",
        .private_connection_name = "privateConnectionName",
        .provider = "provider",
        .tags = "tags",
    };
};

pub const CreateIntegrationOutput = struct {
    /// The unique identifier of the created integration.
    integration_id: []const u8,

    pub const json_field_names = .{
        .integration_id = "integrationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntegrationInput, options: CallOptions) !CreateIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateIntegration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"input\":");
    try aws.json.writeValue(@TypeOf(input.input), input.input, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"integrationDisplayName\":");
    try aws.json.writeValue(@TypeOf(input.integration_display_name), input.integration_display_name, allocator, &body_buf);
    has_prev = true;
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.private_connection_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"privateConnectionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"provider\":");
    try aws.json.writeValue(@TypeOf(input.provider), input.provider, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntegrationOutput {
    const result: CreateIntegrationOutput = try aws.json.parseJsonObject(
        CreateIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
