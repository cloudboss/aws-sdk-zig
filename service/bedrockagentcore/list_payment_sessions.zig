const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PaymentSessionSummary = @import("payment_session_summary.zig").PaymentSessionSummary;

pub const ListPaymentSessionsInput = struct {
    /// The agent name associated with this request, used for observability.
    agent_name: ?[]const u8 = null,

    /// Maximum number of results to return in a single response.
    max_results: ?i32 = null,

    /// Token for pagination to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The ARN of the payment manager that owns the sessions.
    payment_manager_arn: []const u8,

    /// The user ID associated with the payment sessions.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_name = "agentName",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .payment_manager_arn = "paymentManagerArn",
        .user_id = "userId",
    };
};

pub const ListPaymentSessionsOutput = struct {
    /// Token for pagination to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// List of payment session summaries matching the request criteria.
    payment_sessions: ?[]const PaymentSessionSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .payment_sessions = "paymentSessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPaymentSessionsInput, options: CallOptions) !ListPaymentSessionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPaymentSessionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/payments/listPaymentSessions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPaymentSessionsOutput {
    const result: ListPaymentSessionsOutput = try aws.json.parseJsonObject(
        ListPaymentSessionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
