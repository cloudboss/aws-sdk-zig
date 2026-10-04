const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportReadSetDetail = @import("export_read_set_detail.zig").ExportReadSetDetail;
const ReadSetExportJobStatus = @import("read_set_export_job_status.zig").ReadSetExportJobStatus;

pub const GetReadSetExportJobInput = struct {
    /// The job's ID.
    id: []const u8,

    /// The job's sequence store ID.
    sequence_store_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .sequence_store_id = "sequenceStoreId",
    };
};

pub const GetReadSetExportJobOutput = struct {
    /// When the job completed.
    completion_time: ?i64 = null,

    /// When the job was created.
    creation_time: i64,

    /// The job's destination in Amazon S3.
    destination: []const u8,

    /// The job's ID.
    id: []const u8,

    /// The job's read sets.
    read_sets: ?[]const ExportReadSetDetail = null,

    /// The job's sequence store ID.
    sequence_store_id: []const u8,

    /// The job's status.
    status: ReadSetExportJobStatus,

    /// The job's status message.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .destination = "destination",
        .id = "id",
        .read_sets = "readSets",
        .sequence_store_id = "sequenceStoreId",
        .status = "status",
        .status_message = "statusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReadSetExportJobInput, options: CallOptions) !GetReadSetExportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReadSetExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.sequence_store_id);
    try path_buf.appendSlice(allocator, "/exportjob/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReadSetExportJobOutput {
    var result: GetReadSetExportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReadSetExportJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
