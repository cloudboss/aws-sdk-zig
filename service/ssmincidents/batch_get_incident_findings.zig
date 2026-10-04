const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetIncidentFindingsError = @import("batch_get_incident_findings_error.zig").BatchGetIncidentFindingsError;
const Finding = @import("finding.zig").Finding;

pub const BatchGetIncidentFindingsInput = struct {
    /// A list of IDs of findings for which you want to view details.
    finding_ids: []const []const u8,

    /// The Amazon Resource Name (ARN) of the incident for which you want to view
    /// finding
    /// details.
    incident_record_arn: []const u8,

    pub const json_field_names = .{
        .finding_ids = "findingIds",
        .incident_record_arn = "incidentRecordArn",
    };
};

pub const BatchGetIncidentFindingsOutput = struct {
    /// A list of errors encountered during the operation.
    errors: ?[]const BatchGetIncidentFindingsError = null,

    /// Information about the requested findings.
    findings: ?[]const Finding = null,

    pub const json_field_names = .{
        .errors = "errors",
        .findings = "findings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetIncidentFindingsInput, options: CallOptions) !BatchGetIncidentFindingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetIncidentFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-incidents", "SSM Incidents", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/batchGetIncidentFindings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"findingIds\":");
    try aws.json.writeValue(@TypeOf(input.finding_ids), input.finding_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"incidentRecordArn\":");
    try aws.json.writeValue(@TypeOf(input.incident_record_arn), input.incident_record_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetIncidentFindingsOutput {
    const result: BatchGetIncidentFindingsOutput = try aws.json.parseJsonObject(
        BatchGetIncidentFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
