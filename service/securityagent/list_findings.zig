const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfidenceLevel = @import("confidence_level.zig").ConfidenceLevel;
const RiskLevel = @import("risk_level.zig").RiskLevel;
const FindingStatus = @import("finding_status.zig").FindingStatus;
const FindingSummary = @import("finding_summary.zig").FindingSummary;

pub const ListFindingsInput = struct {
    /// The unique identifier of the agent space.
    agent_space_id: []const u8,

    /// The unique identifier of the code review job to list findings for. Mutually
    /// exclusive with pentestJobId.
    code_review_job_id: ?[]const u8 = null,

    /// Filter findings by confidence level.
    confidence: ?ConfidenceLevel = null,

    /// The maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// Filter findings by name.
    name: ?[]const u8 = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value of this parameter to null for the first request. For subsequent
    /// calls, use the nextToken value returned from the previous request.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the pentest job to list findings for.
    pentest_job_id: ?[]const u8 = null,

    /// Filter findings by risk level.
    risk_level: ?RiskLevel = null,

    /// Filter findings by risk type.
    risk_type: ?[]const u8 = null,

    /// Filter findings by status.
    status: ?FindingStatus = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .code_review_job_id = "codeReviewJobId",
        .confidence = "confidence",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .pentest_job_id = "pentestJobId",
        .risk_level = "riskLevel",
        .risk_type = "riskType",
        .status = "status",
    };
};

pub const ListFindingsOutput = struct {
    /// The list of finding summaries.
    findings_summaries: ?[]const FindingSummary = null,

    /// A token to use for paginating results that are returned in the response. Set
    /// the value of this parameter to null for the first request. For subsequent
    /// calls, use the nextToken value returned from the previous request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings_summaries = "findingsSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFindingsInput, options: CallOptions) !ListFindingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListFindings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentSpaceId\":");
    try aws.json.writeValue(@TypeOf(input.agent_space_id), input.agent_space_id, allocator, &body_buf);
    has_prev = true;
    if (input.code_review_job_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"codeReviewJobId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.confidence) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"confidence\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pentest_job_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"pentestJobId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.risk_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"riskLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.risk_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"riskType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFindingsOutput {
    const result: ListFindingsOutput = try aws.json.parseJsonObject(
        ListFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
