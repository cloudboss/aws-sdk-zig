const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GuardrailChecksConfig = @import("guardrail_checks_config.zig").GuardrailChecksConfig;
const GuardrailChecksMessage = @import("guardrail_checks_message.zig").GuardrailChecksMessage;
const GuardrailChecksResults = @import("guardrail_checks_results.zig").GuardrailChecksResults;
const GuardrailChecksUsageResults = @import("guardrail_checks_usage_results.zig").GuardrailChecksUsageResults;

pub const InvokeGuardrailChecksInput = struct {
    /// The inline check configurations that specify which guardrail checks to run
    /// against the messages.
    checks: GuardrailChecksConfig,

    /// The messages to evaluate against the specified guardrail checks. Each
    /// message includes a role and one or more content blocks.
    messages: []const GuardrailChecksMessage,

    pub const json_field_names = .{
        .checks = "checks",
        .messages = "messages",
    };
};

pub const InvokeGuardrailChecksOutput = struct {
    /// The per-check results containing findings from the guardrail evaluation.
    results: ?GuardrailChecksResults = null,

    /// The per-check text unit consumption for the guardrail evaluation.
    usage: ?GuardrailChecksUsageResults = null,

    pub const json_field_names = .{
        .results = "results",
        .usage = "usage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeGuardrailChecksInput, options: CallOptions) !InvokeGuardrailChecksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockfrontendservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InvokeGuardrailChecksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-runtime", "Bedrock Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/guardrail-checks/invoke";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"checks\":");
    try aws.json.writeValue(@TypeOf(input.checks), input.checks, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"messages\":");
    try aws.json.writeValue(@TypeOf(input.messages), input.messages, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InvokeGuardrailChecksOutput {
    const result: InvokeGuardrailChecksOutput = try aws.json.parseJsonObject(
        InvokeGuardrailChecksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
