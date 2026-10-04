const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentConnectorStatus = @import("payment_connector_status.zig").PaymentConnectorStatus;

pub const DeletePaymentConnectorInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The unique identifier of the payment connector to delete.
    payment_connector_id: []const u8,

    /// The unique identifier of the parent payment manager.
    payment_manager_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .payment_connector_id = "paymentConnectorId",
        .payment_manager_id = "paymentManagerId",
    };
};

pub const DeletePaymentConnectorOutput = struct {
    /// The unique identifier of the deleted payment connector.
    payment_connector_id: ?[]const u8 = null,

    /// The current status of the payment connector, set to `DELETING` when deletion
    /// is initiated. Possible values include `CREATING`, `READY`, `UPDATING`,
    /// `DELETING`, `CREATE_FAILED`, `UPDATE_FAILED`, and `DELETE_FAILED`.
    status: PaymentConnectorStatus,

    pub const json_field_names = .{
        .payment_connector_id = "paymentConnectorId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePaymentConnectorInput, options: CallOptions) !DeletePaymentConnectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePaymentConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/payments/managers/");
    try path_buf.appendSlice(allocator, input.payment_manager_id);
    try path_buf.appendSlice(allocator, "/connectors/");
    try path_buf.appendSlice(allocator, input.payment_connector_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePaymentConnectorOutput {
    const result: DeletePaymentConnectorOutput = try aws.json.parseJsonObject(
        DeletePaymentConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
