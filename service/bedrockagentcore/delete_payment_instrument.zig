const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentInstrumentStatus = @import("payment_instrument_status.zig").PaymentInstrumentStatus;

pub const DeletePaymentInstrumentInput = struct {
    /// The payment connector ID. Must match the instrument's paymentConnectorId.
    payment_connector_id: []const u8,

    /// The payment instrument ID to delete.
    payment_instrument_id: []const u8,

    /// The payment manager ARN. Must match the instrument's paymentManagerArn.
    payment_manager_arn: []const u8,

    /// The user ID making the delete request. Must match the instrument's userId.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .payment_connector_id = "paymentConnectorId",
        .payment_instrument_id = "paymentInstrumentId",
        .payment_manager_arn = "paymentManagerArn",
        .user_id = "userId",
    };
};

pub const DeletePaymentInstrumentOutput = struct {
    /// The status of the instrument after deletion. Always DELETED for successful
    /// soft delete.
    status: PaymentInstrumentStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePaymentInstrumentInput, options: CallOptions) !DeletePaymentInstrumentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePaymentInstrumentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/payments/deletePaymentInstrument";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentConnectorId\":");
    try aws.json.writeValue(@TypeOf(input.payment_connector_id), input.payment_connector_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentInstrumentId\":");
    try aws.json.writeValue(@TypeOf(input.payment_instrument_id), input.payment_instrument_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentManagerArn\":");
    try aws.json.writeValue(@TypeOf(input.payment_manager_arn), input.payment_manager_arn, allocator, &body_buf);
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
    if (input.user_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Payments-User-Id", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePaymentInstrumentOutput {
    const result: DeletePaymentInstrumentOutput = try aws.json.parseJsonObject(
        DeletePaymentInstrumentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
