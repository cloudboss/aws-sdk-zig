const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const UpdateFileSystemLustreConfiguration = @import("update_file_system_lustre_configuration.zig").UpdateFileSystemLustreConfiguration;
const NetworkType = @import("network_type.zig").NetworkType;
const UpdateFileSystemOntapConfiguration = @import("update_file_system_ontap_configuration.zig").UpdateFileSystemOntapConfiguration;
const UpdateFileSystemOpenZFSConfiguration = @import("update_file_system_open_zfs_configuration.zig").UpdateFileSystemOpenZFSConfiguration;
const StorageType = @import("storage_type.zig").StorageType;
const UpdateFileSystemWindowsConfiguration = @import("update_file_system_windows_configuration.zig").UpdateFileSystemWindowsConfiguration;
const FileSystem = @import("file_system.zig").FileSystem;

pub const UpdateFileSystemInput = struct {
    /// A string of up to 63 ASCII characters that Amazon FSx uses to ensure
    /// idempotent updates. This string is automatically filled on your behalf when
    /// you use the
    /// Command Line Interface (CLI) or an Amazon Web Services SDK.
    client_request_token: ?[]const u8 = null,

    /// The ID of the file system that you are updating.
    file_system_id: []const u8,

    /// The Lustre version you are updating an FSx for Lustre file system to.
    /// Valid values are `2.12` and `2.15`. The value you choose must be
    /// newer than the file system's current Lustre version.
    file_system_type_version: ?[]const u8 = null,

    lustre_configuration: ?UpdateFileSystemLustreConfiguration = null,

    /// Changes the network type of an FSx for OpenZFS file system.
    network_type: ?NetworkType = null,

    ontap_configuration: ?UpdateFileSystemOntapConfiguration = null,

    /// The configuration updates for an FSx for OpenZFS file system.
    open_zfs_configuration: ?UpdateFileSystemOpenZFSConfiguration = null,

    /// Use this parameter to increase the storage capacity of an FSx for Windows
    /// File Server,
    /// FSx for Lustre, FSx for OpenZFS, or FSx for ONTAP file system.
    /// For second-generation FSx for ONTAP file systems, you can also decrease the
    /// storage capacity.
    /// Specifies the storage capacity target value, in GiB, for the file system
    /// that you're updating.
    ///
    /// You can't make a storage capacity increase request if there is an existing
    /// storage
    /// capacity increase request in progress.
    ///
    /// For Lustre file systems, the storage capacity target value can be the
    /// following:
    ///
    /// * For `SCRATCH_2`, `PERSISTENT_1`, and `PERSISTENT_2 SSD` deployment types,
    ///   valid values
    /// are in multiples of 2400 GiB. The value must be greater than the current
    /// storage capacity.
    ///
    /// * For `PERSISTENT HDD` file systems, valid values are multiples of 6000 GiB
    ///   for
    /// 12-MBps throughput per TiB file systems and multiples of 1800 GiB for
    /// 40-MBps throughput
    /// per TiB file systems. The values must be greater than the current storage
    /// capacity.
    ///
    /// * For `SCRATCH_1` file systems, you can't increase the storage capacity.
    ///
    /// For more information, see [Managing storage and throughput
    /// capacity](https://docs.aws.amazon.com/fsx/latest/LustreGuide/managing-storage-capacity.html) in the *FSx for Lustre User Guide*.
    ///
    /// For FSx for OpenZFS file systems, the storage capacity target value must be
    /// at least 10 percent
    /// greater than the current storage capacity value. For more information, see
    /// [Managing storage
    /// capacity](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/managing-storage-capacity.html) in the *FSx for OpenZFS User
    /// Guide*.
    ///
    /// For Windows file systems, the storage capacity target value must be at least
    /// 10 percent
    /// greater than the current storage capacity value. To increase storage
    /// capacity, the file system
    /// must have at least 16 MBps of throughput capacity. For more information, see
    /// [Managing storage
    /// capacity](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/managing-storage-capacity.html) in the *Amazon FSxfor Windows File Server User
    /// Guide*.
    ///
    /// For ONTAP file systems, when increasing storage capacity, the storage
    /// capacity target value must be at least 10 percent
    /// greater than the current storage capacity value. When decreasing storage
    /// capacity on second-generation file systems, the target value must be at
    /// least 9 percent smaller than the current SSD storage capacity. For more
    /// information, see
    /// [File system storage capacity and
    /// IOPS](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/storage-capacity-and-IOPS.html) in the Amazon FSx for NetApp ONTAP User
    /// Guide.
    storage_capacity: ?i32 = null,

    storage_type: ?StorageType = null,

    /// The configuration updates for an Amazon FSx for Windows File Server file
    /// system.
    windows_configuration: ?UpdateFileSystemWindowsConfiguration = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .file_system_id = "FileSystemId",
        .file_system_type_version = "FileSystemTypeVersion",
        .lustre_configuration = "LustreConfiguration",
        .network_type = "NetworkType",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .storage_capacity = "StorageCapacity",
        .storage_type = "StorageType",
        .windows_configuration = "WindowsConfiguration",
    };
};

