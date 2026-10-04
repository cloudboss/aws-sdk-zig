const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludeGeneratedAnswer = @import("include_generated_answer.zig").IncludeGeneratedAnswer;
const IncludeQuickSightQIndex = @import("include_quick_sight_q_index.zig").IncludeQuickSightQIndex;
const QAResult = @import("qa_result.zig").QAResult;

pub const PredictQAResultsInput = struct {
    /// The ID of the Amazon Web Services account that the user wants to execute
    /// Predict QA results in.
    aws_account_id: []const u8,

    /// Indicates whether generated answers are included or excluded.
    include_generated_answer: ?IncludeGeneratedAnswer = null,

    /// Indicates whether Q indicies are included or excluded.
    include_quick_sight_q_index: ?IncludeQuickSightQIndex = null,

    /// The number of maximum topics to be considered to predict QA results.
    max_topics_to_consider: ?i32 = null,

    /// The query text to be used to predict QA results.
    query_text: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .include_generated_answer = "IncludeGeneratedAnswer",
        .include_quick_sight_q_index = "IncludeQuickSightQIndex",
        .max_topics_to_consider = "MaxTopicsToConsider",
        .query_text = "QueryText",
    };
};

pub const PredictQAResultsOutput = struct {
    /// Additional visual responses.
    additional_results: ?[]const QAResult = null,

    /// The primary visual response.
    primary_result: ?QAResult = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .additional_results = "AdditionalResults",
        .primary_result = "PrimaryResult",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PredictQAResultsInput, options: CallOptions) !PredictQAResultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PredictQAResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/qa/predict");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.include_generated_answer) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeGeneratedAnswer\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_quick_sight_q_index) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludeQuickSightQIndex\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_topics_to_consider) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxTopicsToConsider\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"QueryText\":");
    try aws.json.writeValue(@TypeOf(input.query_text), input.query_text, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PredictQAResultsOutput {
    var result: PredictQAResultsOutput = try aws.json.parseJsonObject(
        PredictQAResultsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
