const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CheckSummary = @import("check_summary.zig").CheckSummary;

pub const ListCheckSummariesInput = struct {
    choice_id: []const u8,

    /// Well-Architected Lens ARN.
    lens_arn: []const u8,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    pillar_id: []const u8,

    question_id: []const u8,

    workload_id: []const u8,

    pub const json_field_names = .{
        .choice_id = "ChoiceId",
        .lens_arn = "LensArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pillar_id = "PillarId",
        .question_id = "QuestionId",
        .workload_id = "WorkloadId",
    };
};

pub const ListCheckSummariesOutput = struct {
    /// List of Trusted Advisor summaries related to the Well-Architected best
    /// practice.
    check_summaries: ?[]const CheckSummary = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .check_summaries = "CheckSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCheckSummariesInput, options: CallOptions) !ListCheckSummariesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCheckSummariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloads/");
    try path_buf.appendSlice(allocator, input.workload_id);
    try path_buf.appendSlice(allocator, "/checkSummaries");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChoiceId\":");
    try aws.json.writeValue(@TypeOf(input.choice_id), input.choice_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LensArn\":");
    try aws.json.writeValue(@TypeOf(input.lens_arn), input.lens_arn, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PillarId\":");
    try aws.json.writeValue(@TypeOf(input.pillar_id), input.pillar_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"QuestionId\":");
    try aws.json.writeValue(@TypeOf(input.question_id), input.question_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCheckSummariesOutput {
    const result: ListCheckSummariesOutput = try aws.json.parseJsonObject(
        ListCheckSummariesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
