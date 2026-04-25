const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const QuotaShareDetail = @import("quota_share_detail.zig").QuotaShareDetail;

pub const ListQuotaSharesInput = struct {
    /// The name or full Amazon Resource Name (ARN) of the job queue used to list
    /// quota shares.
    job_queue: []const u8,

    /// The maximum number of results returned by `ListQuotaShares` in
    /// paginated output. When this parameter is used, `ListQuotaShares` only
    /// returns `maxResults` results in a single page and a `nextToken` response
    /// element. You can see the remaining results of the initial request by sending
    /// another
    /// `ListQuotaShares` request with the returned `nextToken` value.
    /// This value can be between 1 and 100. If this parameter isn't
    /// used, `ListQuotaShares` returns up to 100 results and a
    /// `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value that's returned from a previous paginated
    /// `ListQuotaShares` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the
    /// previous results that returned the `nextToken` value. This value is
    /// `null` when there are no more results to return.
    ///
    /// Treat this token as an opaque identifier that's only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_queue = "jobQueue",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListQuotaSharesOutput = struct {
    /// The `nextToken` value to include in a future
    /// `ListQuotaShares` request. When the results of a
    /// `ListQuotaShares` request exceed `maxResults`, this value can
    /// be used to retrieve the next page of results. This value is `null` when
    /// there are
    /// no more results to return.
    next_token: ?[]const u8 = null,

    /// A list of quota shares that match the request.
    quota_shares: ?[]const QuotaShareDetail = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .quota_shares = "quotaShares",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQuotaSharesInput, options: CallOptions) !ListQuotaSharesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQuotaSharesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/listquotashares";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobQueue\":");
    try aws.json.writeValue(@TypeOf(input.job_queue), input.job_queue, allocator, &body_buf);
    has_prev = true;
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQuotaSharesOutput {
    var result: ListQuotaSharesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListQuotaSharesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
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
