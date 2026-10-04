const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const ConnectorProfileConfig = @import("connector_profile_config.zig").ConnectorProfileConfig;
const ConnectorType = @import("connector_type.zig").ConnectorType;

pub const CreateConnectorProfileInput = struct {
    /// The `clientToken` parameter is an idempotency token. It ensures that your
    /// `CreateConnectorProfile` request completes only once. You choose the value
    /// to
    /// pass. For example, if you don't receive a response from your request, you
    /// can safely retry the
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
    /// call to `CreateConnectorProfile`. The token is active for 8 hours.
    client_token: ?[]const u8 = null,

    /// Indicates the connection mode and specifies whether it is public or private.
    /// Private
    /// flows use Amazon Web Services PrivateLink to route data over Amazon Web
    /// Services infrastructure
    /// without exposing it to the public internet.
    connection_mode: ConnectionMode,

    /// The label of the connector. The label is unique for each
    /// `ConnectorRegistration` in your Amazon Web Services account. Only needed if
    /// calling for CUSTOMCONNECTOR connector type/.
    connector_label: ?[]const u8 = null,

    /// Defines the connector-specific configuration and credentials.
    connector_profile_config: ConnectorProfileConfig,

    /// The name of the connector profile. The name is unique for each
    /// `ConnectorProfile` in your Amazon Web Services account.
    connector_profile_name: []const u8,

    /// The type of connector, such as Salesforce, Amplitude, and so on.
    connector_type: ConnectorType,

    /// The ARN (Amazon Resource Name) of the Key Management Service (KMS) key you
    /// provide for
    /// encryption. This is required if you do not want to use the Amazon
    /// AppFlow-managed KMS
    /// key. If you don't provide anything here, Amazon AppFlow uses the Amazon
    /// AppFlow-managed KMS key.
    kms_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .connection_mode = "connectionMode",
        .connector_label = "connectorLabel",
        .connector_profile_config = "connectorProfileConfig",
        .connector_profile_name = "connectorProfileName",
        .connector_type = "connectorType",
        .kms_arn = "kmsArn",
    };
};

pub const CreateConnectorProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the connector profile.
    connector_profile_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_profile_arn = "connectorProfileArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectorProfileInput, options: CallOptions) !CreateConnectorProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectorProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appflow", "Appflow", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/create-connector-profile";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectionMode\":");
    try aws.json.writeValue(@TypeOf(input.connection_mode), input.connection_mode, allocator, &body_buf);
    has_prev = true;
    if (input.connector_label) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"connectorLabel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorProfileConfig\":");
    try aws.json.writeValue(@TypeOf(input.connector_profile_config), input.connector_profile_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorProfileName\":");
    try aws.json.writeValue(@TypeOf(input.connector_profile_name), input.connector_profile_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"connectorType\":");
    try aws.json.writeValue(@TypeOf(input.connector_type), input.connector_type, allocator, &body_buf);
    has_prev = true;
    if (input.kms_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectorProfileOutput {
    const result: CreateConnectorProfileOutput = try aws.json.parseJsonObject(
        CreateConnectorProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
