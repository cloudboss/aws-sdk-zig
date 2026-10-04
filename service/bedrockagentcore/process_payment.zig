const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentInput = @import("payment_input.zig").PaymentInput;
const PaymentType = @import("payment_type.zig").PaymentType;
const PaymentOutput = @import("payment_output.zig").PaymentOutput;
const PaymentStatus = @import("payment_status.zig").PaymentStatus;

pub const ProcessPaymentInput = struct {
    /// The agent name associated with this request, used for observability.
    agent_name: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The payment input details specific to the payment type.
    payment_input: PaymentInput,

    /// The ID of the payment instrument to use.
    payment_instrument_id: []const u8,

    /// The ARN of the payment manager.
    payment_manager_arn: []const u8,

    /// The ID of the payment session.
    payment_session_id: []const u8,

    /// The type of payment to process.
    payment_type: PaymentType,

    /// The user ID associated with this payment.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_name = "agentName",
        .client_token = "clientToken",
        .payment_input = "paymentInput",
        .payment_instrument_id = "paymentInstrumentId",
        .payment_manager_arn = "paymentManagerArn",
        .payment_session_id = "paymentSessionId",
        .payment_type = "paymentType",
        .user_id = "userId",
    };
};

pub const ProcessPaymentOutput = struct {
    /// The timestamp when the payment was created.
    created_at: i64,

    /// The ID of the payment instrument used.
    payment_instrument_id: []const u8,

    /// The ARN of the payment manager.
    payment_manager_arn: []const u8,

    /// The payment output details specific to the payment type.
    payment_output: ?PaymentOutput = null,

    /// The ID of the payment session used.
    payment_session_id: []const u8,

    /// The type of payment processed.
    payment_type: PaymentType,

    /// The unique identifier of the processed payment.
    process_payment_id: []const u8,

    /// The status of the payment.
    status: PaymentStatus,

    /// The timestamp when the payment was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .payment_instrument_id = "paymentInstrumentId",
        .payment_manager_arn = "paymentManagerArn",
        .payment_output = "paymentOutput",
        .payment_session_id = "paymentSessionId",
        .payment_type = "paymentType",
        .process_payment_id = "processPaymentId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ProcessPaymentInput, options: CallOptions) !ProcessPaymentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ProcessPaymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/payments/processPayment";

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
    try body_buf.appendSlice(allocator, "\"paymentInput\":");
    try aws.json.writeValue(@TypeOf(input.payment_input), input.payment_input, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentInstrumentId\":");
    try aws.json.writeValue(@TypeOf(input.payment_instrument_id), input.payment_instrument_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentManagerArn\":");
    try aws.json.writeValue(@TypeOf(input.payment_manager_arn), input.payment_manager_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentSessionId\":");
    try aws.json.writeValue(@TypeOf(input.payment_session_id), input.payment_session_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentType\":");
    try aws.json.writeValue(@TypeOf(input.payment_type), input.payment_type, allocator, &body_buf);
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
    if (input.agent_name) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Payments-Agent-Name", v);
    }
    if (input.user_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Payments-User-Id", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ProcessPaymentOutput {
    const result: ProcessPaymentOutput = try aws.json.parseJsonObject(
        ProcessPaymentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
