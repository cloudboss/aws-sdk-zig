const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingSummary = @import("finding_summary.zig").FindingSummary;

pub const ListIncidentFindingsInput = struct {
    /// The Amazon Resource Name (ARN) of the incident for which you want to view
    /// associated
    /// findings.
    incident_record_arn: []const u8,

    /// The maximum number of findings to retrieve per call.
    max_results: ?i32 = null,

    /// The pagination token for the next set of items to return. (You received this
    /// token from a
    /// previous call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .incident_record_arn = "incidentRecordArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListIncidentFindingsOutput = struct {
    /// A list of findings that represent deployments that might be the potential
    /// cause of the
    /// incident.
    findings: ?[]const FindingSummary = null,

    /// The pagination token to use when requesting the next set of items. If there
    /// are no
    /// additional items to return, the string is null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings = "findings",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIncidentFindingsInput, options: CallOptions) !ListIncidentFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-incidents", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIncidentFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listIncidentFindings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"incidentRecordArn\":");
    try aws.json.writeValue(@TypeOf(input.incident_record_arn), input.incident_record_arn, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIncidentFindingsOutput {
    const result: ListIncidentFindingsOutput = try aws.json.parseJsonObject(
        ListIncidentFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
