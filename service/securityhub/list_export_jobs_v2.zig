const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportDataType = @import("export_data_type.zig").ExportDataType;
const ExportStatus = @import("export_status.zig").ExportStatus;
const ExportSummary = @import("export_summary.zig").ExportSummary;

pub const ListExportJobsV2Input = struct {
    /// Filters the results to export jobs that produce the specified data type.
    data_type: ?ExportDataType = null,

    /// The maximum number of results to return in a single call. Valid range is
    /// 1–20.
    max_results: ?i32 = null,

    /// The token required for pagination.
    /// On your first call, set the value of this parameter to `NULL`.
    /// For subsequent calls, to continue listing data, set the value of this
    /// parameter to the value returned in the previous response.
    next_token: ?[]const u8 = null,

    /// Filters the results to export jobs that have the specified status.
    status: ?ExportStatus = null,

    pub const json_field_names = .{
        .data_type = "DataType",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const ListExportJobsV2Output = struct {
    /// The export jobs that match the request, as `ExportSummary` objects.
    items: ?[]const ExportSummary = null,

    /// The pagination token to use to request the next page of results. Otherwise,
    /// this parameter is null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExportJobsV2Input, options: CallOptions) !ListExportJobsV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExportJobsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/exportjobsv2";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.data_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "DataType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Status=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExportJobsV2Output {
    const result: ListExportJobsV2Output = try aws.json.parseJsonObject(
        ListExportJobsV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
