const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthConfig = @import("auth_config.zig").AuthConfig;
const AuthType = @import("auth_type.zig").AuthType;
const SecretsManager = @import("secrets_manager.zig").SecretsManager;

pub const CreateConnectorDestinationInput = struct {
    /// The authentication configuration details for the connector destination,
    /// including OAuth settings and other authentication parameters.
    auth_config: AuthConfig,

    /// The authentication type used for the connector destination, which determines
    /// how credentials and access are managed.
    auth_type: ?AuthType = null,

    /// An idempotency token. If you retry a request that completed successfully
    /// initially using the same client token and parameters, then the retry attempt
    /// will succeed without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The identifier of the C2C connector.
    cloud_connector_id: []const u8,

    /// A description of the connector destination.
    description: ?[]const u8 = null,

    /// The display name of the connector destination.
    name: ?[]const u8 = null,

    /// The AWS Secrets Manager configuration used to securely store and manage
    /// sensitive information for the connector destination.
    secrets_manager: ?SecretsManager = null,

    pub const json_field_names = .{
        .auth_config = "AuthConfig",
        .auth_type = "AuthType",
        .client_token = "ClientToken",
        .cloud_connector_id = "CloudConnectorId",
        .description = "Description",
        .name = "Name",
        .secrets_manager = "SecretsManager",
    };
};

pub const CreateConnectorDestinationOutput = struct {
    /// The identifier of the C2C connector destination creation request.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectorDestinationInput, options: CallOptions) !CreateConnectorDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectorDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/connector-destinations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuthConfig\":");
    try aws.json.writeValue(@TypeOf(input.auth_config), input.auth_config, allocator, &body_buf);
    has_prev = true;
    if (input.auth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AuthType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CloudConnectorId\":");
    try aws.json.writeValue(@TypeOf(input.cloud_connector_id), input.cloud_connector_id, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.secrets_manager) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SecretsManager\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectorDestinationOutput {
    var result: CreateConnectorDestinationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateConnectorDestinationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
