const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RestartConnectorInput = struct {
    /// The Amazon Resource Name (ARN) of the connector that you want to restart.
    connector_arn: []const u8,

    /// Specifies whether to restart only the connector's failed tasks. If `true`,
    /// the operation restarts only the tasks that are currently in a failed state,
    /// and healthy tasks continue running. If `false` or not specified, the
    /// operation restarts the connector and all of its tasks.
    only_failed_tasks: ?bool = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .only_failed_tasks = "onlyFailedTasks",
    };
};

pub const RestartConnectorOutput = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    connector_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the connector operation created to perform
    /// the restart.
    connector_operation_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .connector_operation_arn = "connectorOperationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestartConnectorInput, options: CallOptions) !RestartConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestartConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/connectors/");
    try path_buf.appendSlice(allocator, input.connector_arn);
    try path_buf.appendSlice(allocator, "/restart");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.only_failed_tasks) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "onlyFailedTasks=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestartConnectorOutput {
    const result: RestartConnectorOutput = try aws.json.parseJsonObject(
        RestartConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
