const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailureCategory = @import("failure_category.zig").FailureCategory;
const FindingSeverity = @import("finding_severity.zig").FindingSeverity;
const FindingStatus = @import("finding_status.zig").FindingStatus;
const FindingSummary = @import("finding_summary.zig").FindingSummary;

pub const ListFailureModeFindingsInput = struct {
    /// Filter findings by failure category.
    failure_category: ?FailureCategory = null,

    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    service_arn: []const u8,

    /// Filter findings by severity.
    severity: ?FindingSeverity = null,

    /// Filter findings by status.
    status: ?FindingStatus = null,

    pub const json_field_names = .{
        .failure_category = "failureCategory",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .service_arn = "serviceArn",
        .severity = "severity",
        .status = "status",
    };
};

pub const ListFailureModeFindingsOutput = struct {
    /// The list of finding summaries.
    findings_summary: ?[]const FindingSummary = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings_summary = "findingsSummary",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFailureModeFindingsInput, options: CallOptions) !ListFailureModeFindingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFailureModeFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/list-failure-mode-findings";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.failure_category) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "failureCategory=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    if (input.severity) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "severity=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFailureModeFindingsOutput {
    const result: ListFailureModeFindingsOutput = try aws.json.parseJsonObject(
        ListFailureModeFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
