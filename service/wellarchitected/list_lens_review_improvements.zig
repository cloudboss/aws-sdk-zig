const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QuestionPriority = @import("question_priority.zig").QuestionPriority;
const ImprovementSummary = @import("improvement_summary.zig").ImprovementSummary;

pub const ListLensReviewImprovementsInput = struct {
    lens_alias: []const u8,

    /// The maximum number of results to return for this request.
    max_results: ?i32 = null,

    milestone_number: ?i32 = null,

    next_token: ?[]const u8 = null,

    pillar_id: ?[]const u8 = null,

    /// The priority of the question.
    question_priority: ?QuestionPriority = null,

    workload_id: []const u8,

    pub const json_field_names = .{
        .lens_alias = "LensAlias",
        .max_results = "MaxResults",
        .milestone_number = "MilestoneNumber",
        .next_token = "NextToken",
        .pillar_id = "PillarId",
        .question_priority = "QuestionPriority",
        .workload_id = "WorkloadId",
    };
};

pub const ListLensReviewImprovementsOutput = struct {
    improvement_summaries: ?[]const ImprovementSummary = null,

    lens_alias: ?[]const u8 = null,

    /// The ARN for the lens.
    lens_arn: ?[]const u8 = null,

    milestone_number: ?i32 = null,

    next_token: ?[]const u8 = null,

    workload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .improvement_summaries = "ImprovementSummaries",
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .milestone_number = "MilestoneNumber",
        .next_token = "NextToken",
        .workload_id = "WorkloadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLensReviewImprovementsInput, options: CallOptions) !ListLensReviewImprovementsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLensReviewImprovementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloads/");
    try path_buf.appendSlice(allocator, input.workload_id);
    try path_buf.appendSlice(allocator, "/lensReviews/");
    try path_buf.appendSlice(allocator, input.lens_alias);
    try path_buf.appendSlice(allocator, "/improvements");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.milestone_number) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MilestoneNumber=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.pillar_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "PillarId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.question_priority) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "QuestionPriority=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLensReviewImprovementsOutput {
    var result: ListLensReviewImprovementsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListLensReviewImprovementsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
