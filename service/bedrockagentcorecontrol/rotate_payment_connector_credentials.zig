const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CredentialRotationConfig = @import("credential_rotation_config.zig").CredentialRotationConfig;
const PaymentConnectorStatus = @import("payment_connector_status.zig").PaymentConnectorStatus;

pub const RotatePaymentConnectorCredentialsInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The credentials to rotate. Specify the member that matches the payment
    /// connector's `type`. Each credential that you select is rotated
    /// independently.
    credentials_to_rotate: CredentialRotationConfig,

    /// The unique identifier of the payment connector whose credentials you want to
    /// rotate.
    payment_connector_id: []const u8,

    /// The unique identifier of the parent payment manager.
    payment_manager_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .credentials_to_rotate = "credentialsToRotate",
        .payment_connector_id = "paymentConnectorId",
        .payment_manager_id = "paymentManagerId",
    };
};

pub const RotatePaymentConnectorCredentialsOutput = struct {
    /// The timestamp when the payment connector was last updated, which is when the
    /// rotation completed.
    last_updated_at: i64,

    /// The unique identifier of the payment connector.
    payment_connector_id: []const u8,

    /// The unique identifier of the parent payment manager.
    payment_manager_id: []const u8,

    /// The current status of the payment connector, which is `READY` after a
    /// successful rotation.
    status: PaymentConnectorStatus,

    pub const json_field_names = .{
        .last_updated_at = "lastUpdatedAt",
        .payment_connector_id = "paymentConnectorId",
        .payment_manager_id = "paymentManagerId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RotatePaymentConnectorCredentialsInput, options: CallOptions) !RotatePaymentConnectorCredentialsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RotatePaymentConnectorCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/payments/managers/");
    try path_buf.appendSlice(allocator, input.payment_manager_id);
    try path_buf.appendSlice(allocator, "/connectors/");
    try path_buf.appendSlice(allocator, input.payment_connector_id);
    try path_buf.appendSlice(allocator, "/rotate-credentials");
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
    try body_buf.appendSlice(allocator, "\"credentialsToRotate\":");
    try aws.json.writeValue(@TypeOf(input.credentials_to_rotate), input.credentials_to_rotate, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RotatePaymentConnectorCredentialsOutput {
    const result: RotatePaymentConnectorCredentialsOutput = try aws.json.parseJsonObject(
        RotatePaymentConnectorCredentialsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
