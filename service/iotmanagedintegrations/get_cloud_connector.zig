const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointConfig = @import("endpoint_config.zig").EndpointConfig;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const CloudConnectorType = @import("cloud_connector_type.zig").CloudConnectorType;

pub const GetCloudConnectorInput = struct {
    /// The identifier of the C2C connector.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetCloudConnectorOutput = struct {
    /// A description of the C2C connector.
    description: ?[]const u8 = null,

    /// The configuration details for the cloud connector endpoint, including
    /// connection parameters and authentication requirements.
    endpoint_config: ?EndpointConfig = null,

    /// The type of endpoint used for the cloud connector, which defines how the
    /// connector communicates with external services.
    endpoint_type: ?EndpointType = null,

    /// The unique identifier of the cloud connector.
    id: ?[]const u8 = null,

    /// The display name of the C2C connector.
    name: []const u8,

    /// The type of cloud connector created.
    @"type": ?CloudConnectorType = null,

    pub const json_field_names = .{
        .description = "Description",
        .endpoint_config = "EndpointConfig",
        .endpoint_type = "EndpointType",
        .id = "Id",
        .name = "Name",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCloudConnectorInput, options: CallOptions) !GetCloudConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCloudConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/cloud-connectors/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCloudConnectorOutput {
    const result: GetCloudConnectorOutput = try aws.json.parseJsonObject(
        GetCloudConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
