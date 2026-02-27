const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CreateFileSystemLustreConfiguration = @import("create_file_system_lustre_configuration.zig").CreateFileSystemLustreConfiguration;
const NetworkType = @import("network_type.zig").NetworkType;
const CreateFileSystemOpenZFSConfiguration = @import("create_file_system_open_zfs_configuration.zig").CreateFileSystemOpenZFSConfiguration;
const StorageType = @import("storage_type.zig").StorageType;
const Tag = @import("tag.zig").Tag;
const CreateFileSystemWindowsConfiguration = @import("create_file_system_windows_configuration.zig").CreateFileSystemWindowsConfiguration;
const FileSystem = @import("file_system.zig").FileSystem;

pub const CreateFileSystemFromBackupInput = struct {
    backup_id: []const u8,

    /// A string of up to 63 ASCII characters that Amazon FSx uses to ensure
    /// idempotent creation. This string is automatically filled on your behalf when
    /// you use the
    /// Command Line Interface (CLI) or an Amazon Web Services SDK.
    client_request_token: ?[]const u8 = null,

    /// Sets the version for the Amazon FSx for Lustre file system that you're
    /// creating from a backup. Valid values are `2.10`, `2.12`,
    /// and `2.15`.
    ///
    /// You can enter a Lustre version that is newer than the backup's
    /// `FileSystemTypeVersion` setting. If you don't enter a newer Lustre version,
    /// it defaults to the backup's setting.
    file_system_type_version: ?[]const u8 = null,

    kms_key_id: ?[]const u8 = null,

    lustre_configuration: ?CreateFileSystemLustreConfiguration = null,

    /// Sets the network type for the Amazon FSx for OpenZFS file system
    /// that you're creating from a backup.
    network_type: ?NetworkType = null,

    /// The OpenZFS configuration for the file system that's being created.
    open_zfs_configuration: ?CreateFileSystemOpenZFSConfiguration = null,

    /// A list of IDs for the security groups that apply to the specified network
    /// interfaces
    /// created for file system access. These security groups apply to all network
    /// interfaces.
    /// This value isn't returned in later `DescribeFileSystem` requests.
    security_group_ids: ?[]const []const u8 = null,

    /// Sets the storage capacity of the OpenZFS file system that you're creating
    /// from a backup, in gibibytes (GiB). Valid values are from 64 GiB up to
    /// 524,288 GiB
    /// (512 TiB). However, the value that you specify must be equal to or greater
    /// than the
    /// backup's storage capacity value. If you don't use the `StorageCapacity`
    /// parameter, the default is the backup's `StorageCapacity` value.
    ///
    /// If used to create a file system other than OpenZFS, you must provide a value
    /// that matches the backup's `StorageCapacity` value. If you provide any
    /// other value, Amazon FSx responds with an HTTP status code 400 Bad Request.
    storage_capacity: ?i32 = null,

    /// Sets the storage type for the Windows, OpenZFS, or Lustre file system that
    /// you're creating from
    /// a backup. Valid values are `SSD`, `HDD`, and `INTELLIGENT_TIERING`.
    ///
    /// * Set to `SSD` to use solid state drive storage. SSD is supported on all
    ///   Windows and OpenZFS
    /// deployment types.
    ///
    /// * Set to `HDD` to use hard disk drive storage.
    /// HDD is supported on `SINGLE_AZ_2` and `MULTI_AZ_1` FSx for Windows File
    /// Server file system deployment types.
    ///
    /// * Set to `INTELLIGENT_TIERING` to use fully elastic, intelligently-tiered
    ///   storage.
    /// Intelligent-Tiering is only available for OpenZFS file systems with the
    /// Multi-AZ deployment type
    /// and for Lustre file systems with the Persistent_2 deployment type.
    ///
    /// The default value is `SSD`.
    ///
    /// HDD and SSD storage types have different minimum storage capacity
    /// requirements.
    /// A restored file system's storage capacity is tied to the file system that
    /// was backed up.
    /// You can create a file system that uses HDD storage from a backup of a file
    /// system that
    /// used SSD storage if the original SSD file system had a storage capacity of
    /// at least 2000 GiB.
    storage_type: ?StorageType = null,

    /// Specifies the IDs of the subnets that the file system will be accessible
    /// from. For Windows `MULTI_AZ_1`
    /// file system deployment types, provide exactly two subnet IDs, one for the
    /// preferred file server
    /// and one for the standby file server. You specify one of these subnets as the
    /// preferred subnet
    /// using the `WindowsConfiguration > PreferredSubnetID` property.
    ///
    /// Windows `SINGLE_AZ_1` and `SINGLE_AZ_2` file system deployment
    /// types, Lustre file systems, and OpenZFS file systems provide exactly one
    /// subnet ID. The
    /// file server is launched in that subnet's Availability Zone.
    subnet_ids: []const []const u8,

    /// The tags to be applied to the file system at file system creation. The key
    /// value of
    /// the `Name` tag appears in the console as the file system
    /// name.
    tags: ?[]const Tag = null,

    /// The configuration for this Microsoft Windows file system.
    windows_configuration: ?CreateFileSystemWindowsConfiguration = null,

    pub const json_field_names = .{
        .backup_id = "BackupId",
        .client_request_token = "ClientRequestToken",
        .file_system_type_version = "FileSystemTypeVersion",
        .kms_key_id = "KmsKeyId",
        .lustre_configuration = "LustreConfiguration",
        .network_type = "NetworkType",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .security_group_ids = "SecurityGroupIds",
        .storage_capacity = "StorageCapacity",
        .storage_type = "StorageType",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .windows_configuration = "WindowsConfiguration",
    };
};

pub const CreateFileSystemFromBackupOutput = struct {
    /// A description of the file system.
    file_system: ?FileSystem = null,

    pub const json_field_names = .{
        .file_system = "FileSystem",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileSystemFromBackupInput, options: Options) !CreateFileSystemFromBackupOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFileSystemFromBackupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateFileSystemFromBackup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateFileSystemFromBackupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFileSystemFromBackupOutput, body, alloc);
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
