const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorType = @import("connector_type.zig").ConnectorType;
const ConnectorEntityField = @import("connector_entity_field.zig").ConnectorEntityField;

pub const DescribeConnectorEntityInput = struct {
    /// The version of the API that's used by the connector.
    api_version: ?[]const u8 = null,

    /// The entity name for that connector.
    connector_entity_name: []const u8,

    /// The name of the connector profile. The name is unique for each
    /// `ConnectorProfile` in the Amazon Web Services account.
    connector_profile_name: ?[]const u8 = null,

    /// The type of connector application, such as Salesforce, Amplitude, and so on.
    connector_type: ?ConnectorType = null,

    pub const json_field_names = .{
        .api_version = "apiVersion",
        .connector_entity_name = "connectorEntityName",
        .connector_profile_name = "connectorProfileName",
        .connector_type = "connectorType",
    };
};

pub const DescribeConnectorEntityOutput = struct {
    /// Describes the fields for that connector entity. For example, for an
    /// *account* entity, the fields would be *account name*,
    /// *account ID*, and so on.
    connector_entity_fields: ?[]const ConnectorEntityField = null,

    pub const json_field_names = .{
        .connector_entity_fields = "connectorEntityFields",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectorEntityInput, options: CallOptions) !DescribeConnectorEntityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectorEntityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-connector-entity";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.api_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"apiVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorEntityName\":");
    try aws.json.writeValue(@TypeOf(input.connector_entity_name), input.connector_entity_name, allocator, &body_buf);
    has_prev = true;
    if (input.connector_profile_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorProfileName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectorEntityOutput {
    var result: DescribeConnectorEntityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeConnectorEntityOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
