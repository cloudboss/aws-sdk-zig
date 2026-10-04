const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceSyncJobStatus = @import("data_source_sync_job_status.zig").DataSourceSyncJobStatus;
const DataSourceSyncJob = @import("data_source_sync_job.zig").DataSourceSyncJob;

pub const ListDataSourceSyncJobsInput = struct {
    /// The identifier of the Amazon Q Business application connected to the data
    /// source.
    application_id: []const u8,

    /// The identifier of the data source connector.
    data_source_id: []const u8,

    /// The end time of the data source connector sync.
    end_time: ?i64 = null,

    /// The identifier of the index used with the Amazon Q Business data source
    /// connector.
    index_id: []const u8,

    /// The maximum number of synchronization jobs to return in the response.
    max_results: ?i32 = null,

    /// If the `maxResults` response was incpmplete because there is more data to
    /// retriever, Amazon Q Business returns a pagination token in the response. You
    /// can use this pagination token to retrieve the next set of responses.
    next_token: ?[]const u8 = null,

    /// The start time of the data source connector sync.
    start_time: ?i64 = null,

    /// Only returns synchronization jobs with the `Status` field equal to the
    /// specified status.
    status_filter: ?DataSourceSyncJobStatus = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .end_time = "endTime",
        .index_id = "indexId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .start_time = "startTime",
        .status_filter = "statusFilter",
    };
};

pub const ListDataSourceSyncJobsOutput = struct {
    /// A history of synchronization jobs for the data source connector.
    history: ?[]const DataSourceSyncJob = null,

    /// If the response is truncated, Amazon Q Business returns this token. You can
    /// use this token in any subsequent request to retrieve the next set of jobs.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .history = "history",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDataSourceSyncJobsInput, options: CallOptions) !ListDataSourceSyncJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDataSourceSyncJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/datasources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    try path_buf.appendSlice(allocator, "/syncjobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.end_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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
    if (input.start_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.status_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "syncStatus=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDataSourceSyncJobsOutput {
    var result: ListDataSourceSyncJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDataSourceSyncJobsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
