const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetFindingMetricsInput = struct {
    /// The end of the day-aligned UTC window, inclusive.
    end_date: i64,

    /// The membership ID to retrieve metrics for.
    membership_id: []const u8,

    /// The start of the day-aligned UTC window, inclusive.
    start_date: i64,

    pub const json_field_names = .{
        .end_date = "endDate",
        .membership_id = "membershipId",
        .start_date = "startDate",
    };
};

pub const GetFindingMetricsOutput = struct {
    /// The number of findings escalated during the requested date range.
    findings_escalated: i64,

    /// The number of escalated findings that were closed as false positives during
    /// the requested date range.
    findings_escalated_false_positive: i64,

    /// The number of findings whose escalation was in progress during the requested
    /// date range.
    findings_escalated_in_progress: i64,

    /// The number of findings ingested from Amazon GuardDuty during the requested
    /// date range.
    findings_ingested_guard_duty: i64,

    /// The number of findings ingested from AWS Security Hub during the requested
    /// date range.
    findings_ingested_security_hub: i64,

    /// The number of findings investigated during the requested date range.
    findings_investigated: i64,

    /// The number of investigated findings that were closed as false positives
    /// during the requested date range.
    findings_investigated_false_positive: i64,

    /// The number of findings whose investigation was in progress during the
    /// requested date range.
    findings_investigated_in_progress: i64,

    /// The number of findings triaged during the requested date range.
    findings_triaged: i64,

    /// The number of triaged findings that were closed as false positives during
    /// the requested date range.
    findings_triaged_false_positive: i64,

    /// The number of findings confirmed as true positives during the requested date
    /// range.
    findings_true_positive: i64,

    pub const json_field_names = .{
        .findings_escalated = "findingsEscalated",
        .findings_escalated_false_positive = "findingsEscalatedFalsePositive",
        .findings_escalated_in_progress = "findingsEscalatedInProgress",
        .findings_ingested_guard_duty = "findingsIngestedGuardDuty",
        .findings_ingested_security_hub = "findingsIngestedSecurityHub",
        .findings_investigated = "findingsInvestigated",
        .findings_investigated_false_positive = "findingsInvestigatedFalsePositive",
        .findings_investigated_in_progress = "findingsInvestigatedInProgress",
        .findings_triaged = "findingsTriaged",
        .findings_triaged_false_positive = "findingsTriagedFalsePositive",
        .findings_true_positive = "findingsTruePositive",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFindingMetricsInput, options: CallOptions) !GetFindingMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFindingMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/membership/");
    try path_buf.appendSlice(allocator, input.membership_id);
    try path_buf.appendSlice(allocator, "/finding-metrics");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endDate=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_date}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "startDate=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_date}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFindingMetricsOutput {
    const result: GetFindingMetricsOutput = try aws.json.parseJsonObject(
        GetFindingMetricsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
