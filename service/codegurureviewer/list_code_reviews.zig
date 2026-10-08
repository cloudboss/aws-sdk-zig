const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderType = @import("provider_type.zig").ProviderType;
const JobState = @import("job_state.zig").JobState;
const Type = @import("type.zig").Type;
const CodeReviewSummary = @import("code_review_summary.zig").CodeReviewSummary;

pub const ListCodeReviewsInput = struct {
    /// The maximum number of results that are returned per call. The default is
    /// 100.
    max_results: ?i32 = null,

    /// If `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page. Keep all other arguments
    /// unchanged.
    next_token: ?[]const u8 = null,

    /// List of provider types for filtering that needs to be applied before
    /// displaying the
    /// result. For example, `providerTypes=[GitHub]` lists code reviews from
    /// GitHub.
    provider_types: ?[]const ProviderType = null,

    /// List of repository names for filtering that needs to be applied before
    /// displaying the
    /// result.
    repository_names: ?[]const []const u8 = null,

    /// List of states for filtering that needs to be applied before displaying the
    /// result. For
    /// example, `states=[Pending]` lists code reviews in the Pending state.
    ///
    /// The valid code review states are:
    ///
    /// * `Completed`: The code review is complete.
    ///
    /// * `Pending`: The code review started and has not completed or failed.
    ///
    /// * `Failed`: The code review failed.
    ///
    /// * `Deleting`: The code review is being deleted.
    states: ?[]const JobState = null,

    /// The type of code reviews to list in the response.
    type: Type,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .provider_types = "ProviderTypes",
        .repository_names = "RepositoryNames",
        .states = "States",
        .type = "Type",
    };
};

pub const ListCodeReviewsOutput = struct {
    /// A list of code reviews that meet the criteria of the request.
    code_review_summaries: ?[]const CodeReviewSummary = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_review_summaries = "CodeReviewSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCodeReviewsInput, options: CallOptions) !ListCodeReviewsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-reviewer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCodeReviewsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-reviewer", "CodeGuru Reviewer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codereviews";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    if (input.provider_types) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "ProviderTypes=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.repository_names) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "RepositoryNames=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.states) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "States=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "Type=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.type.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCodeReviewsOutput {
    const result: ListCodeReviewsOutput = try aws.json.parseJsonObject(
        ListCodeReviewsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
