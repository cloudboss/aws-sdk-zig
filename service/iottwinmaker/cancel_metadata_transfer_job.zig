const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataTransferJobProgress = @import("metadata_transfer_job_progress.zig").MetadataTransferJobProgress;
const MetadataTransferJobStatus = @import("metadata_transfer_job_status.zig").MetadataTransferJobStatus;

pub const CancelMetadataTransferJobInput = struct {
    /// The metadata transfer job Id.
    metadata_transfer_job_id: []const u8,

    pub const json_field_names = .{
        .metadata_transfer_job_id = "metadataTransferJobId",
    };
};

pub const CancelMetadataTransferJobOutput = struct {
    /// The metadata transfer job ARN.
    arn: []const u8,

    /// The metadata transfer job Id.
    metadata_transfer_job_id: []const u8,

    /// The metadata transfer job's progress.
    progress: ?MetadataTransferJobProgress = null,

    /// The metadata transfer job's status.
    status: ?MetadataTransferJobStatus = null,

    /// Used to update the DateTime property.
    update_date_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .metadata_transfer_job_id = "metadataTransferJobId",
        .progress = "progress",
        .status = "status",
        .update_date_time = "updateDateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelMetadataTransferJobInput, options: CallOptions) !CancelMetadataTransferJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelMetadataTransferJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/metadata-transfer-jobs/");
    try path_buf.appendSlice(allocator, input.metadata_transfer_job_id);
    try path_buf.appendSlice(allocator, "/cancel");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelMetadataTransferJobOutput {
    const result: CancelMetadataTransferJobOutput = try aws.json.parseJsonObject(
        CancelMetadataTransferJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
