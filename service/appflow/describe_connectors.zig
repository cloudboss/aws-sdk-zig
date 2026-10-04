const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const ConnectorConfiguration = @import("connector_configuration.zig").ConnectorConfiguration;
const ConnectorDetail = @import("connector_detail.zig").ConnectorDetail;

pub const DescribeConnectorsInput = struct {
    /// The type of connector, such as Salesforce, Amplitude, and so on.
    connector_types: ?[]const ConnectorType = null,

    /// The maximum number of items that should be returned in the result set. The
    /// default is
    /// 20.
    max_results: ?i32 = null,

    /// The pagination token for the next page of data.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_types = "connectorTypes",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeConnectorsOutput = struct {
    /// The configuration that is applied to the connectors used in the flow.
    connector_configurations: ?[]const aws.map.MapEntry(ConnectorConfiguration) = null,

    /// Information about the connectors supported in Amazon AppFlow.
    connectors: ?[]const ConnectorDetail = null,

    /// The pagination token for the next page of data.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_configurations = "connectorConfigurations",
        .connectors = "connectors",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectorsInput, options: CallOptions) !DescribeConnectorsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appflow", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-connectors";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.connector_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectorsOutput {
    var result: DescribeConnectorsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeConnectorsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
