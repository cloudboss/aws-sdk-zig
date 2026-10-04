const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListCommentsItem = @import("list_comments_item.zig").ListCommentsItem;

pub const ListCommentsInput = struct {
    /// Required element for ListComments to designate the case to query.
    case_id: []const u8,

    /// Optional element for ListComments to limit the number of responses.
    max_results: ?i32 = null,

    /// An optional string that, if supplied, must be copied from the output of a
    /// previous call to ListComments. When provided in this manner, the API fetches
    /// the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .case_id = "caseId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListCommentsOutput = struct {
    /// Response element for ListComments providing the body, commentID, createDate,
    /// creator, lastUpdatedBy and lastUpdatedDate for each response.
    items: ?[]const ListCommentsItem = null,

    /// An optional string that, if supplied on subsequent calls to ListComments,
    /// allows the API to fetch the next page of results.
    next_token: ?[]const u8 = null,

    /// Response element for ListComments identifying the number of responses.
    total: ?i32 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
        .total = "total",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCommentsInput, options: CallOptions) !ListCommentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCommentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/list-comments");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCommentsOutput {
    var result: ListCommentsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListCommentsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
