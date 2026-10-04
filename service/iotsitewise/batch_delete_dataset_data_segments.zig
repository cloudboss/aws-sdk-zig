const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteDataSegmentEntry = @import("delete_data_segment_entry.zig").DeleteDataSegmentEntry;
const FailedDataSegmentDeletion = @import("failed_data_segment_deletion.zig").FailedDataSegmentDeletion;

pub const BatchDeleteDatasetDataSegmentsInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// request is
    /// idempotent. If you retry a request that completed successfully using the
    /// same client token,
    /// the retry succeeds without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The ID of the session dataset from which to delete data segments.
    dataset_id: []const u8,

    /// The list of data segment entries to delete.
    delete_data_segment_entries: []const DeleteDataSegmentEntry,

    /// The name of the workspace that contains the dataset.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .dataset_id = "datasetId",
        .delete_data_segment_entries = "deleteDataSegmentEntries",
        .workspace_name = "workspaceName",
    };
};

pub const BatchDeleteDatasetDataSegmentsOutput = struct {
    /// The ID of the dataset.
    dataset_id: []const u8,

    /// The version of the dataset after deletion.
    dataset_version: []const u8,

    /// A list of data segment deletions that failed.
    errors: ?[]const FailedDataSegmentDeletion = null,

    pub const json_field_names = .{
        .dataset_id = "datasetId",
        .dataset_version = "datasetVersion",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteDatasetDataSegmentsInput, options: CallOptions) !BatchDeleteDatasetDataSegmentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteDatasetDataSegmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    try path_buf.appendSlice(allocator, "/data-segments/batch-delete");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deleteDataSegmentEntries\":");
    try aws.json.writeValue(@TypeOf(input.delete_data_segment_entries), input.delete_data_segment_entries, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workspaceName\":");
    try aws.json.writeValue(@TypeOf(input.workspace_name), input.workspace_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteDatasetDataSegmentsOutput {
    const result: BatchDeleteDatasetDataSegmentsOutput = try aws.json.parseJsonObject(
        BatchDeleteDatasetDataSegmentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
