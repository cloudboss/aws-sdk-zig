const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReadSetMetadataInput, options: Options) !GetReadSetMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "omics");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetReadSetMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/sequencestore/");
    try path_buf.appendSlice(alloc, input.sequence_store_id);
    try path_buf.appendSlice(alloc, "/readset/");
    try path_buf.appendSlice(alloc, input.id);
    try path_buf.appendSlice(alloc, "/metadata");
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetReadSetMetadataOutput {
    var result: GetReadSetMetadataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetReadSetMetadataOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotSupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .not_supported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RangeNotSatisfiableException")) {
        return .{ .arena = arena, .kind = .{ .range_not_satisfiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .request_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
