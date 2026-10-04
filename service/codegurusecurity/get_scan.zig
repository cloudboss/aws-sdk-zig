const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetScanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-security", "CodeGuru Security", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/scans/");
    try path_buf.appendSlice(allocator, input.scan_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.run_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "runId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetScanOutput {
    var result: GetScanOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetScanOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
