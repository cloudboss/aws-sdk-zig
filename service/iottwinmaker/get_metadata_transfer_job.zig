const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const MetadataTransferJobProgress = @import("metadata_transfer_job_progress.zig").MetadataTransferJobProgress;
const SourceConfiguration = @import("source_configuration.zig").SourceConfiguration;
const MetadataTransferJobStatus = @import("metadata_transfer_job_status.zig").MetadataTransferJobStatus;

pub const GetMetadataTransferJobInput = struct {
    /// The metadata transfer job Id.
    metadata_transfer_job_id: []const u8,

    pub const json_field_names = .{
        .metadata_transfer_job_id = "metadataTransferJobId",
    };
};

pub const GetMetadataTransferJobOutput = struct {
    /// The metadata transfer job ARN.
    arn: []const u8,

    /// The metadata transfer job's creation DateTime property.
    creation_date_time: i64,

    /// The metadata transfer job description.
    description: ?[]const u8 = null,

    /// The metadata transfer job's destination.
    destination: ?DestinationConfiguration = null,

    /// The metadata transfer job Id.
    metadata_transfer_job_id: []const u8,

    /// The metadata transfer job's role.
    metadata_transfer_job_role: []const u8,

    /// The metadata transfer job's progress.
    progress: ?MetadataTransferJobProgress = null,

    /// The metadata transfer job's report URL.
    report_url: ?[]const u8 = null,

    /// The metadata transfer job's sources.
    sources: ?[]const SourceConfiguration = null,

    /// The metadata transfer job's status.
    status: ?MetadataTransferJobStatus = null,

    /// The metadata transfer job's update DateTime property.
    update_date_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .destination = "destination",
        .metadata_transfer_job_id = "metadataTransferJobId",
        .metadata_transfer_job_role = "metadataTransferJobRole",
        .progress = "progress",
        .report_url = "reportUrl",
        .sources = "sources",
        .status = "status",
        .update_date_time = "updateDateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetadataTransferJobInput, options: CallOptions) !GetMetadataTransferJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMetadataTransferJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/metadata-transfer-jobs/");
    try path_buf.appendSlice(allocator, input.metadata_transfer_job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMetadataTransferJobOutput {
    const result: GetMetadataTransferJobOutput = try aws.json.parseJsonObject(
        GetMetadataTransferJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
