const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectorProvisioningConfig = @import("connector_provisioning_config.zig").ConnectorProvisioningConfig;
const ConnectorProvisioningType = @import("connector_provisioning_type.zig").ConnectorProvisioningType;

pub const RegisterConnectorInput = struct {
    /// The `clientToken` parameter is an idempotency token. It ensures that your
    /// `RegisterConnector` request completes only once. You choose the value to
    /// pass.
    /// For example, if you don't receive a response from your request, you can
    /// safely retry the
    /// request with the same `clientToken` parameter value.
    ///
    /// If you omit a `clientToken` value, the Amazon Web Services SDK that you are
    /// using inserts a value for you. This way, the SDK can safely retry requests
    /// multiple times
    /// after a network error. You must provide your own value for other use cases.
    ///
    /// If you specify input parameters that differ from your first request, an
    /// error occurs. If
    /// you use a different value for `clientToken`, Amazon AppFlow considers it a
    /// new
    /// call to `RegisterConnector`. The token is active for 8 hours.
    client_token: ?[]const u8 = null,

    /// The name of the connector. The name is unique for each
    /// `ConnectorRegistration`
    /// in your Amazon Web Services account.
    connector_label: ?[]const u8 = null,

    /// The provisioning type of the connector. Currently the only supported value
    /// is
    /// LAMBDA.
    connector_provisioning_config: ?ConnectorProvisioningConfig = null,

    /// The provisioning type of the connector. Currently the only supported value
    /// is LAMBDA.
    connector_provisioning_type: ?ConnectorProvisioningType = null,

    /// A description about the connector that's being registered.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .connector_label = "connectorLabel",
        .connector_provisioning_config = "connectorProvisioningConfig",
        .connector_provisioning_type = "connectorProvisioningType",
        .description = "description",
    };
};

pub const RegisterConnectorOutput = struct {
    /// The ARN of the connector being registered.
    connector_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_arn = "connectorArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterConnectorInput, options: CallOptions) !RegisterConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/register-connector";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_label) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorLabel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_provisioning_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorProvisioningConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connector_provisioning_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorProvisioningType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterConnectorOutput {
    var result: RegisterConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterConnectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
