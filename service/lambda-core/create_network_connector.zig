const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkConnectorConfiguration = @import("network_connector_configuration.zig").NetworkConnectorConfiguration;
const NetworkConnectorState = @import("network_connector_state.zig").NetworkConnectorState;

pub const CreateNetworkConnectorInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request with the same client
    /// token, the API returns the existing connector without creating a duplicate.
    client_token: ?[]const u8 = null,

    /// The network configuration for the connector. Specify a
    /// `VpcEgressConfiguration` to enable outbound traffic routing through your
    /// VPC.
    configuration: NetworkConnectorConfiguration,

    /// A unique name for the network connector within your account and Region. You
    /// can use the name to identify the connector in subsequent API calls.
    name: []const u8,

    /// The ARN of the IAM role that Lambda assumes to manage elastic network
    /// interfaces in your VPC. This role must have permissions for
    /// `ec2:CreateNetworkInterface`, `ec2:DeleteNetworkInterface`, and related
    /// describe operations.
    operator_role: ?[]const u8 = null,

    /// A map of key-value pairs to associate with the network connector for
    /// organization, cost allocation, or access control.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .configuration = "Configuration",
        .name = "Name",
        .operator_role = "OperatorRole",
        .tags = "Tags",
    };
};

pub const CreateNetworkConnectorOutput = struct {
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

    /// The current state of the network connector.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNetworkConnectorInput, options: CallOptions) !CreateNetworkConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNetworkConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Core", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-04-04/network-connectors";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.operator_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OperatorRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNetworkConnectorOutput {
    const result: CreateNetworkConnectorOutput = try aws.json.parseJsonObject(
        CreateNetworkConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
