const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StepName = @import("step_name.zig").StepName;
const CodeReviewJobTaskSummary = @import("code_review_job_task_summary.zig").CodeReviewJobTaskSummary;

pub const ListCodeReviewJobTasksInput = struct {
    /// The unique identifier of the agent space.
    agent_space_id: []const u8,

    /// Filter tasks by category name.
    category_name: ?[]const u8 = null,

    /// The unique identifier of the code review job to list tasks for.
    code_review_job_id: ?[]const u8 = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value of this parameter to null for the first request. For subsequent
    /// calls, use the nextToken value returned from the previous request.
    next_token: ?[]const u8 = null,

    /// Filter tasks by step name.
    step_name: ?StepName = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .category_name = "categoryName",
        .code_review_job_id = "codeReviewJobId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .step_name = "stepName",
    };
};

pub const ListCodeReviewJobTasksOutput = struct {
    /// The list of code review job task summaries.
    code_review_job_task_summaries: ?[]const CodeReviewJobTaskSummary = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value of this parameter to null for the first request. For subsequent
    /// calls, use the nextToken value returned from the previous request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_review_job_task_summaries = "codeReviewJobTaskSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCodeReviewJobTasksInput, options: CallOptions) !ListCodeReviewJobTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCodeReviewJobTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListCodeReviewJobTasks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentSpaceId\":");
    try aws.json.writeValue(@TypeOf(input.agent_space_id), input.agent_space_id, allocator, &body_buf);
    has_prev = true;
    if (input.category_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"categoryName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.code_review_job_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"codeReviewJobId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.step_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stepName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCodeReviewJobTasksOutput {
    const result: ListCodeReviewJobTasksOutput = try aws.json.parseJsonObject(
        ListCodeReviewJobTasksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
