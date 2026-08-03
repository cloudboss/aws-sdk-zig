const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const FileCacheDataRepositoryAssociation = @import("file_cache_data_repository_association.zig").FileCacheDataRepositoryAssociation;
const FileCacheType = @import("file_cache_type.zig").FileCacheType;
const CreateFileCacheLustreConfiguration = @import("create_file_cache_lustre_configuration.zig").CreateFileCacheLustreConfiguration;
const Tag = @import("tag.zig").Tag;
const FileCacheCreating = @import("file_cache_creating.zig").FileCacheCreating;

pub const CreateFileCacheInput = struct {
    /// An idempotency token for resource creation, in a string of up to 63
    /// ASCII characters. This token is automatically filled on your behalf when you
    /// use the
    /// Command Line Interface (CLI) or an Amazon Web Services SDK.
    ///
    /// By using the idempotent operation, you can retry a `CreateFileCache`
    /// operation without the risk of creating an extra cache. This approach can be
    /// useful
    /// when an initial call fails in a way that makes it unclear whether a cache
    /// was created.
    /// Examples are if a transport level timeout occurred, or your connection was
    /// reset.
    /// If you use the same client request token and the initial call created a
    /// cache, the
    /// client receives success as long as the parameters are the same.
    client_request_token: ?[]const u8 = null,

    /// A boolean flag indicating whether tags for the cache should be copied to
    /// data repository associations. This value defaults to false.
    copy_tags_to_data_repository_associations: ?bool = null,

    /// A list of up to 8 configurations for data repository associations (DRAs) to
    /// be created during the cache creation. The DRAs link the cache to either an
    /// Amazon S3 data repository or a Network File System (NFS) data repository
    /// that supports the NFSv3 protocol.
    ///
    /// The DRA configurations must meet the following requirements:
    ///
    /// * All configurations on the list must be of the
    /// same data repository type, either all S3 or all NFS. A cache
    /// can't link to different data repository types at the same time.
    ///
    /// * An NFS DRA must link to an NFS file system that
    /// supports the NFSv3 protocol.
    ///
    /// DRA automatic import and automatic export is not supported.
    data_repository_associations: ?[]const FileCacheDataRepositoryAssociation = null,

    /// The type of cache that you're creating, which
    /// must be `LUSTRE`.
    file_cache_type: FileCacheType,

    /// Sets the Lustre version for the cache that you're creating,
    /// which must be `2.12`.
    file_cache_type_version: []const u8,

    /// Specifies the ID of the Key Management Service (KMS) key to use for
    /// encrypting data on
    /// an Amazon File Cache. If a `KmsKeyId` isn't specified, the Amazon
    /// FSx-managed
    /// KMS key for your account is used. For more information,
    /// see
    /// [Encrypt](https://docs.aws.amazon.com/kms/latest/APIReference/API_Encrypt.html) in the
    /// *Key Management Service API Reference*.
    kms_key_id: ?[]const u8 = null,

    /// The configuration for the Amazon File Cache resource being created.
    lustre_configuration: ?CreateFileCacheLustreConfiguration = null,

    /// A list of IDs specifying the security groups to apply to all network
    /// interfaces
    /// created for Amazon File Cache access. This list isn't returned in later
    /// requests to
    /// describe the cache.
    security_group_ids: ?[]const []const u8 = null,

    /// The storage capacity of the cache in gibibytes (GiB). Valid values
    /// are 1200 GiB, 2400 GiB, and increments of 2400 GiB.
    storage_capacity: i32,

    subnet_ids: []const []const u8,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .copy_tags_to_data_repository_associations = "CopyTagsToDataRepositoryAssociations",
        .data_repository_associations = "DataRepositoryAssociations",
        .file_cache_type = "FileCacheType",
        .file_cache_type_version = "FileCacheTypeVersion",
        .kms_key_id = "KmsKeyId",
        .lustre_configuration = "LustreConfiguration",
        .security_group_ids = "SecurityGroupIds",
        .storage_capacity = "StorageCapacity",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
    };
};

pub const CreateFileCacheOutput = struct {
    /// A description of the cache that was created.
    file_cache: ?FileCacheCreating = null,

    pub const json_field_names = .{
        .file_cache = "FileCache",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileCacheInput, options: CallOptions) !CreateFileCacheOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFileCacheInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateFileCache");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFileCacheOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFileCacheOutput, body, allocator);
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
