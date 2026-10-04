const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentTargetFilter = @import("assessment_target_filter.zig").AssessmentTargetFilter;
const FrameworkFilters = @import("framework_filters.zig").FrameworkFilters;
const AssessmentSummary = @import("assessment_summary.zig").AssessmentSummary;

pub const ListAssessmentsInput = struct {
    /// Filters the list of assessments to those performed against a specific entity
    /// or
    /// change set.
    assessment_target_filter: ?AssessmentTargetFilter = null,

    /// The catalog related to the request. Fixed value: `AWSMarketplace`
    catalog: []const u8,

    /// Framework-specific filters. Set exactly one member to filter results to
    /// assessments
    /// performed against that framework.
    framework_filters: ?FrameworkFilters = null,

    /// The unique identifier of a framework. When specified, only assessments
    /// performed
    /// against this framework are returned. For example, `AMISecurity`.
    framework_id: ?[]const u8 = null,

    /// Specifies the upper limit of the elements on a single page. If a value isn't
    /// provided,
    /// the default value is 20. Valid values range from 1 to 100.
    max_results: ?i32 = null,

    /// The value of the next token, if it exists. `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_target_filter = "AssessmentTargetFilter",
        .catalog = "Catalog",
        .framework_filters = "FrameworkFilters",
        .framework_id = "FrameworkId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListAssessmentsOutput = struct {
    /// An array of `AssessmentSummary` objects.
    assessment_summary_list: ?[]const AssessmentSummary = null,

    /// The value of the next token, if it exists. `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_summary_list = "AssessmentSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAssessmentsInput, options: CallOptions) !ListAssessmentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAssessmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("catalog.marketplace", "Marketplace Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListAssessments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.assessment_target_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AssessmentTargetFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Catalog\":");
    try aws.json.writeValue(@TypeOf(input.catalog), input.catalog, allocator, &body_buf);
    has_prev = true;
    if (input.framework_filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FrameworkFilters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.framework_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FrameworkId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAssessmentsOutput {
    const result: ListAssessmentsOutput = try aws.json.parseJsonObject(
        ListAssessmentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
