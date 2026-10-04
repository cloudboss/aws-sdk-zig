const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CredentialsProviderConfiguration = @import("credentials_provider_configuration.zig").CredentialsProviderConfiguration;
const PaymentConnectorProvisionMode = @import("payment_connector_provision_mode.zig").PaymentConnectorProvisionMode;
const PaymentConnectorStatus = @import("payment_connector_status.zig").PaymentConnectorStatus;
const PaymentConnectorType = @import("payment_connector_type.zig").PaymentConnectorType;

pub const GetPaymentConnectorInput = struct {
    /// The unique identifier of the payment connector to retrieve.
    payment_connector_id: []const u8,

    /// The unique identifier of the parent payment manager.
    payment_manager_id: []const u8,

    pub const json_field_names = .{
        .payment_connector_id = "paymentConnectorId",
        .payment_manager_id = "paymentManagerId",
    };
};

pub const GetPaymentConnectorOutput = struct {
    /// The URL that the user must open to complete OAuth consent. This field is
    /// only present when the payment connector status is `PENDING_AUTHENTICATION`.
    authorization_url: ?[]const u8 = null,

    /// The timestamp when the payment connector was created.
    created_at: i64,

    /// The credential provider configurations for the payment connector.
    credential_provider_configurations: ?[]const CredentialsProviderConfiguration = null,

    /// The timestamp when the payment connector's current service-managed
    /// credentials took effect. It is first set when the credentials are
    /// provisioned and is updated by each rotation. This field is present only for
    /// payment connectors with a `provisionMode` of `QUICK_CREATE`.
    credentials_updated_at: ?i64 = null,

    /// The description of the payment connector.
    description: ?[]const u8 = null,

    /// The timestamp when the payment connector was last updated.
    last_updated_at: i64,

    /// The name of the payment connector.
    name: []const u8,

    /// The unique identifier of the payment connector.
    payment_connector_id: []const u8,

    /// Specifies how the payment connector was provisioned. Payment connectors that
    /// were created before this field was available return `MANUAL`.
    ///
    /// * `MANUAL` - You provided the credential provider configurations, so you own
    ///   the credentials. Rotate them with the payment provider, then call
    ///   `UpdatePaymentCredentialProvider`.
    /// * `QUICK_CREATE` - AgentCore provisioned the credential provider for you, so
    ///   the credentials are service-managed. You can rotate them with
    ///   `RotatePaymentConnectorCredentials`.
    provision_mode: ?PaymentConnectorProvisionMode = null,

    /// The current status of the payment connector. Possible values include
    /// `CREATING`, `READY`, `UPDATING`, `DELETING`, `CREATE_FAILED`,
    /// `UPDATE_FAILED`, and `DELETE_FAILED`.
    status: PaymentConnectorStatus,

    /// The type of the payment connector, which determines the payment provider
    /// integration.
    @"type": PaymentConnectorType,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
        .created_at = "createdAt",
        .credential_provider_configurations = "credentialProviderConfigurations",
        .credentials_updated_at = "credentialsUpdatedAt",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .payment_connector_id = "paymentConnectorId",
        .provision_mode = "provisionMode",
        .status = "status",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPaymentConnectorInput, options: CallOptions) !GetPaymentConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPaymentConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/payments/managers/");
    try path_buf.appendSlice(allocator, input.payment_manager_id);
    try path_buf.appendSlice(allocator, "/connectors/");
    try path_buf.appendSlice(allocator, input.payment_connector_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPaymentConnectorOutput {
    const result: GetPaymentConnectorOutput = try aws.json.parseJsonObject(
        GetPaymentConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
