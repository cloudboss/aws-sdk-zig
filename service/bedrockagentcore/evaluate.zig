const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluationInput = @import("evaluation_input.zig").EvaluationInput;
const EvaluationReferenceInput = @import("evaluation_reference_input.zig").EvaluationReferenceInput;
const EvaluationTarget = @import("evaluation_target.zig").EvaluationTarget;
const EvaluationResultContent = @import("evaluation_result_content.zig").EvaluationResultContent;

pub const EvaluateInput = struct {
    /// The input data containing agent session spans to be evaluated. Includes a
    /// list of spans in OpenTelemetry format from supported frameworks like Strands
    /// (AgentCore Runtime) or LangGraph with OpenInference instrumentation.
    evaluation_input: EvaluationInput,

    /// Ground truth data to compare against agent responses during evaluation.
    /// Allows to provide expected responses, assertions, and expected tool
    /// trajectories at different evaluation levels. Session-level reference inputs
    /// apply to the entire conversation, while trace-level reference inputs target
    /// specific request-response interactions identified by trace ID.
    evaluation_reference_inputs: ?[]const EvaluationReferenceInput = null,

    /// The specific trace or span IDs to evaluate within the provided input. Allows
    /// targeting evaluation at different levels: individual tool calls, single
    /// request-response interactions (traces), or entire conversation sessions.
    evaluation_target: ?EvaluationTarget = null,

    /// The unique identifier of the evaluator to use for scoring. Can be a built-in
    /// evaluator (e.g., `Builtin.Helpfulness`, `Builtin.Correctness`) or a custom
    /// evaluator Id created through the control plane API.
    evaluator_id: []const u8,

    pub const json_field_names = .{
        .evaluation_input = "evaluationInput",
        .evaluation_reference_inputs = "evaluationReferenceInputs",
        .evaluation_target = "evaluationTarget",
        .evaluator_id = "evaluatorId",
    };
};

pub const EvaluateOutput = struct {
    /// The detailed evaluation results containing scores, explanations, and
    /// metadata. Includes the evaluator information, numerical or categorical
    /// ratings based on the evaluator's rating scale, and token usage statistics
    /// for the evaluation process.
    evaluation_results: ?[]const EvaluationResultContent = null,

    pub const json_field_names = .{
        .evaluation_results = "evaluationResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EvaluateInput, options: CallOptions) !EvaluateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EvaluateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/evaluations/evaluate/");
    try path_buf.appendSlice(allocator, input.evaluator_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"evaluationInput\":");
    try aws.json.writeValue(@TypeOf(input.evaluation_input), input.evaluation_input, allocator, &body_buf);
    has_prev = true;
    if (input.evaluation_reference_inputs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluationReferenceInputs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.evaluation_target) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluationTarget\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EvaluateOutput {
    const result: EvaluateOutput = try aws.json.parseJsonObject(
        EvaluateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
