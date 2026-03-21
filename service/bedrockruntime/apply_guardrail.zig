const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GuardrailContentBlock = @import("guardrail_content_block.zig").GuardrailContentBlock;
const GuardrailOutputScope = @import("guardrail_output_scope.zig").GuardrailOutputScope;
const GuardrailContentSource = @import("guardrail_content_source.zig").GuardrailContentSource;
const GuardrailAction = @import("guardrail_action.zig").GuardrailAction;
const GuardrailAssessment = @import("guardrail_assessment.zig").GuardrailAssessment;
const GuardrailCoverage = @import("guardrail_coverage.zig").GuardrailCoverage;
const GuardrailOutputContent = @import("guardrail_output_content.zig").GuardrailOutputContent;
const GuardrailUsage = @import("guardrail_usage.zig").GuardrailUsage;

pub const ApplyGuardrailInput = struct {
    /// The content details used in the request to apply the guardrail.
    content: []const GuardrailContentBlock,

    /// The guardrail identifier used in the request to apply the guardrail.
    guardrail_identifier: []const u8,

    /// The guardrail version used in the request to apply the guardrail.
    guardrail_version: []const u8,

    /// Specifies the scope of the output that you get in the response. Set to
    /// `FULL` to return the entire output, including any detected and non-detected
    /// entries in the response for enhanced debugging.
    ///
    /// Note that the full output scope doesn't apply to word filters or regex in
    /// sensitive information filters. It does apply to all other filtering
    /// policies, including sensitive information with filters that can detect
    /// personally identifiable information (PII).
    output_scope: ?GuardrailOutputScope = null,

    /// The source of data used in the request to apply the guardrail.
    source: GuardrailContentSource,

    pub const json_field_names = .{
        .content = "content",
        .guardrail_identifier = "guardrailIdentifier",
        .guardrail_version = "guardrailVersion",
        .output_scope = "outputScope",
        .source = "source",
    };
};

pub const ApplyGuardrailOutput = struct {
    /// The action taken in the response from the guardrail.
    action: GuardrailAction,

    /// The reason for the action taken when harmful content is detected.
    action_reason: ?[]const u8 = null,

    /// The assessment details in the response from the guardrail.
    assessments: ?[]const GuardrailAssessment = null,

    /// The guardrail coverage details in the apply guardrail response.
    guardrail_coverage: ?GuardrailCoverage = null,

    /// The output details in the response from the guardrail.
    outputs: ?[]const GuardrailOutputContent = null,

    /// The usage details in the response from the guardrail.
    usage: ?GuardrailUsage = null,

    pub const json_field_names = .{
        .action = "action",
        .action_reason = "actionReason",
        .assessments = "assessments",
        .guardrail_coverage = "guardrailCoverage",
        .outputs = "outputs",
        .usage = "usage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ApplyGuardrailInput, options: CallOptions) !ApplyGuardrailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "amazonbedrockfrontendservice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ApplyGuardrailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-runtime", "Bedrock Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/guardrail/");
    try path_buf.appendSlice(allocator, input.guardrail_identifier);
    try path_buf.appendSlice(allocator, "/version/");
    try path_buf.appendSlice(allocator, input.guardrail_version);
    try path_buf.appendSlice(allocator, "/apply");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (input.output_scope) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputScope\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ApplyGuardrailOutput {
    var result: ApplyGuardrailOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ApplyGuardrailOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelErrorException")) {
        return .{ .arena = arena, .kind = .{ .model_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .model_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelStreamErrorException")) {
        return .{ .arena = arena, .kind = .{ .model_stream_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .model_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
