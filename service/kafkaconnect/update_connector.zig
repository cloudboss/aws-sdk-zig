const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityUpdate = @import("capacity_update.zig").CapacityUpdate;
const ConnectorState = @import("connector_state.zig").ConnectorState;

pub const UpdateConnectorInput = struct {
    /// The target capacity.
    capacity: ?CapacityUpdate = null,

    /// The Amazon Resource Name (ARN) of the connector that you want to update.
    connector_arn: []const u8,

    /// A map of keys to values that represent the configuration for the connector.
    connector_configuration: ?[]const aws.map.StringMapEntry = null,

    /// The current version of the connector that you want to update.
    current_version: []const u8,

    pub const json_field_names = .{
        .capacity = "capacity",
        .connector_arn = "connectorArn",
        .connector_configuration = "connectorConfiguration",
        .current_version = "currentVersion",
    };
};

pub const UpdateConnectorOutput = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the connector operation.
    connector_operation_arn: ?[]const u8 = null,

    /// The state of the connector.
    connector_state: ?ConnectorState = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .connector_operation_arn = "connectorOperationArn",
        .connector_state = "connectorState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateConnectorInput, options: CallOptions) !UpdateConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/connectors/");
    try path_buf.appendSlice(allocator, input.connector_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "currentVersion=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.current_version);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateConnectorOutput {
    const result: UpdateConnectorOutput = try aws.json.parseJsonObject(
        UpdateConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