pub const UpdateFileSystemOutput = struct {
    /// A description of the file system that was updated.
    file_system: ?FileSystem = null,

    pub const json_field_names = .{
        .file_system = "FileSystem",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFileSystemInput, options: CallOptions) !UpdateFileSystemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.UpdateFileSystem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFileSystemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateFileSystemOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessPointAlreadyOwnedByYou = aws.json.parseJsonObject(errors.AccessPointAlreadyOwnedByYou, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_point_already_owned_by_you = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ActiveDirectoryError")) {
        const parsed_error: ?errors.ActiveDirectoryError = aws.json.parseJsonObject(errors.ActiveDirectoryError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .active_directory_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupBeingCopied")) {
        const parsed_error: ?errors.BackupBeingCopied = aws.json.parseJsonObject(errors.BackupBeingCopied, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_being_copied = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupInProgress")) {
        const parsed_error: ?errors.BackupInProgress = aws.json.parseJsonObject(errors.BackupInProgress, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_in_progress = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupNotFound")) {
        const parsed_error: ?errors.BackupNotFound = aws.json.parseJsonObject(errors.BackupNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BackupRestoring")) {
        const parsed_error: ?errors.BackupRestoring = aws.json.parseJsonObject(errors.BackupRestoring, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .backup_restoring = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "BadRequest")) {
        const parsed_error: ?errors.BadRequest = aws.json.parseJsonObject(errors.BadRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .bad_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryAssociationNotFound")) {
        const parsed_error: ?errors.DataRepositoryAssociationNotFound = aws.json.parseJsonObject(errors.DataRepositoryAssociationNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_repository_association_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskEnded")) {
        const parsed_error: ?errors.DataRepositoryTaskEnded = aws.json.parseJsonObject(errors.DataRepositoryTaskEnded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_repository_task_ended = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskExecuting")) {
        const parsed_error: ?errors.DataRepositoryTaskExecuting = aws.json.parseJsonObject(errors.DataRepositoryTaskExecuting, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_repository_task_executing = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DataRepositoryTaskNotFound")) {
        const parsed_error: ?errors.DataRepositoryTaskNotFound = aws.json.parseJsonObject(errors.DataRepositoryTaskNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .data_repository_task_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileCacheNotFound")) {
        const parsed_error: ?errors.FileCacheNotFound = aws.json.parseJsonObject(errors.FileCacheNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_cache_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FileSystemNotFound")) {
        const parsed_error: ?errors.FileSystemNotFound = aws.json.parseJsonObject(errors.FileSystemNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .file_system_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncompatibleParameterError")) {
        const parsed_error: ?errors.IncompatibleParameterError = aws.json.parseJsonObject(errors.IncompatibleParameterError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incompatible_parameter_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "IncompatibleRegionForMultiAZ")) {
        const parsed_error: ?errors.IncompatibleRegionForMultiAZ = aws.json.parseJsonObject(errors.IncompatibleRegionForMultiAZ, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .incompatible_region_for_multi_az = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        const parsed_error: ?errors.InternalServerError = aws.json.parseJsonObject(errors.InternalServerError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAccessPoint")) {
        const parsed_error: ?errors.InvalidAccessPoint = aws.json.parseJsonObject(errors.InvalidAccessPoint, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_access_point = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDataRepositoryType")) {
        const parsed_error: ?errors.InvalidDataRepositoryType = aws.json.parseJsonObject(errors.InvalidDataRepositoryType, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_data_repository_type = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidDestinationKmsKey")) {
        const parsed_error: ?errors.InvalidDestinationKmsKey = aws.json.parseJsonObject(errors.InvalidDestinationKmsKey, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_destination_kms_key = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidExportPath")) {
        const parsed_error: ?errors.InvalidExportPath = aws.json.parseJsonObject(errors.InvalidExportPath, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_export_path = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidImportPath")) {
        const parsed_error: ?errors.InvalidImportPath = aws.json.parseJsonObject(errors.InvalidImportPath, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_import_path = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNetworkSettings")) {
        const parsed_error: ?errors.InvalidNetworkSettings = aws.json.parseJsonObject(errors.InvalidNetworkSettings, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_network_settings = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidPerUnitStorageThroughput")) {
        const parsed_error: ?errors.InvalidPerUnitStorageThroughput = aws.json.parseJsonObject(errors.InvalidPerUnitStorageThroughput, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_per_unit_storage_throughput = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRegion")) {
        const parsed_error: ?errors.InvalidRegion = aws.json.parseJsonObject(errors.InvalidRegion, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_region = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        const parsed_error: ?errors.InvalidRequest = aws.json.parseJsonObject(errors.InvalidRequest, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSourceKmsKey")) {
        const parsed_error: ?errors.InvalidSourceKmsKey = aws.json.parseJsonObject(errors.InvalidSourceKmsKey, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_source_kms_key = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MissingFileCacheConfiguration")) {
        const parsed_error: ?errors.MissingFileCacheConfiguration = aws.json.parseJsonObject(errors.MissingFileCacheConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .missing_file_cache_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MissingFileSystemConfiguration")) {
        const parsed_error: ?errors.MissingFileSystemConfiguration = aws.json.parseJsonObject(errors.MissingFileSystemConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .missing_file_system_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MissingVolumeConfiguration")) {
        const parsed_error: ?errors.MissingVolumeConfiguration = aws.json.parseJsonObject(errors.MissingVolumeConfiguration, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .missing_volume_configuration = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotServiceResourceError")) {
        const parsed_error: ?errors.NotServiceResourceError = aws.json.parseJsonObject(errors.NotServiceResourceError, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_service_resource_error = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceDoesNotSupportTagging")) {
        const parsed_error: ?errors.ResourceDoesNotSupportTagging = aws.json.parseJsonObject(errors.ResourceDoesNotSupportTagging, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_does_not_support_tagging = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        const parsed_error: ?errors.ResourceNotFound = aws.json.parseJsonObject(errors.ResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "S3AccessPointAttachmentNotFound")) {
        const parsed_error: ?errors.S3AccessPointAttachmentNotFound = aws.json.parseJsonObject(errors.S3AccessPointAttachmentNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .s3_access_point_attachment_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceLimitExceeded")) {
        const parsed_error: ?errors.ServiceLimitExceeded = aws.json.parseJsonObject(errors.ServiceLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotNotFound")) {
        const parsed_error: ?errors.SnapshotNotFound = aws.json.parseJsonObject(errors.SnapshotNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SourceBackupUnavailable")) {
        const parsed_error: ?errors.SourceBackupUnavailable = aws.json.parseJsonObject(errors.SourceBackupUnavailable, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .source_backup_unavailable = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "StorageVirtualMachineNotFound")) {
        const parsed_error: ?errors.StorageVirtualMachineNotFound = aws.json.parseJsonObject(errors.StorageVirtualMachineNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .storage_virtual_machine_not_found = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyAccessPoints")) {
        const parsed_error: ?errors.TooManyAccessPoints = aws.json.parseJsonObject(errors.TooManyAccessPoints, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_access_points = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperation")) {
        const parsed_error: ?errors.UnsupportedOperation = aws.json.parseJsonObject(errors.UnsupportedOperation, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_operation = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "VolumeNotFound")) {
        const parsed_error: ?errors.VolumeNotFound = aws.json.parseJsonObject(errors.VolumeNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .volume_not_found = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
