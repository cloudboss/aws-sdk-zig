const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfilingGroupDescription = @import("profiling_group_description.zig").ProfilingGroupDescription;

pub const ListProfilingGroupsInput = struct {
    /// A `Boolean` value indicating whether to include a description. If `true`,
    /// then a list of
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html) objects
    /// that contain detailed information about profiling groups is returned. If
    /// `false`, then
    /// a list of profiling group names is returned.
    include_description: ?bool = null,

    /// The maximum number of profiling groups results returned by
    /// `ListProfilingGroups`
    /// in paginated output. When this parameter is used, `ListProfilingGroups` only
    /// returns
    /// `maxResults` results in a single page along with a `nextToken` response
    /// element. The remaining results of the initial request
    /// can be seen by sending another `ListProfilingGroups` request with the
    /// returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListProfilingGroups` request where `maxResults` was used and the results
    /// exceeded the value of that parameter. Pagination continues from the end of
    /// the previous results
    /// that returned the `nextToken` value.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve
    /// the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_description = "includeDescription",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListProfilingGroupsOutput = struct {
    /// The `nextToken` value to include in a future `ListProfilingGroups` request.
    /// When the results of a `ListProfilingGroups` request exceed `maxResults`,
    /// this
    /// value can be used to retrieve the next page of results. This value is `null`
    /// when there are no more
    /// results to return.
    next_token: ?[]const u8 = null,

    /// A returned list of profiling group names. A list of the names is returned
    /// only if
    /// `includeDescription` is `false`, otherwise a list of
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html) objects
    /// is returned.
    profiling_group_names: ?[]const []const u8 = null,

    /// A returned list
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html)
    /// objects. A list of
    /// [
    /// `ProfilingGroupDescription`
    /// ](https://docs.aws.amazon.com/codeguru/latest/profiler-api/API_ProfilingGroupDescription.html)
    /// objects is returned only if `includeDescription` is `true`, otherwise a list
    /// of profiling group names is returned.
    profiling_groups: ?[]const ProfilingGroupDescription = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .profiling_group_names = "profilingGroupNames",
        .profiling_groups = "profilingGroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProfilingGroupsInput, options: CallOptions) !ListProfilingGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeguru-profiler", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProfilingGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguru-profiler", "CodeGuruProfiler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/profilingGroups";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_description) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeDescription=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProfilingGroupsOutput {
    var result: ListProfilingGroupsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListProfilingGroupsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
