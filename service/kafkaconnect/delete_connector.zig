const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorState = @import("connector_state.zig").ConnectorState;

pub const DeleteConnectorInput = struct {
    /// The Amazon Resource Name (ARN) of the connector that you want to delete.
    connector_arn: []const u8,

    /// The current version of the connector that you want to delete.
    current_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .current_version = "currentVersion",
    };
};

pub const DeleteConnectorOutput = struct {
    /// The Amazon Resource Name (ARN) of the connector that you requested to
    /// delete.
    connector_arn: ?[]const u8 = null,

    /// The state of the connector that you requested to delete.
    connector_state: ?ConnectorState = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .connector_state = "connectorState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteConnectorInput, options: CallOptions) !DeleteConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafkaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/connectors/");
    try path_buf.appendSlice(allocator, input.connector_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.current_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "currentVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteConnectorOutput {
    var result: DeleteConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteConnectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
