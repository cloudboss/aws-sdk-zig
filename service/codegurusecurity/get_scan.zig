const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AnalysisType = @import("analysis_type.zig").AnalysisType;
const ScanState = @import("scan_state.zig").ScanState;

pub const GetScanInput = struct {
    /// UUID that identifies the individual scan run you want to view details about.
    /// You retrieve this when you call the `CreateScan` operation. Defaults to the
    /// latest scan run if missing.
    run_id: ?[]const u8 = null,

    /// The name of the scan you want to view details about.
    scan_name: []const u8,

    pub const json_field_names = .{
        .run_id = "runId",
        .scan_name = "scanName",
    };
};

pub const GetScanOutput = struct {
    /// The type of analysis CodeGuru Security performed in the scan, either
    /// `Security` or `All`. The `Security` type only generates findings related to
    /// security. The `All` type generates both security findings and quality
    /// findings.
    analysis_type: AnalysisType,

    /// The time the scan was created.
    created_at: i64,

    /// Details about the error that causes a scan to fail to be retrieved.
    error_message: ?[]const u8 = null,

    /// The number of times a scan has been re-run on a revised resource.
    number_of_revisions: ?i64 = null,

    /// UUID that identifies the individual scan run.
    run_id: []const u8,

    /// The name of the scan.
    scan_name: []const u8,

    /// The ARN for the scan name.
    scan_name_arn: ?[]const u8 = null,

    /// The current state of the scan. Returns either `InProgress`, `Successful`, or
    /// `Failed`.
    scan_state: ScanState,

    /// The time when the scan was last updated. Only available for `STANDARD` scan
    /// types.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .analysis_type = "analysisType",
        .created_at = "createdAt",
        .error_message = "errorMessage",
        .number_of_revisions = "numberOfRevisions",
        .run_id = "runId",
        .scan_name = "scanName",
        .scan_name_arn = "scanNameArn",
        .scan_state = "scanState",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetScanInput, options: CallOptions) !GetScanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codegurusecurity");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetScanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codegurusecurity", "CodeGuru Security", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/scans/");
    try path_buf.appendSlice(allocator, input.scan_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.run_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "runId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetScanOutput {
    var result: GetScanOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetScanOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
