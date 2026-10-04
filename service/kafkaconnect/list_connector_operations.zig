const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorOperationSummary = @import("connector_operation_summary.zig").ConnectorOperationSummary;

pub const ListConnectorOperationsInput = struct {
    /// The Amazon Resource Name (ARN) of the connector for which to list
    /// operations.
    connector_arn: []const u8,

    /// Maximum number of connector operations to fetch in one get request.
    max_results: ?i32 = null,

    /// If the response is truncated, it includes a NextToken. Send this NextToken
    /// in a subsequent request to continue listing from where it left off.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListConnectorOperationsOutput = struct {
    /// An array of connector operation descriptions.
    connector_operations: ?[]const ConnectorOperationSummary = null,

    /// If the response is truncated, it includes a NextToken. Send this NextToken
    /// in a subsequent request to continue listing from where it left off.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_operations = "connectorOperations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConnectorOperationsInput, options: CallOptions) !ListConnectorOperationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConnectorOperationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafkaconnect", "KafkaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/connectors/");
    try path_buf.appendSlice(allocator, input.connector_arn);
    try path_buf.appendSlice(allocator, "/operations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConnectorOperationsOutput {
    var result: ListConnectorOperationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListConnectorOperationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
