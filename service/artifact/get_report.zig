const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetReportInput = struct {
    /// Unique resource ID for the report resource.
    report_id: []const u8,

    /// Version for the report resource.
    report_version: ?i64 = null,

    /// Unique download token provided by GetTermForReport API.
    term_token: []const u8,

    pub const json_field_names = .{
        .report_id = "reportId",
        .report_version = "reportVersion",
        .term_token = "termToken",
    };
};

pub const GetReportOutput = struct {
    /// Presigned S3 url to access the report content.
    document_presigned_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .document_presigned_url = "documentPresignedUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReportInput, options: CallOptions) !GetReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "artifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("artifact", "Artifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/report/get";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "reportId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.report_id);
    query_has_prev = true;
    if (input.report_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "reportVersion=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "termToken=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.term_token);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReportOutput {
    var result: GetReportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
