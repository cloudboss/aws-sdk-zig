const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AwsSecurityFindingFilters = @import("aws_security_finding_filters.zig").AwsSecurityFindingFilters;
const SortCriterion = @import("sort_criterion.zig").SortCriterion;
const AwsSecurityFinding = @import("aws_security_finding.zig").AwsSecurityFinding;

pub const GetFindingsInput = struct {
    /// The finding attributes used to define a condition to filter the returned
    /// findings.
    ///
    /// You can filter by up to 10 finding attributes. For each attribute, you can
    /// provide up to
    /// 20 filter values.
    ///
    /// Note that in the available filter fields, `WorkflowState` is deprecated. To
    /// search for a finding based on its workflow status, use `WorkflowStatus`.
    filters: ?AwsSecurityFindingFilters = null,

    /// The maximum number of findings to return.
    max_results: ?i32 = null,

    /// The token that is required for pagination. On your first call to the
    /// `GetFindings` operation, set the value of this parameter to
    /// `NULL`.
    ///
    /// For subsequent calls to the operation, to continue listing data, set the
    /// value of this
    /// parameter to the value returned from the previous response.
    next_token: ?[]const u8 = null,

    /// The finding attributes used to sort the list of returned findings.
    sort_criteria: ?[]const SortCriterion = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_criteria = "SortCriteria",
    };
};

pub const GetFindingsOutput = struct {
    /// The findings that matched the filters specified in the request.
    findings: ?[]const AwsSecurityFinding = null,

    /// The pagination token to use to request the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings = "Findings",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingsInput, options: CallOptions) !GetFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
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
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SortCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingsOutput {
    const result: GetFindingsOutput = try aws.json.parseJsonObject(
        GetFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
