const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PutAssetPropertyValueEntry = @import("put_asset_property_value_entry.zig").PutAssetPropertyValueEntry;
const BatchPutAssetPropertyErrorEntry = @import("batch_put_asset_property_error_entry.zig").BatchPutAssetPropertyErrorEntry;

pub const BatchPutAssetPropertyValueInput = struct {
    /// This setting enables partial ingestion at entry-level. If set to `true`, we
    /// ingest all TQVs not resulting in an error. If set to `false`, an invalid TQV
    /// fails
    /// ingestion of the entire entry that contains it.
    enable_partial_entry_processing: ?bool = null,

    /// The list of asset property value entries for the batch put request. You can
    /// specify up to
    /// 10 entries per request.
    entries: []const PutAssetPropertyValueEntry,

    pub const json_field_names = .{
        .enable_partial_entry_processing = "enablePartialEntryProcessing",
        .entries = "entries",
    };
};

pub const BatchPutAssetPropertyValueOutput = struct {
    /// A list of the errors (if any) associated with the batch put request. Each
    /// error entry
    /// contains the `entryId` of the entry that failed.
    error_entries: ?[]const BatchPutAssetPropertyErrorEntry = null,

    pub const json_field_names = .{
        .error_entries = "errorEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchPutAssetPropertyValueInput, options: CallOptions) !BatchPutAssetPropertyValueOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchPutAssetPropertyValueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/properties";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.enable_partial_entry_processing) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enablePartialEntryProcessing\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entries\":");
    try aws.json.writeValue(@TypeOf(input.entries), input.entries, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchPutAssetPropertyValueOutput {
    const result: BatchPutAssetPropertyValueOutput = try aws.json.parseJsonObject(
        BatchPutAssetPropertyValueOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
