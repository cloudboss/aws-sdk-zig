const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FileSystemType = @import("file_system_type.zig").FileSystemType;
const CreateFileSystemLustreConfiguration = @import("create_file_system_lustre_configuration.zig").CreateFileSystemLustreConfiguration;
const NetworkType = @import("network_type.zig").NetworkType;
const CreateFileSystemOntapConfiguration = @import("create_file_system_ontap_configuration.zig").CreateFileSystemOntapConfiguration;
const CreateFileSystemOpenZFSConfiguration = @import("create_file_system_open_zfs_configuration.zig").CreateFileSystemOpenZFSConfiguration;
const StorageType = @import("storage_type.zig").StorageType;
const Tag = @import("tag.zig").Tag;
const CreateFileSystemWindowsConfiguration = @import("create_file_system_windows_configuration.zig").CreateFileSystemWindowsConfiguration;
const FileSystem = @import("file_system.zig").FileSystem;

pub const CreateFileSystemInput = struct {
    /// A string of up to 63 ASCII characters that Amazon FSx uses to ensure
    /// idempotent creation. This string is automatically filled on your behalf when
    /// you use the
    /// Command Line Interface (CLI) or an Amazon Web Services SDK.
    client_request_token: ?[]const u8 = null,

    /// The type of Amazon FSx file system to create. Valid values are
    /// `WINDOWS`, `LUSTRE`, `ONTAP`, and
    /// `OPENZFS`.
    file_system_type: FileSystemType,

    /// For FSx for Lustre file systems, sets the Lustre version for the file system
    /// that you're creating. Valid values are `2.10`, `2.12`, and
    /// `2.15`:
    ///
    /// * `2.10` is supported by the Scratch and Persistent_1 Lustre
    /// deployment types.
    ///
    /// * `2.12` is supported by all Lustre deployment types, except
    /// for `PERSISTENT_2` with a metadata configuration mode.
    ///
    /// * `2.15` is supported by all Lustre deployment types and is
    /// recommended for all new file systems.
    ///
    /// Default value is `2.10`, except for the following deployments:
    ///
    /// * Default value is `2.12` when `DeploymentType` is set to
    /// `PERSISTENT_2` without a metadata configuration mode.
    ///
    /// * Default value is `2.15` when `DeploymentType` is set to
    /// `PERSISTENT_2` with a metadata configuration mode.
    file_system_type_version: ?[]const u8 = null,

    kms_key_id: ?[]const u8 = null,

    lustre_configuration: ?CreateFileSystemLustreConfiguration = null,

    /// The network type of the Amazon FSx file system that you
    /// are creating. Valid values are `IPV4` (which supports
    /// IPv4 only) and `DUAL` (for dual-stack mode, which supports
    /// both IPv4 and IPv6). The default is `IPV4`. Supported
    /// for FSx for OpenZFS, FSx for ONTAP, and FSx for Windows File Server
    /// file systems.
    network_type: ?NetworkType = null,

    ontap_configuration: ?CreateFileSystemOntapConfiguration = null,

    /// The OpenZFS configuration for the file system that's being created.
    open_zfs_configuration: ?CreateFileSystemOpenZFSConfiguration = null,

    /// A list of IDs specifying the security groups to apply to all network
    /// interfaces
    /// created for file system access. This list isn't returned in later requests
    /// to
    /// describe the file system.
    ///
    /// You must specify a security group if you are creating a Multi-AZ
    /// FSx for ONTAP file system in a VPC subnet that has been shared with you.
    security_group_ids: ?[]const []const u8 = null,

    /// Sets the storage capacity of the file system that you're creating, in
    /// gibibytes (GiB).
    ///
    /// **FSx for Lustre file systems** - The amount of
    /// storage capacity that you can configure depends on the value that you set
    /// for
    /// `StorageType` and the Lustre `DeploymentType`, as
    /// follows:
    ///
    /// * For `SCRATCH_2`, `PERSISTENT_2`, and `PERSISTENT_1` deployment types
    /// using SSD storage type, the valid values are 1200 GiB, 2400 GiB, and
    /// increments of 2400 GiB.
    ///
    /// * For `PERSISTENT_1` HDD file systems, valid values are increments of 6000
    ///   GiB for
    /// 12 MB/s/TiB file systems and increments of 1800 GiB for 40 MB/s/TiB file
    /// systems.
    ///
    /// * For `SCRATCH_1` deployment type, valid values are
    /// 1200 GiB, 2400 GiB, and increments of 3600 GiB.
    ///
    /// **FSx for ONTAP file systems** - The amount of storage capacity
    /// that you can configure depends on the value of the `HAPairs` property. The
    /// minimum value is calculated as 1,024 * `HAPairs` and the maximum is
    /// calculated as 524,288 * `HAPairs`.
    ///
    /// **FSx for OpenZFS file systems** - The amount of storage capacity that
    /// you can configure is from 64 GiB up to 524,288 GiB (512 TiB).
    ///
    /// **FSx for Windows File Server file systems** - The amount
    /// of storage capacity that you can configure depends on the value that you set
    /// for
    /// `StorageType` as follows:
    ///
    /// * For SSD storage, valid values are 32 GiB-65,536 GiB (64 TiB).
    ///
    /// * For HDD storage, valid values are 2000 GiB-65,536 GiB (64 TiB).
    storage_capacity: ?i32 = null,

    /// Sets the storage class for the file system that you're creating. Valid
    /// values are
    /// `SSD`, `HDD`, and `INTELLIGENT_TIERING`.
    ///
    /// * Set to `SSD` to use solid state drive storage. SSD is supported on all
    ///   Windows,
    /// Lustre, ONTAP, and OpenZFS deployment types.
    ///
    /// * Set to `HDD` to use hard disk drive storage, which is supported on
    /// `SINGLE_AZ_2` and `MULTI_AZ_1` Windows file system deployment types,
    /// and on `PERSISTENT_1` Lustre file system deployment types.
    ///
    /// * Set to `INTELLIGENT_TIERING` to use fully elastic, intelligently-tiered
    ///   storage.
    /// Intelligent-Tiering is only available for OpenZFS file systems with the
    /// Multi-AZ deployment type
    /// and for Lustre file systems with the Persistent_2 deployment type.
    ///
    /// Default value is `SSD`. For more information, see [ Storage
    /// type
    /// options](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/optimize-fsx-costs.html#storage-type-options) in the *FSx for Windows File Server User
    /// Guide*, [FSx for Lustre storage
    /// classes](https://docs.aws.amazon.com/fsx/latest/LustreGuide/using-fsx-lustre.html#lustre-storage-classes)
    /// in the *FSx for Lustre User Guide*, and [Working with
    /// Intelligent-Tiering](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/performance-intelligent-tiering)
    /// in the *Amazon FSx for OpenZFS User Guide*.
    storage_type: ?StorageType = null,

    /// Specifies the IDs of the subnets that the file system will be accessible
    /// from. For
    /// Windows and ONTAP `MULTI_AZ_1` deployment types,provide exactly two subnet
    /// IDs, one for the preferred file server and one for the standby file server.
    /// You specify
    /// one of these subnets as the preferred subnet using the `WindowsConfiguration
    /// >
    /// PreferredSubnetID` or `OntapConfiguration > PreferredSubnetID`
    /// properties. For more information about Multi-AZ file system configuration,
    /// see [
    /// Availability and durability: Single-AZ and Multi-AZ file
    /// systems](https://docs.aws.amazon.com/fsx/latest/WindowsGuide/high-availability-multiAZ.html) in the
    /// *Amazon FSx for Windows User Guide* and [
    /// Availability and
    /// durability](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/high-availability-multiAZ.html) in the *Amazon FSx for ONTAP User
    /// Guide*.
    ///
    /// For Windows `SINGLE_AZ_1` and `SINGLE_AZ_2` and all Lustre
    /// deployment types, provide exactly one subnet ID.
    /// The file server is launched in that subnet's Availability Zone.
    subnet_ids: []const []const u8,

    /// The tags to apply to the file system that's being created. The key value of
    /// the
    /// `Name` tag appears in the console as the file system name.
    tags: ?[]const Tag = null,

    /// The Microsoft Windows configuration for the file system that's being
    /// created.
    windows_configuration: ?CreateFileSystemWindowsConfiguration = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .file_system_type = "FileSystemType",
        .file_system_type_version = "FileSystemTypeVersion",
        .kms_key_id = "KmsKeyId",
        .lustre_configuration = "LustreConfiguration",
        .network_type = "NetworkType",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .security_group_ids = "SecurityGroupIds",
        .storage_capacity = "StorageCapacity",
        .storage_type = "StorageType",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .windows_configuration = "WindowsConfiguration",
    };
};

pub const CreateFileSystemOutput = struct {
    /// The configuration of the file system that was created.
    file_system: ?FileSystem = null,

    pub const json_field_names = .{
        .file_system = "FileSystem",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileSystemInput, options: Options) !CreateFileSystemOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFileSystemInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateFileSystem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFileSystemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFileSystemOutput, body, allocator);
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
