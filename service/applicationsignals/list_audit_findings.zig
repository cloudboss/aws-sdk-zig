const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AuditTarget = @import("audit_target.zig").AuditTarget;
const DetailLevel = @import("detail_level.zig").DetailLevel;
const AuditFinding = @import("audit_finding.zig").AuditFinding;

pub const ListAuditFindingsInput = struct {
    /// A list of auditor names to filter the findings by. Only findings generated
    /// by the specified auditors will be returned.
    ///
    /// The following auditors are available for configuration:
    ///
    /// * `slo` - SloAuditor: Identifies SLO violations and detects breached
    ///   thresholds during the Assessment phase.
    /// * `operation_metric` - OperationMetricAuditor: Detects anomalies in service
    ///   operation metrics from Application Signals RED metrics during the
    ///   Assessment phase
    ///
    /// Anomaly detection is not supported for sparse metrics (those missing more
    /// than 80% of datapoints within the given time period).
    /// * `service_quota` - ServiceQuotaAuditor: Monitors resource utilization
    ///   against service quotas during the Assessment phase
    /// * `trace` - TraceAuditor: Performs deep-dive analysis of distributed traces,
    ///   correlating traces with breached SLOs or abnormal RED metrics during the
    ///   Analysis phase
    /// * `dependency_metric` - CriticalPathAuditor: Analyzes service dependency
    ///   impacts and maps dependency relationships from Application Signals RED
    ///   metrics during the Analysis phase
    /// * `top_contributor` - TopContributorAuditor: Identifies infrastructure-level
    ///   contributors to issues by analyzing EMF logs of Application Signals RED
    ///   metrics during the Analysis phase
    /// * `log` - LogAuditor: Extracts insights from application logs, categorizing
    ///   error types and ranking severity by frequency during the Analysis phase
    ///
    /// `InitAuditor` and `Summarizer` auditors are not configurable as they are
    /// automatically triggered during the audit process.
    auditors: ?[]const []const u8 = null,

    /// A list of audit targets to filter the findings by. You can specify services,
    /// SLOs, or service operations to limit the audit findings to specific
    /// entities.
    audit_targets: []const AuditTarget,

    /// The level of details of the audit findings. Supported values: `BRIEF`,
    /// `DETAILED`.
    detail_level: ?DetailLevel = null,

    /// The end of the time period to retrieve audit findings for. When used in a
    /// raw HTTP Query API, it is formatted as epoch time in seconds. For example,
    /// `1698778057`
    end_time: i64,

    /// The maximum number of audit findings to return in one operation. If you omit
    /// this parameter, the default of 10 is used.
    max_results: ?i32 = null,

    /// Include this value, if it was returned by the previous operation, to get the
    /// next set of audit findings.
    next_token: ?[]const u8 = null,

    /// The start of the time period to retrieve audit findings for. When used in a
    /// raw HTTP Query API, it is formatted as epoch time in seconds. For example,
    /// `1698778057`
    start_time: i64,

    pub const json_field_names = .{
        .auditors = "Auditors",
        .audit_targets = "AuditTargets",
        .detail_level = "DetailLevel",
        .end_time = "EndTime",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const ListAuditFindingsOutput = struct {
    /// An array of structures, where each structure contains information about one
    /// audit finding, including the auditor results, severity, and associated
    /// metric and dependency graphs.
    audit_findings: ?[]const AuditFinding = null,

    /// The end of the time period that the returned audit findings apply to. When
    /// used in a raw HTTP Query API, it is formatted as epoch time in seconds. For
    /// example, `1698778057`
    end_time: ?i64 = null,

    /// Include this value in your next use of this API to get the next set of audit
    /// findings.
    next_token: ?[]const u8 = null,

    /// The start of the time period that the returned audit findings apply to. When
    /// used in a raw HTTP Query API, it is formatted as epoch time in seconds. For
    /// example, `1698778057`
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .audit_findings = "AuditFindings",
        .end_time = "EndTime",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAuditFindingsInput, options: Options) !ListAuditFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationsignals");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListAuditFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationsignals", "Application Signals", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/auditFindings";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "EndTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "StartTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auditors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Auditors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AuditTargets\":");
    try aws.json.writeValue(@TypeOf(input.audit_targets), input.audit_targets, allocator, &body_buf);
    has_prev = true;
    if (input.detail_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DetailLevel\":");
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAuditFindingsOutput {
    var result: ListAuditFindingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAuditFindingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
