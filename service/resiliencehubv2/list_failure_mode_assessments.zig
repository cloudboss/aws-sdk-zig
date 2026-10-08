const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentStatus = @import("assessment_status.zig").AssessmentStatus;
const AssessmentSortField = @import("assessment_sort_field.zig").AssessmentSortField;
const SortOrder = @import("sort_order.zig").SortOrder;
const AssessmentSummary = @import("assessment_summary.zig").AssessmentSummary;

pub const ListFailureModeAssessmentsInput = struct {
    /// Specifies the assessment statuses to include in the results.
    assessment_statuses: ?[]const AssessmentStatus = null,

    /// Specifies that only assessments that ended at or before this timestamp
    /// appear in the results.
    ended_before: ?i64 = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    service_arn: []const u8,

    /// The field to use for sorting failure mode assessments.
    sort_by: ?AssessmentSortField = null,

    /// The sort order for results.
    sort_order: ?SortOrder = null,

    /// Specifies that only assessments that started at or after this timestamp
    /// appear in the results.
    started_after: ?i64 = null,

    pub const json_field_names = .{
        .assessment_statuses = "assessmentStatuses",
        .ended_before = "endedBefore",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .service_arn = "serviceArn",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
        .started_after = "startedAfter",
    };
};

pub const ListFailureModeAssessmentsOutput = struct {
    /// The list of assessment summaries.
    assessment_summaries: ?[]const AssessmentSummary = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_summaries = "assessmentSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFailureModeAssessmentsInput, options: CallOptions) !ListFailureModeAssessmentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFailureModeAssessmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/list-failure-mode-assessments";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.assessment_statuses) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "assessmentStatuses=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.ended_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endedBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "serviceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.service_arn);
    query_has_prev = true;
    if (input.sort_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortOrder=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.started_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startedAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFailureModeAssessmentsOutput {
    const result: ListFailureModeAssessmentsOutput = try aws.json.parseJsonObject(
        ListFailureModeAssessmentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
