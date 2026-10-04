const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingIdentifier = @import("finding_identifier.zig").FindingIdentifier;
const BatchGetFindingsError = @import("batch_get_findings_error.zig").BatchGetFindingsError;
const Finding = @import("finding.zig").Finding;

pub const BatchGetFindingsInput = struct {
    /// A list of finding identifiers. Each identifier consists of a `scanName` and
    /// a `findingId`. You retrieve the `findingId` when you call `GetFindings`.
    finding_identifiers: []const FindingIdentifier,

    pub const json_field_names = .{
        .finding_identifiers = "findingIdentifiers",
    };
};

pub const BatchGetFindingsOutput = struct {
    /// A list of errors for individual findings which were not fetched. Each
    /// BatchGetFindingsError contains the `scanName`, `findingId`, `errorCode` and
    /// error `message`.
    failed_findings: ?[]const BatchGetFindingsError = null,

    /// A list of all findings which were successfully fetched.
    findings: ?[]const Finding = null,

    pub const json_field_names = .{
        .failed_findings = "failedFindings",
        .findings = "findings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetFindingsInput, options: CallOptions) !BatchGetFindingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-security", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-security", "CodeGuru Security", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/batchGetFindings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"findingIdentifiers\":");
    try aws.json.writeValue(@TypeOf(input.finding_identifiers), input.finding_identifiers, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetFindingsOutput {
    const result: BatchGetFindingsOutput = try aws.json.parseJsonObject(
        BatchGetFindingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
