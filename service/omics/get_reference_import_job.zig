const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportReferenceSourceItem = @import("import_reference_source_item.zig").ImportReferenceSourceItem;
const ReferenceImportJobStatus = @import("reference_import_job_status.zig").ReferenceImportJobStatus;

pub const GetReferenceImportJobInput = struct {
    /// The job's ID.
    id: []const u8,

    /// The job's reference store ID.
    reference_store_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .reference_store_id = "referenceStoreId",
    };
};

pub const GetReferenceImportJobOutput = struct {
    /// When the job completed.
    completion_time: ?i64 = null,

    /// When the job was created.
    creation_time: i64,

    /// The job's ID.
    id: []const u8,

    /// The job's reference store ID.
    reference_store_id: []const u8,

    /// The job's service role ARN.
    role_arn: []const u8,

    /// The job's source files.
    sources: ?[]const ImportReferenceSourceItem = null,

    /// The job's status.
    status: ReferenceImportJobStatus,

    /// The job's status message.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .id = "id",
        .reference_store_id = "referenceStoreId",
        .role_arn = "roleArn",
        .sources = "sources",
        .status = "status",
        .status_message = "statusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReferenceImportJobInput, options: CallOptions) !GetReferenceImportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetReferenceImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/referencestore/");
    try path_buf.appendSlice(allocator, input.reference_store_id);
    try path_buf.appendSlice(allocator, "/importjob/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetReferenceImportJobOutput {
    const result: GetReferenceImportJobOutput = try aws.json.parseJsonObject(
        GetReferenceImportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
