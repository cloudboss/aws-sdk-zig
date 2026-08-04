const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileSystemInput, options: CallOptions) !CreateFileSystemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFileSystemInput, config: *aws.Config) !aws.http.Request {
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
