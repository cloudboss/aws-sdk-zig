const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChoiceUpdate = @import("choice_update.zig").ChoiceUpdate;
const AnswerReason = @import("answer_reason.zig").AnswerReason;
const Answer = @import("answer.zig").Answer;

pub const UpdateAnswerInput = struct {
    /// A list of choices to update on a question in your workload. The String key
    /// corresponds to the choice ID to be updated.
    choice_updates: ?[]const aws.map.MapEntry(ChoiceUpdate) = null,

    is_applicable: ?bool = null,

    lens_alias: []const u8,

    notes: ?[]const u8 = null,

    question_id: []const u8,

    /// The reason why a question is not applicable to your workload.
    reason: ?AnswerReason = null,

    selected_choices: ?[]const []const u8 = null,

    workload_id: []const u8,

    pub const json_field_names = .{
        .choice_updates = "ChoiceUpdates",
        .is_applicable = "IsApplicable",
        .lens_alias = "LensAlias",
        .notes = "Notes",
        .question_id = "QuestionId",
        .reason = "Reason",
        .selected_choices = "SelectedChoices",
        .workload_id = "WorkloadId",
    };
};

pub const UpdateAnswerOutput = struct {
    answer: ?Answer = null,

    lens_alias: ?[]const u8 = null,

    /// The ARN for the lens.
    lens_arn: ?[]const u8 = null,

    workload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .answer = "Answer",
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .workload_id = "WorkloadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAnswerInput, options: CallOptions) !UpdateAnswerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAnswerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloads/");
    try path_buf.appendSlice(allocator, input.workload_id);
    try path_buf.appendSlice(allocator, "/lensReviews/");
    try path_buf.appendSlice(allocator, input.lens_alias);
    try path_buf.appendSlice(allocator, "/answers/");
    try path_buf.appendSlice(allocator, input.question_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.choice_updates) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChoiceUpdates\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.is_applicable) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IsApplicable\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Notes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Reason\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.selected_choices) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SelectedChoices\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAnswerOutput {
    var result: UpdateAnswerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAnswerOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
