const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SessionLimits = @import("session_limits.zig").SessionLimits;
const PaymentSession = @import("payment_session.zig").PaymentSession;

pub const CreatePaymentSessionInput = struct {
    /// The agent name associated with this request, used for observability.
    agent_name: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The session expiry time in minutes. Must be between 15 and 480 minutes.
    expiry_time_in_minutes: i32,

    /// The spending limits for this payment session.
    limits: ?SessionLimits = null,

    /// The ARN of the payment manager that owns this session.
    payment_manager_arn: []const u8,

    /// The user ID associated with this payment session.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_name = "agentName",
        .client_token = "clientToken",
        .expiry_time_in_minutes = "expiryTimeInMinutes",
        .limits = "limits",
        .payment_manager_arn = "paymentManagerArn",
        .user_id = "userId",
    };
};

pub const CreatePaymentSessionOutput = struct {
    /// The created payment session.
    payment_session: ?PaymentSession = null,

    pub const json_field_names = .{
        .payment_session = "paymentSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePaymentSessionInput, options: CallOptions) !CreatePaymentSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePaymentSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/payments/createPaymentSession";

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
    try body_buf.appendSlice(allocator, "\"expiryTimeInMinutes\":");
    try aws.json.writeValue(@TypeOf(input.expiry_time_in_minutes), input.expiry_time_in_minutes, allocator, &body_buf);
    has_prev = true;
    if (input.limits) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"limits\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePaymentSessionOutput {
    const result: CreatePaymentSessionOutput = try aws.json.parseJsonObject(
        CreatePaymentSessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
