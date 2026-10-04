const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrder = @import("sort_order.zig").SortOrder;
const NotebookRunStatus = @import("notebook_run_status.zig").NotebookRunStatus;
const NotebookRunSummary = @import("notebook_run_summary.zig").NotebookRunSummary;

pub const ListNotebookRunsInput = struct {
    /// The identifier of the Amazon DataZone domain in which to list notebook runs.
    domain_identifier: []const u8,

    /// The maximum number of notebook runs to return in a single call. When the
    /// number of notebook runs exceeds the value of `MaxResults`, the response
    /// contains a `NextToken` value.
    max_results: ?i32 = null,

    /// When the number of notebook runs is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of notebook runs, the response
    /// includes a pagination token named `NextToken`. You can specify this
    /// `NextToken` value in a subsequent call to `ListNotebookRuns` to list the
    /// next set of notebook runs.
    next_token: ?[]const u8 = null,

    /// The identifier of the notebook to filter runs by.
    notebook_identifier: ?[]const u8 = null,

    /// The identifier of the project that owns the notebook runs.
    owning_project_identifier: []const u8,

    /// The identifier of the schedule to filter notebook runs by.
    schedule_identifier: ?[]const u8 = null,

    /// The sort order for the results.
    sort_order: ?SortOrder = null,

    /// The status to filter notebook runs by.
    status: ?NotebookRunStatus = null,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .notebook_identifier = "notebookIdentifier",
        .owning_project_identifier = "owningProjectIdentifier",
        .schedule_identifier = "scheduleIdentifier",
        .sort_order = "sortOrder",
        .status = "status",
    };
};

pub const ListNotebookRunsOutput = struct {
    /// The results of the `ListNotebookRuns` action.
    items: ?[]const NotebookRunSummary = null,

    /// When the number of notebook runs is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of notebook runs, the response
    /// includes a pagination token named `NextToken`. You can specify this
    /// `NextToken` value in a subsequent call to `ListNotebookRuns` to list the
    /// next set of notebook runs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotebookRunsInput, options: CallOptions) !ListNotebookRunsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotebookRunsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/notebook-runs");
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
    if (input.notebook_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "notebookIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "owningProjectIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.owning_project_identifier);
    query_has_prev = true;
    if (input.schedule_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "scheduleIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortOrder=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotebookRunsOutput {
    var result: ListNotebookRunsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListNotebookRunsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
