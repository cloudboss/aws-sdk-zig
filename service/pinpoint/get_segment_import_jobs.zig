const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportJobsResponse = @import("import_jobs_response.zig").ImportJobsResponse;

pub const GetSegmentImportJobsInput = struct {
    /// The unique identifier for the application. This identifier is displayed as
    /// the **Project ID** on the Amazon Pinpoint console.
    application_id: []const u8,

    /// The maximum number of items to include in each page of a paginated response.
    /// This parameter is not supported for application, campaign, and journey
    /// metrics.
    page_size: ?[]const u8 = null,

    /// The unique identifier for the segment.
    segment_id: []const u8,

    /// The NextToken string that specifies which page of results to return in a
    /// paginated response.
    token: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .page_size = "PageSize",
        .segment_id = "SegmentId",
        .token = "Token",
    };
};

pub const GetSegmentImportJobsOutput = struct {
    import_jobs_response: ?ImportJobsResponse = null,

    pub const json_field_names = .{
        .import_jobs_response = "ImportJobsResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSegmentImportJobsInput, options: CallOptions) !GetSegmentImportJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mobiletargeting", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSegmentImportJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pinpoint", "Pinpoint", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/apps/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/segments/");
    try path_buf.appendSlice(allocator, input.segment_id);
    try path_buf.appendSlice(allocator, "/jobs/import");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "page-size=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "token=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSegmentImportJobsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: GetSegmentImportJobsOutput = .{};

    return result;
}
