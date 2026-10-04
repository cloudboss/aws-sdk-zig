const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceAttachmentSummary = @import("data_source_attachment_summary.zig").DataSourceAttachmentSummary;

pub const ListDataSourceAttachmentsInput = struct {
    /// The unique identifier or name of the OpenSearch application to list
    /// attachments for.
    id: []const u8,

    /// The maximum number of results to return per page. The default is 50.
    max_results: ?i32 = null,

    /// The pagination token from a previous call to retrieve the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListDataSourceAttachmentsOutput = struct {
    /// A list of data source attachment summaries for the specified application.
    attachments: ?[]const DataSourceAttachmentSummary = null,

    /// The pagination token to use in a subsequent call to retrieve the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachments = "attachments",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataSourceAttachmentsInput, options: CallOptions) !ListDataSourceAttachmentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataSourceAttachmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/application/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/listDataSourceAttachments");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataSourceAttachmentsOutput {
    const result: ListDataSourceAttachmentsOutput = try aws.json.parseJsonObject(
        ListDataSourceAttachmentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
