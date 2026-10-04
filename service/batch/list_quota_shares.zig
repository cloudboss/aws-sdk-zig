const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "batch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQuotaSharesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/listquotashares";

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQuotaSharesOutput {
    const result: ListQuotaSharesOutput = try aws.json.parseJsonObject(
        ListQuotaSharesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
