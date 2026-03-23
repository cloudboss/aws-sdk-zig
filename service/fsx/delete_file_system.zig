const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DeleteFileSystemLustreConfiguration = @import("delete_file_system_lustre_configuration.zig").DeleteFileSystemLustreConfiguration;
const DeleteFileSystemOpenZFSConfiguration = @import("delete_file_system_open_zfs_configuration.zig").DeleteFileSystemOpenZFSConfiguration;
const DeleteFileSystemWindowsConfiguration = @import("delete_file_system_windows_configuration.zig").DeleteFileSystemWindowsConfiguration;
const FileSystemLifecycle = @import("file_system_lifecycle.zig").FileSystemLifecycle;
const DeleteFileSystemLustreResponse = @import("delete_file_system_lustre_response.zig").DeleteFileSystemLustreResponse;
const DeleteFileSystemOpenZFSResponse = @import("delete_file_system_open_zfs_response.zig").DeleteFileSystemOpenZFSResponse;
const DeleteFileSystemWindowsResponse = @import("delete_file_system_windows_response.zig").DeleteFileSystemWindowsResponse;

pub const DeleteFileSystemInput = struct {
    /// A string of up to 63 ASCII characters that Amazon FSx uses to ensure
    /// idempotent deletion. This token is automatically filled on your behalf when
    /// using the
    /// Command Line Interface (CLI) or an Amazon Web Services SDK.
    client_request_token: ?[]const u8 = null,

    /// The ID of the file system that you want to delete.
    file_system_id: []const u8,

    lustre_configuration: ?DeleteFileSystemLustreConfiguration = null,

    /// The configuration object for the OpenZFS file system used in the
    /// `DeleteFileSystem` operation.
    open_zfs_configuration: ?DeleteFileSystemOpenZFSConfiguration = null,

    windows_configuration: ?DeleteFileSystemWindowsConfiguration = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .file_system_id = "FileSystemId",
        .lustre_configuration = "LustreConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .windows_configuration = "WindowsConfiguration",
    };
};

pub const DeleteFileSystemOutput = struct {
    /// The ID of the file system that's being deleted.
    file_system_id: ?[]const u8 = null,

    /// The file system lifecycle for the deletion request. If the
    /// `DeleteFileSystem` operation is successful, this status is
    /// `DELETING`.
    lifecycle: ?FileSystemLifecycle = null,

    lustre_response: ?DeleteFileSystemLustreResponse = null,

    /// The response object for the OpenZFS file system that's being deleted in the
    /// `DeleteFileSystem` operation.
    open_zfs_response: ?DeleteFileSystemOpenZFSResponse = null,

    windows_response: ?DeleteFileSystemWindowsResponse = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .lifecycle = "Lifecycle",
        .lustre_response = "LustreResponse",
        .open_zfs_response = "OpenZFSResponse",
        .windows_response = "WindowsResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFileSystemInput, options: CallOptions) !DeleteFileSystemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "fsx");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DeleteFileSystem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFileSystemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteFileSystemOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessPointAlreadyOwnedByYou")) {
        return .{ .arena = arena, .kind = .{ .access_point_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ActiveDirectoryError")) {
        return .{ .arena = arena, .kind = .{ .active_directory_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackupBeingCopied")) {
        return .{ .arena = arena, .kind = .{ .backup_being_copied = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackupInProgress")) {
        return .{ .arena = arena, .kind = .{ .backup_in_progress = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackupNotFound")) {
        return .{ .arena = arena, .kind = .{ .backup_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BackupRestoring")) {
        return .{ .arena = arena, .kind = .{ .backup_restoring = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequest")) {
        return .{ .arena = arena, .kind = .{ .bad_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryAssociationNotFound")) {
        return .{ .arena = arena, .kind = .{ .data_repository_association_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskEnded")) {
        return .{ .arena = arena, .kind = .{ .data_repository_task_ended = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskExecuting")) {
        return .{ .arena = arena, .kind = .{ .data_repository_task_executing = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskNotFound")) {
        return .{ .arena = arena, .kind = .{ .data_repository_task_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileCacheNotFound")) {
        return .{ .arena = arena, .kind = .{ .file_cache_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemNotFound")) {
        return .{ .arena = arena, .kind = .{ .file_system_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleParameterError")) {
        return .{ .arena = arena, .kind = .{ .incompatible_parameter_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleRegionForMultiAZ")) {
        return .{ .arena = arena, .kind = .{ .incompatible_region_for_multi_az = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAccessPoint")) {
        return .{ .arena = arena, .kind = .{ .invalid_access_point = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDataRepositoryType")) {
        return .{ .arena = arena, .kind = .{ .invalid_data_repository_type = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidDestinationKmsKey")) {
        return .{ .arena = arena, .kind = .{ .invalid_destination_kms_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidExportPath")) {
        return .{ .arena = arena, .kind = .{ .invalid_export_path = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidImportPath")) {
        return .{ .arena = arena, .kind = .{ .invalid_import_path = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNetworkSettings")) {
        return .{ .arena = arena, .kind = .{ .invalid_network_settings = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPerUnitStorageThroughput")) {
        return .{ .arena = arena, .kind = .{ .invalid_per_unit_storage_throughput = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRegion")) {
        return .{ .arena = arena, .kind = .{ .invalid_region = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .arena = arena, .kind = .{ .invalid_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSourceKmsKey")) {
        return .{ .arena = arena, .kind = .{ .invalid_source_kms_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingFileCacheConfiguration")) {
        return .{ .arena = arena, .kind = .{ .missing_file_cache_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingFileSystemConfiguration")) {
        return .{ .arena = arena, .kind = .{ .missing_file_system_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingVolumeConfiguration")) {
        return .{ .arena = arena, .kind = .{ .missing_volume_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotServiceResourceError")) {
        return .{ .arena = arena, .kind = .{ .not_service_resource_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceDoesNotSupportTagging")) {
        return .{ .arena = arena, .kind = .{ .resource_does_not_support_tagging = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3AccessPointAttachmentNotFound")) {
        return .{ .arena = arena, .kind = .{ .s3_access_point_attachment_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .service_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotNotFound")) {
        return .{ .arena = arena, .kind = .{ .snapshot_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceBackupUnavailable")) {
        return .{ .arena = arena, .kind = .{ .source_backup_unavailable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StorageVirtualMachineNotFound")) {
        return .{ .arena = arena, .kind = .{ .storage_virtual_machine_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyAccessPoints")) {
        return .{ .arena = arena, .kind = .{ .too_many_access_points = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperation")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VolumeNotFound")) {
        return .{ .arena = arena, .kind = .{ .volume_not_found = .{
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
