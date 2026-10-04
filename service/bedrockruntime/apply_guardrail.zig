const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

fn serializeRequest(allocator: std.mem.Allocator, input: ApplyGuardrailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-runtime", "Bedrock Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/guardrail/");
    try path_buf.appendSlice(allocator, input.guardrail_identifier);
    try path_buf.appendSlice(allocator, "/version/");
    try path_buf.appendSlice(allocator, input.guardrail_version);
    try path_buf.appendSlice(allocator, "/apply");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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
