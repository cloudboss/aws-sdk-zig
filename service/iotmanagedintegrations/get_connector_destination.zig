const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthConfig = @import("auth_config.zig").AuthConfig;
const AuthType = @import("auth_type.zig").AuthType;
const SecretsManager = @import("secrets_manager.zig").SecretsManager;

pub const GetConnectorDestinationInput = struct {
    /// The identifier of the C2C connector destination.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetConnectorDestinationOutput = struct {
    /// The authentication configuration details for the connector destination,
    /// including OAuth settings and other authentication parameters.
    auth_config: ?AuthConfig = null,

    /// The authentication type used for the connector destination, which determines
    /// how credentials and access are managed.
    auth_type: ?AuthType = null,

    /// The identifier of the C2C connector.
    cloud_connector_id: ?[]const u8 = null,

    /// A description of the connector destination.
    description: ?[]const u8 = null,

    /// The unique identifier of the connector destination.
    id: ?[]const u8 = null,

    /// The display name of the connector destination.
    name: ?[]const u8 = null,

    /// The URL where users are redirected after completing the OAuth authorization
    /// process for the connector destination.
    o_auth_complete_redirect_url: ?[]const u8 = null,

    /// The AWS Secrets Manager configuration used to securely store and manage
    /// sensitive information for the connector destination.
    secrets_manager: ?SecretsManager = null,

    pub const json_field_names = .{
        .auth_config = "AuthConfig",
        .auth_type = "AuthType",
        .cloud_connector_id = "CloudConnectorId",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .o_auth_complete_redirect_url = "OAuthCompleteRedirectUrl",
        .secrets_manager = "SecretsManager",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConnectorDestinationInput, options: CallOptions) !GetConnectorDestinationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConnectorDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connector-destinations/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConnectorDestinationOutput {
    var result: GetConnectorDestinationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConnectorDestinationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
