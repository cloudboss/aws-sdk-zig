const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetAssetPropertyValueHistoryEntry = @import("batch_get_asset_property_value_history_entry.zig").BatchGetAssetPropertyValueHistoryEntry;
const BatchGetAssetPropertyValueHistoryErrorEntry = @import("batch_get_asset_property_value_history_error_entry.zig").BatchGetAssetPropertyValueHistoryErrorEntry;
const BatchGetAssetPropertyValueHistorySkippedEntry = @import("batch_get_asset_property_value_history_skipped_entry.zig").BatchGetAssetPropertyValueHistorySkippedEntry;
const BatchGetAssetPropertyValueHistorySuccessEntry = @import("batch_get_asset_property_value_history_success_entry.zig").BatchGetAssetPropertyValueHistorySuccessEntry;

pub const BatchGetAssetPropertyValueHistoryInput = struct {
    /// The list of asset property historical value entries for the batch get
    /// request. You can
    /// specify up to 16 entries per request.
    entries: []const BatchGetAssetPropertyValueHistoryEntry,

    /// The maximum number of results to return for each paginated request. A result
    /// set is returned in the two cases, whichever occurs
    /// first.
    ///
    /// * The size of the result set is equal to 4 MB.
    ///
    /// * The number of data points in the result set is equal to the value of
    /// `maxResults`. The maximum value of `maxResults` is 20000.
    max_results: ?i32 = null,

    /// The token to be used for the next set of paginated results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entries = "entries",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const BatchGetAssetPropertyValueHistoryOutput = struct {
    /// A list of the errors (if any) associated with the batch request. Each error
    /// entry
    /// contains the `entryId` of the entry that failed.
    error_entries: ?[]const BatchGetAssetPropertyValueHistoryErrorEntry = null,

    /// The token for the next set of results, or null if there are no additional
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of entries that were not processed by this batch request.
    /// because these entries had been completely processed by previous paginated
    /// requests.
    /// Each skipped entry contains the `entryId` of the entry that skipped.
    skipped_entries: ?[]const BatchGetAssetPropertyValueHistorySkippedEntry = null,

    /// A list of entries that were processed successfully by this batch request.
    /// Each success entry
    /// contains the `entryId` of the entry that succeeded and the latest query
    /// result.
    success_entries: ?[]const BatchGetAssetPropertyValueHistorySuccessEntry = null,

    pub const json_field_names = .{
        .error_entries = "errorEntries",
        .next_token = "nextToken",
        .skipped_entries = "skippedEntries",
        .success_entries = "successEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetAssetPropertyValueHistoryInput, options: CallOptions) !BatchGetAssetPropertyValueHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetAssetPropertyValueHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/properties/batch/history";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entries\":");
    try aws.json.writeValue(@TypeOf(input.entries), input.entries, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetAssetPropertyValueHistoryOutput {
    var result: BatchGetAssetPropertyValueHistoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetAssetPropertyValueHistoryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
