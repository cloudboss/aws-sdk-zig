const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ImportFileTaskStatus = @import("import_file_task_status.zig").ImportFileTaskStatus;

pub const GetImportFileTaskInput = struct {
    /// The ID of the import file task. This ID is returned in the response of
    /// StartImportFileTask.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetImportFileTaskOutput = struct {
    /// The time that the import task completed.
    completion_time: ?i64 = null,

    /// The import file task `id` returned in the response of StartImportFileTask.
    id: ?[]const u8 = null,

    /// The name of the import task given in StartImportFileTask.
    import_name: ?[]const u8 = null,

    /// The S3 bucket where import file is located.
    input_s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key name of the import file.
    input_s3_key: ?[]const u8 = null,

    /// The number of records that failed to be imported.
    number_of_records_failed: ?i32 = null,

    /// The number of records successfully imported.
    number_of_records_success: ?i32 = null,

    /// Start time of the import task.
    start_time: ?i64 = null,

    /// Status of import file task.
    status: ?ImportFileTaskStatus = null,

    /// The S3 bucket name for status report of import task.
    status_report_s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key name for status report of import task. The report contains
    /// details about
    /// whether each record imported successfully or why it did not.
    status_report_s3_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .id = "id",
        .import_name = "importName",
        .input_s3_bucket = "inputS3Bucket",
        .input_s3_key = "inputS3Key",
        .number_of_records_failed = "numberOfRecordsFailed",
        .number_of_records_success = "numberOfRecordsSuccess",
        .start_time = "startTime",
        .status = "status",
        .status_report_s3_bucket = "statusReportS3Bucket",
        .status_report_s3_key = "statusReportS3Key",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImportFileTaskInput, options: Options) !GetImportFileTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "migrationhubstrategy");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetImportFileTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhubstrategy", "MigrationHubStrategy", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/get-import-file-task/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImportFileTaskOutput {
    var result: GetImportFileTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetImportFileTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
    if (std.mem.eql(u8, error_code, "DependencyException")) {
        return .{ .arena = arena, .kind = .{ .dependency_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleLockClientException")) {
        return .{ .arena = arena, .kind = .{ .service_linked_role_lock_client_exception = .{
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
