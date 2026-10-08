const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkConnectorConfiguration = @import("network_connector_configuration.zig").NetworkConnectorConfiguration;
const NetworkConnectorState = @import("network_connector_state.zig").NetworkConnectorState;

pub const DeleteNetworkConnectorInput = struct {
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const DeleteNetworkConnectorOutput = struct {
    /// The Amazon Resource Name (ARN) of the network connector.
    arn: []const u8,

    /// The network configuration of the connector, including VPC subnets and
    /// security groups.
    configuration: ?NetworkConnectorConfiguration = null,

    id: []const u8,

    /// The name of the network connector.
    name: []const u8,

    /// The ARN of the IAM role that Lambda uses to manage the underlying ENI
    /// resources for this connector.
    operator_role: ?[]const u8 = null,

    /// The current state of the network connector. The State field is typically
    /// `DELETING` after this call.
    state: ?NetworkConnectorState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .configuration = "Configuration",
        .id = "Id",
        .name = "Name",
        .operator_role = "OperatorRole",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteNetworkConnectorInput, options: CallOptions) !DeleteNetworkConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteNetworkConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Core", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2026-04-04/network-connectors/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteNetworkConnectorOutput {
    const result: DeleteNetworkConnectorOutput = try aws.json.parseJsonObject(
        DeleteNetworkConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
