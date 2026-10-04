const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentInstrumentDetails = @import("payment_instrument_details.zig").PaymentInstrumentDetails;
const PaymentInstrumentType = @import("payment_instrument_type.zig").PaymentInstrumentType;
const PaymentInstrument = @import("payment_instrument.zig").PaymentInstrument;

pub const CreatePaymentInstrumentInput = struct {
    /// The agent name associated with this request, used for observability.
    agent_name: ?[]const u8 = null,

    /// Idempotency token to ensure request uniqueness.
    client_token: ?[]const u8 = null,

    /// The ID of the payment connector to use for this instrument.
    payment_connector_id: []const u8,

    /// The details of the payment instrument.
    payment_instrument_details: PaymentInstrumentDetails,

    /// The type of payment instrument being created.
    payment_instrument_type: PaymentInstrumentType,

    /// The ARN of the payment manager that owns this payment instrument.
    payment_manager_arn: []const u8,

    /// The user ID associated with this payment instrument.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_name = "agentName",
        .client_token = "clientToken",
        .payment_connector_id = "paymentConnectorId",
        .payment_instrument_details = "paymentInstrumentDetails",
        .payment_instrument_type = "paymentInstrumentType",
        .payment_manager_arn = "paymentManagerArn",
        .user_id = "userId",
    };
};

pub const CreatePaymentInstrumentOutput = struct {
    payment_instrument: ?PaymentInstrument = null,

    pub const json_field_names = .{
        .payment_instrument = "paymentInstrument",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePaymentInstrumentInput, options: CallOptions) !CreatePaymentInstrumentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePaymentInstrumentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/payments/createPaymentInstrument";

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
    try body_buf.appendSlice(allocator, "\"paymentConnectorId\":");
    try aws.json.writeValue(@TypeOf(input.payment_connector_id), input.payment_connector_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentInstrumentDetails\":");
    try aws.json.writeValue(@TypeOf(input.payment_instrument_details), input.payment_instrument_details, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"paymentInstrumentType\":");
    try aws.json.writeValue(@TypeOf(input.payment_instrument_type), input.payment_instrument_type, allocator, &body_buf);
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
    if (input.agent_name) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Payments-Agent-Name", v);
    }
    if (input.user_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Payments-User-Id", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePaymentInstrumentOutput {
    var result: CreatePaymentInstrumentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePaymentInstrumentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
