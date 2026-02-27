const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ExportSpecification = @import("export_specification.zig").ExportSpecification;
const ExportJobStatus = @import("export_job_status.zig").ExportJobStatus;

pub const GetSearchResultExportJobInput = struct {
    /// This is the unique string that identifies a specific export job.
    ///
    /// Required for this operation.
    export_job_identifier: []const u8,

    pub const json_field_names = .{
        .export_job_identifier = "ExportJobIdentifier",
    };
};

pub const GetSearchResultExportJobOutput = struct {
    /// The date and time that an export job completed, in Unix format and
    /// Coordinated Universal Time (UTC). The value of `CreationTime` is accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018 12:11:30.087 AM.
    completion_time: ?i64 = null,

    /// The date and time that an export job was created, in Unix format and
    /// Coordinated Universal Time (UTC). The value of `CreationTime` is accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018 12:11:30.087 AM.
    creation_time: ?i64 = null,

    /// The unique Amazon Resource Name (ARN) that uniquely identifies the export
    /// job.
    export_job_arn: ?[]const u8 = null,

    /// This is the unique string that identifies the specified export job.
    export_job_identifier: []const u8,

    /// The export specification consists of the destination S3 bucket to which the
    /// search results were exported, along with the destination prefix.
    export_specification: ?ExportSpecification = null,

    /// The unique string that identifies the Amazon Resource Name (ARN) of the
    /// specified search job.
    search_job_arn: ?[]const u8 = null,

    /// This is the current status of the export job.
    status: ?ExportJobStatus = null,

    /// A status message is a string that is returned for search job with a status
    /// of `FAILED`, along with steps to remedy and retry the operation.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .export_job_arn = "ExportJobArn",
        .export_job_identifier = "ExportJobIdentifier",
        .export_specification = "ExportSpecification",
        .search_job_arn = "SearchJobArn",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSearchResultExportJobInput, options: Options) !GetSearchResultExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "backupsearch");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetSearchResultExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backupsearch", "BackupSearch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/export-search-jobs/");
    try path_buf.appendSlice(alloc, input.export_job_identifier);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetSearchResultExportJobOutput {
    var result: GetSearchResultExportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSearchResultExportJobOutput, body, alloc);
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
