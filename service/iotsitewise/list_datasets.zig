const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetTypeEnum = @import("dataset_type_enum.zig").DatasetTypeEnum;
const DatasetSourceType = @import("dataset_source_type.zig").DatasetSourceType;
const DatasetSummary = @import("dataset_summary.zig").DatasetSummary;

pub const ListDatasetsInput = struct {
    /// The type of dataset to filter by: a session dataset, a curated dataset, or a
    /// connection
    /// to an external datasource.
    dataset_type: ?DatasetTypeEnum = null,

    /// The maximum number of results to return for each paginated request.
    max_results: ?i32 = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    /// The type of data source for the dataset.
    source_type: DatasetSourceType,

    /// The name of the workspace to filter datasets by.
    workspace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_type = "datasetType",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .source_type = "sourceType",
        .workspace_name = "workspaceName",
    };
};

pub const ListDatasetsOutput = struct {
    /// A list that summarizes the dataset response.
    dataset_summaries: ?[]const DatasetSummary = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    /// The name of the workspace.
    workspace_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_summaries = "datasetSummaries",
        .next_token = "nextToken",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDatasetsInput, options: CallOptions) !ListDatasetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDatasetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/datasets";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.dataset_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "datasetType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "sourceType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.source_type.wireName());
    query_has_prev = true;
    if (input.workspace_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "workspaceName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDatasetsOutput {
    const result: ListDatasetsOutput = try aws.json.parseJsonObject(
        ListDatasetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
