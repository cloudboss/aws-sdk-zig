const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CodeSecurityResource = @import("code_security_resource.zig").CodeSecurityResource;
const CodeScanStatus = @import("code_scan_status.zig").CodeScanStatus;

pub const GetCodeSecurityScanInput = struct {
    /// The resource identifier for the code repository that was scanned.
    resource: CodeSecurityResource,

    /// The unique identifier of the scan to retrieve.
    scan_id: []const u8,

    pub const json_field_names = .{
        .resource = "resource",
        .scan_id = "scanId",
    };
};

pub const GetCodeSecurityScanOutput = struct {
    /// The Amazon Web Services account ID associated with the scan.
    account_id: ?[]const u8 = null,

    /// The timestamp when the scan was created.
    created_at: ?i64 = null,

    /// The identifier of the last commit that was scanned. This is only returned if
    /// the scan
    /// was successful or skipped.
    last_commit_id: ?[]const u8 = null,

    /// The resource identifier for the code repository that was scanned.
    resource: ?CodeSecurityResource = null,

    /// The unique identifier of the scan.
    scan_id: ?[]const u8 = null,

    /// The current status of the scan.
    status: ?CodeScanStatus = null,

    /// The reason for the current status of the scan.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the scan was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .created_at = "createdAt",
        .last_commit_id = "lastCommitId",
        .resource = "resource",
        .scan_id = "scanId",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCodeSecurityScanInput, options: CallOptions) !GetCodeSecurityScanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCodeSecurityScanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesecurity/scan/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resource\":");
    try aws.json.writeValue(@TypeOf(input.resource), input.resource, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scanId\":");
    try aws.json.writeValue(@TypeOf(input.scan_id), input.scan_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCodeSecurityScanOutput {
    var result: GetCodeSecurityScanOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCodeSecurityScanOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
