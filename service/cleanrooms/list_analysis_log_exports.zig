const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalysisLogExportStatus = @import("analysis_log_export_status.zig").AnalysisLogExportStatus;
const AnalysisLogExportSummary = @import("analysis_log_export_summary.zig").AnalysisLogExportSummary;

pub const ListAnalysisLogExportsInput = struct {
    /// A filter on the unique identifier of the protected query that the analysis
    /// logs were exported for.
    analysis_identifier: ?[]const u8 = null,

    /// The maximum number of results that are returned for an API request call. The
    /// service chooses a default number if you don't set one. The service might
    /// return a `nextToken` even if the `maxResults` value has not been met.
    max_results: ?i32 = null,

    /// A unique identifier for the membership to list analysis log exports for.
    /// Currently accepts the membership ID.
    membership_identifier: []const u8,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    /// A filter on the status of the analysis log export.
    status: ?AnalysisLogExportStatus = null,

    pub const json_field_names = .{
        .analysis_identifier = "analysisIdentifier",
        .max_results = "maxResults",
        .membership_identifier = "membershipIdentifier",
        .next_token = "nextToken",
        .status = "status",
    };
};

pub const ListAnalysisLogExportsOutput = struct {
    /// A list of analysis log exports.
    analysis_log_exports: ?[]const AnalysisLogExportSummary = null,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .analysis_log_exports = "analysisLogExports",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAnalysisLogExportsInput, options: CallOptions) !ListAnalysisLogExportsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAnalysisLogExportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/analysislogexports");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.analysis_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "analysisIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAnalysisLogExportsOutput {
    const result: ListAnalysisLogExportsOutput = try aws.json.parseJsonObject(
        ListAnalysisLogExportsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
