const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;
const AuditFinding = @import("audit_finding.zig").AuditFinding;

pub const ListAuditFindingsInput = struct {
    /// A filter to limit results to the findings for the specified audit check.
    check_name: ?[]const u8 = null,

    /// A filter to limit results to those found before the specified time. You must
    /// specify either the startTime and endTime or the taskId, but not both.
    end_time: ?i64 = null,

    /// Boolean flag indicating whether only the suppressed findings or the
    /// unsuppressed findings should be listed. If this parameter isn't provided,
    /// the response will list both suppressed and unsuppressed findings.
    list_suppressed_findings: ?bool = null,

    /// The maximum number of results to return at one time. The default is 25.
    max_results: ?i32 = null,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// Information identifying the noncompliant resource.
    resource_identifier: ?ResourceIdentifier = null,

    /// A filter to limit results to those found after the specified time. You must
    /// specify either the startTime and endTime or the taskId, but not both.
    start_time: ?i64 = null,

    /// A filter to limit results to the audit with the specified ID. You must
    /// specify either the taskId or the startTime and endTime, but not both.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .check_name = "checkName",
        .end_time = "endTime",
        .list_suppressed_findings = "listSuppressedFindings",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_identifier = "resourceIdentifier",
        .start_time = "startTime",
        .task_id = "taskId",
    };
};

pub const ListAuditFindingsOutput = struct {
    /// The findings (results) of the audit.
    findings: ?[]const AuditFinding = null,

    /// A token that can be used to retrieve the next set of results, or `null`
    /// if there are no additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings = "findings",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAuditFindingsInput, options: CallOptions) !ListAuditFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAuditFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/findings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.check_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"checkName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.end_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.list_suppressed_findings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"listSuppressedFindings\":");
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
    if (input.resource_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.start_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"startTime\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.task_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"taskId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAuditFindingsOutput {
    var result: ListAuditFindingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAuditFindingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
