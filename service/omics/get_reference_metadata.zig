const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReferenceCreationType = @import("reference_creation_type.zig").ReferenceCreationType;
const ReferenceFiles = @import("reference_files.zig").ReferenceFiles;
const ReferenceStatus = @import("reference_status.zig").ReferenceStatus;

pub const GetReferenceMetadataInput = struct {
    /// The reference's ID.
    id: []const u8,

    /// The reference's reference store ID.
    reference_store_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .reference_store_id = "referenceStoreId",
    };
};

pub const GetReferenceMetadataOutput = struct {
    /// The reference's ARN.
    arn: []const u8,

    /// The reference's creation job ID.
    creation_job_id: ?[]const u8 = null,

    /// When the reference was created.
    creation_time: i64,

    /// The reference's creation type.
    creation_type: ?ReferenceCreationType = null,

    /// The reference's description.
    description: ?[]const u8 = null,

    /// The reference's files.
    files: ?ReferenceFiles = null,

    /// The reference's ID.
    id: []const u8,

    /// The reference's MD5 checksum.
    md_5: []const u8,

    /// The reference's name.
    name: ?[]const u8 = null,

    /// The reference's reference store ID.
    reference_store_id: []const u8,

    /// The reference's status.
    status: ?ReferenceStatus = null,

    /// When the reference was updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_job_id = "creationJobId",
        .creation_time = "creationTime",
        .creation_type = "creationType",
        .description = "description",
        .files = "files",
        .id = "id",
        .md_5 = "md5",
        .name = "name",
        .reference_store_id = "referenceStoreId",
        .status = "status",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReferenceMetadataInput, options: CallOptions) !GetReferenceMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReferenceMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/referencestore/");
    try path_buf.appendSlice(allocator, input.reference_store_id);
    try path_buf.appendSlice(allocator, "/reference/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReferenceMetadataOutput {
    const result: GetReferenceMetadataOutput = try aws.json.parseJsonObject(
        GetReferenceMetadataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
