const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IssueDestination = @import("issue_destination.zig").IssueDestination;
const BatchExportFindingError = @import("batch_export_finding_error.zig").BatchExportFindingError;
const BatchExportFindingResult = @import("batch_export_finding_result.zig").BatchExportFindingResult;

pub const BatchExportFindingsInput = struct {
    /// The identifier of the agent space where the job exists.
    agent_space_id: []const u8,

    /// The identifier of the code review job. This parameter is mutually exclusive
    /// with `pentestJobId`.
    code_review_job_id: ?[]const u8 = null,

    /// The identifiers of the findings to export. Each must belong to the specified
    /// job.
    finding_ids: []const []const u8,

    /// The destination issue-tracker project the findings are exported to. Must be
    /// a connected capability of the agent space.
    issue_destination: IssueDestination,

    /// The identifier of the penetration test job. This parameter is mutually
    /// exclusive with `codeReviewJobId`.
    pentest_job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .code_review_job_id = "codeReviewJobId",
        .finding_ids = "findingIds",
        .issue_destination = "issueDestination",
        .pentest_job_id = "pentestJobId",
    };
};

pub const BatchExportFindingsOutput = struct {
    /// The findings whose issue could not be created, each with a customer-facing
    /// reason.
    errors: ?[]const BatchExportFindingError = null,

    /// The findings whose issue was created, each with its linked issue.
    results: ?[]const BatchExportFindingResult = null,

    pub const json_field_names = .{
        .errors = "errors",
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchExportFindingsInput, options: CallOptions) !BatchExportFindingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchExportFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchExportFindings";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"findingIds\":");
    try aws.json.writeValue(@TypeOf(input.finding_ids), input.finding_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"issueDestination\":");
    try aws.json.writeValue(@TypeOf(input.issue_destination), input.issue_destination, allocator, &body_buf);
    has_prev = true;
    if (input.pentest_job_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"pentestJobId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchExportFindingsOutput {
    const result: BatchExportFindingsOutput = try aws.json.parseJsonObject(
        BatchExportFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
