const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ImportDataFormat = @import("import_data_format.zig").ImportDataFormat;
const ImportJobStatus = @import("import_job_status.zig").ImportJobStatus;

pub const GetAddressListImportJobInput = struct {
    /// The identifier of the import job that needs to be retrieved.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const GetAddressListImportJobOutput = struct {
    /// The unique identifier of the address list the import job was created for.
    address_list_id: []const u8,

    /// The timestamp of when the import job was completed.
    completed_timestamp: ?i64 = null,

    /// The timestamp of when the import job was created.
    created_timestamp: i64,

    /// The reason for failure of an import job.
    @"error": ?[]const u8 = null,

    /// The number of input addresses that failed to be imported into the address
    /// list.
    failed_items_count: ?i32 = null,

    /// The format of the input for an import job.
    import_data_format: ?ImportDataFormat = null,

    /// The number of input addresses successfully imported into the address list.
    imported_items_count: ?i32 = null,

    /// The identifier of the import job.
    job_id: []const u8,

    /// A user-friendly name for the import job.
    name: []const u8,

    /// The pre-signed URL target for uploading the input file.
    pre_signed_url: []const u8,

    /// The timestamp of when the import job was started.
    start_timestamp: ?i64 = null,

    /// The status of the import job.
    status: ImportJobStatus,

    pub const json_field_names = .{
        .address_list_id = "AddressListId",
        .completed_timestamp = "CompletedTimestamp",
        .created_timestamp = "CreatedTimestamp",
        .@"error" = "Error",
        .failed_items_count = "FailedItemsCount",
        .import_data_format = "ImportDataFormat",
        .imported_items_count = "ImportedItemsCount",
        .job_id = "JobId",
        .name = "Name",
        .pre_signed_url = "PreSignedUrl",
        .start_timestamp = "StartTimestamp",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAddressListImportJobInput, options: Options) !GetAddressListImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mailmanager");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetAddressListImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mailmanager", "MailManager", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "MailManagerSvc.GetAddressListImportJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetAddressListImportJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAddressListImportJobOutput, body, alloc);
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
