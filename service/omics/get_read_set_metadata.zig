const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreationType = @import("creation_type.zig").CreationType;
const ETag = @import("e_tag.zig").ETag;
const ReadSetFiles = @import("read_set_files.zig").ReadSetFiles;
const FileType = @import("file_type.zig").FileType;
const SequenceInformation = @import("sequence_information.zig").SequenceInformation;
const ReadSetStatus = @import("read_set_status.zig").ReadSetStatus;

pub const GetReadSetMetadataInput = struct {
    /// The read set's ID.
    id: []const u8,

    /// The read set's sequence store ID.
    sequence_store_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .sequence_store_id = "sequenceStoreId",
    };
};

pub const GetReadSetMetadataOutput = struct {
    /// The read set's ARN.
    arn: []const u8,

    /// The read set's creation job ID.
    creation_job_id: ?[]const u8 = null,

    /// When the read set was created.
    creation_time: i64,

    /// The creation type of the read set.
    creation_type: ?CreationType = null,

    /// The read set's description.
    description: ?[]const u8 = null,

    /// The entity tag (ETag) is a hash of the object meant to represent its
    /// semantic content.
    etag: ?ETag = null,

    /// The read set's files.
    files: ?ReadSetFiles = null,

    /// The read set's file type.
    file_type: FileType,

    /// The read set's ID.
    id: []const u8,

    /// The read set's name.
    name: ?[]const u8 = null,

    /// The read set's genome reference ARN.
    reference_arn: ?[]const u8 = null,

    /// The read set's sample ID.
    sample_id: ?[]const u8 = null,

    /// The read set's sequence information.
    sequence_information: ?SequenceInformation = null,

    /// The read set's sequence store ID.
    sequence_store_id: []const u8,

    /// The read set's status.
    status: ReadSetStatus,

    /// The status message for a read set. It provides more detail as to why the
    /// read set has a status.
    status_message: ?[]const u8 = null,

    /// The read set's subject ID.
    subject_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_job_id = "creationJobId",
        .creation_time = "creationTime",
        .creation_type = "creationType",
        .description = "description",
        .etag = "etag",
        .files = "files",
        .file_type = "fileType",
        .id = "id",
        .name = "name",
        .reference_arn = "referenceArn",
        .sample_id = "sampleId",
        .sequence_information = "sequenceInformation",
        .sequence_store_id = "sequenceStoreId",
        .status = "status",
        .status_message = "statusMessage",
        .subject_id = "subjectId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReadSetMetadataInput, options: CallOptions) !GetReadSetMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReadSetMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.sequence_store_id);
    try path_buf.appendSlice(allocator, "/readset/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/metadata");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReadSetMetadataOutput {
    var result: GetReadSetMetadataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReadSetMetadataOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
