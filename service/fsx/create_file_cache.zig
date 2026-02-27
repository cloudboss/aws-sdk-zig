const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileCacheInput, options: Options) !CreateFileCacheOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "fsx");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFileCacheInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateFileCache");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateFileCacheOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFileCacheOutput, body, alloc);
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
