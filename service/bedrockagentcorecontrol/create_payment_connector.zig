const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CredentialsProviderConfiguration = @import("credentials_provider_configuration.zig").CredentialsProviderConfiguration;
const PaymentConnectorType = @import("payment_connector_type.zig").PaymentConnectorType;
const PaymentConnectorStatus = @import("payment_connector_status.zig").PaymentConnectorStatus;

pub const CreatePaymentConnectorInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The credential provider configurations for the payment connector. These
    /// configurations specify how the connector authenticates with the payment
    /// provider.
    credential_provider_configurations: []const CredentialsProviderConfiguration,

    /// A description of the payment connector.
    description: ?[]const u8 = null,

    /// The name of the payment connector.
    name: []const u8,

    /// The unique identifier of the payment manager to create the connector for.
    payment_manager_id: []const u8,

    /// The type of payment connector, which determines the payment provider
    /// integration.
    @"type": PaymentConnectorType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .credential_provider_configurations = "credentialProviderConfigurations",
        .description = "description",
        .name = "name",
        .payment_manager_id = "paymentManagerId",
        .@"type" = "type",
    };
};

pub const CreatePaymentConnectorOutput = struct {
    /// The timestamp when the payment connector was created.
    created_at: i64,

    /// The credential provider configurations for the created payment connector.
    credential_provider_configurations: ?[]const CredentialsProviderConfiguration = null,

    /// The name of the created payment connector.
    name: []const u8,

    /// The unique identifier of the created payment connector.
    payment_connector_id: []const u8,

    /// The unique identifier of the parent payment manager.
    payment_manager_id: []const u8,

    /// The current status of the payment connector. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `DELETING`, `CREATE_FAILED`,
    /// `UPDATE_FAILED`, and `DELETE_FAILED`.
    status: PaymentConnectorStatus,

    /// The type of the created payment connector.
    @"type": PaymentConnectorType,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .credential_provider_configurations = "credentialProviderConfigurations",
        .name = "name",
        .payment_connector_id = "paymentConnectorId",
        .payment_manager_id = "paymentManagerId",
        .status = "status",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePaymentConnectorInput, options: CallOptions) !CreatePaymentConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePaymentConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/payments/managers/");
    try path_buf.appendSlice(allocator, input.payment_manager_id);
    try path_buf.appendSlice(allocator, "/connectors");
    const path = try path_buf.toOwnedSlice(allocator);

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
    try body_buf.appendSlice(allocator, "\"credentialProviderConfigurations\":");
    try aws.json.writeValue(@TypeOf(input.credential_provider_configurations), input.credential_provider_configurations, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePaymentConnectorOutput {
    var result: CreatePaymentConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePaymentConnectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
