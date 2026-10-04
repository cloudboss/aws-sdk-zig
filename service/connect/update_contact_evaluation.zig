const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluationAnswerInput = @import("evaluation_answer_input.zig").EvaluationAnswerInput;
const EvaluationNote = @import("evaluation_note.zig").EvaluationNote;
const EvaluatorUserUnion = @import("evaluator_user_union.zig").EvaluatorUserUnion;

pub const UpdateContactEvaluationInput = struct {
    /// A map of question identifiers to answer value.
    answers: ?[]const aws.map.MapEntry(EvaluationAnswerInput) = null,

    /// A unique identifier for the contact evaluation.
    evaluation_id: []const u8,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// A map of question identifiers to note value.
    notes: ?[]const aws.map.MapEntry(EvaluationNote) = null,

    /// The ID of the user who updated the contact evaluation.
    updated_by: ?EvaluatorUserUnion = null,

    pub const json_field_names = .{
        .answers = "Answers",
        .evaluation_id = "EvaluationId",
        .instance_id = "InstanceId",
        .notes = "Notes",
        .updated_by = "UpdatedBy",
    };
};

pub const UpdateContactEvaluationOutput = struct {
    /// The Amazon Resource Name (ARN) for the contact evaluation resource.
    evaluation_arn: []const u8,

    /// A unique identifier for the contact evaluation.
    evaluation_id: []const u8,

    pub const json_field_names = .{
        .evaluation_arn = "EvaluationArn",
        .evaluation_id = "EvaluationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContactEvaluationInput, options: CallOptions) !UpdateContactEvaluationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContactEvaluationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contact-evaluations/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.evaluation_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.answers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Answers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Notes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.updated_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UpdatedBy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContactEvaluationOutput {
    const result: UpdateContactEvaluationOutput = try aws.json.parseJsonObject(
        UpdateContactEvaluationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
