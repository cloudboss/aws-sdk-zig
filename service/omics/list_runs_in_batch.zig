const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubmissionStatus = @import("submission_status.zig").SubmissionStatus;
const RunBatchListItem = @import("run_batch_list_item.zig").RunBatchListItem;

pub const ListRunsInBatchInput = struct {
    /// The identifier portion of the run batch ARN.
    batch_id: []const u8,

    /// The maximum number of runs to return.
    max_items: ?i32 = null,

    /// Filter runs by the HealthOmics-generated run ID.
    run_id: ?[]const u8 = null,

    /// Filter runs by the customer-provided run setting ID.
    run_setting_id: ?[]const u8 = null,

    /// A pagination token returned from a prior `ListRunsInBatch` call.
    starting_token: ?[]const u8 = null,

    /// Filter runs by submission status.
    submission_status: ?SubmissionStatus = null,

    pub const json_field_names = .{
        .batch_id = "batchId",
        .max_items = "maxItems",
        .run_id = "runId",
        .run_setting_id = "runSettingId",
        .starting_token = "startingToken",
        .submission_status = "submissionStatus",
    };
};

pub const ListRunsInBatchOutput = struct {
    /// A pagination token to retrieve the next page of results. Absent when the
    /// last run has been returned.
    next_token: ?[]const u8 = null,

    /// A list of run entries in the batch. See `RunBatchListItem`.
    runs: ?[]const RunBatchListItem = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .runs = "runs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRunsInBatchInput, options: CallOptions) !ListRunsInBatchOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRunsInBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runBatch/");
    try path_buf.appendSlice(allocator, input.batch_id);
    try path_buf.appendSlice(allocator, "/run");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.run_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "runId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.run_setting_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "runSettingId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.starting_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startingToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.submission_status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "submissionStatus=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRunsInBatchOutput {
    const result: ListRunsInBatchOutput = try aws.json.parseJsonObject(
        ListRunsInBatchOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
