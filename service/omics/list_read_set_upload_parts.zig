const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReadSetUploadPartListFilter = @import("read_set_upload_part_list_filter.zig").ReadSetUploadPartListFilter;
const ReadSetPartSource = @import("read_set_part_source.zig").ReadSetPartSource;
const ReadSetUploadPartListItem = @import("read_set_upload_part_list_item.zig").ReadSetUploadPartListItem;

pub const ListReadSetUploadPartsInput = struct {
    /// Attributes used to filter for a specific subset of read set part uploads.
    filter: ?ReadSetUploadPartListFilter = null,

    /// The maximum number of read set upload parts returned in a page.
    max_results: ?i32 = null,

    /// Next token returned in the response of a previous
    /// ListReadSetUploadPartsRequest call. Used to get the next page of results.
    next_token: ?[]const u8 = null,

    /// The source file for the upload part.
    part_source: ReadSetPartSource,

    /// The Sequence Store ID used for the multipart uploads.
    sequence_store_id: []const u8,

    /// The ID for the initiated multipart upload.
    upload_id: []const u8,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .part_source = "partSource",
        .sequence_store_id = "sequenceStoreId",
        .upload_id = "uploadId",
    };
};

pub const ListReadSetUploadPartsOutput = struct {
    /// Next token returned in the response of a previous ListReadSetUploadParts
    /// call. Used to get the next page of results.
    next_token: ?[]const u8 = null,

    /// An array of upload parts.
    parts: ?[]const ReadSetUploadPartListItem = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .parts = "parts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListReadSetUploadPartsInput, options: CallOptions) !ListReadSetUploadPartsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListReadSetUploadPartsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.sequence_store_id);
    try path_buf.appendSlice(allocator, "/upload/");
    try path_buf.appendSlice(allocator, input.upload_id);
    try path_buf.appendSlice(allocator, "/parts");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"partSource\":");
    try aws.json.writeValue(@TypeOf(input.part_source), input.part_source, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListReadSetUploadPartsOutput {
    var result: ListReadSetUploadPartsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListReadSetUploadPartsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
