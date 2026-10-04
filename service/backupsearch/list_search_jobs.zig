const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchJobState = @import("search_job_state.zig").SearchJobState;
const SearchJobSummary = @import("search_job_summary.zig").SearchJobSummary;

pub const ListSearchJobsInput = struct {
    /// Include this parameter to filter list by search job status.
    by_status: ?SearchJobState = null,

    /// The maximum number of resource list items to be returned.
    max_results: ?i32 = null,

    /// The next item following a partial list of returned search jobs.
    ///
    /// For example, if a request is made to return `MaxResults` number of backups,
    /// `NextToken` allows you to return more items in your list starting at the
    /// location pointed to by the next token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .by_status = "ByStatus",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListSearchJobsOutput = struct {
    /// The next item following a partial list of returned backups included in a
    /// search job.
    ///
    /// For example, if a request is made to return `MaxResults` number of backups,
    /// `NextToken` allows you to return more items in your list starting at the
    /// location pointed to by the next token.
    next_token: ?[]const u8 = null,

    /// The search jobs among the list, with details of the returned search jobs.
    search_jobs: ?[]const SearchJobSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .search_jobs = "SearchJobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSearchJobsInput, options: CallOptions) !ListSearchJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup-search", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSearchJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup-search", "BackupSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/search-jobs";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.by_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Status=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSearchJobsOutput {
    const result: ListSearchJobsOutput = try aws.json.parseJsonObject(
        ListSearchJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
