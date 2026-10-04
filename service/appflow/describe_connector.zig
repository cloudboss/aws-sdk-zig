const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const ConnectorConfiguration = @import("connector_configuration.zig").ConnectorConfiguration;

pub const DescribeConnectorInput = struct {
    /// The label of the connector. The label is unique for each
    /// `ConnectorRegistration` in your Amazon Web Services account. Only needed if
    /// calling for CUSTOMCONNECTOR connector type/.
    connector_label: ?[]const u8 = null,

    /// The connector type, such as CUSTOMCONNECTOR, Saleforce, Marketo. Please
    /// choose
    /// CUSTOMCONNECTOR for Lambda based custom connectors.
    connector_type: ConnectorType,

    pub const json_field_names = .{
        .connector_label = "connectorLabel",
        .connector_type = "connectorType",
    };
};

pub const DescribeConnectorOutput = struct {
    /// Configuration info of all the connectors that the user requested.
    connector_configuration: ?ConnectorConfiguration = null,

    pub const json_field_names = .{
        .connector_configuration = "connectorConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectorInput, options: CallOptions) !DescribeConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-connector";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.connector_label) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorLabel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorType\":");
    try aws.json.writeValue(@TypeOf(input.connector_type), input.connector_type, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectorOutput {
    const result: DescribeConnectorOutput = try aws.json.parseJsonObject(
        DescribeConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
