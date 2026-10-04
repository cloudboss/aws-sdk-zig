const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileSystemFromBackupInput, options: CallOptions) !CreateFileSystemFromBackupOutput {
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFileSystemFromBackupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateFileSystemFromBackup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFileSystemFromBackupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFileSystemFromBackupOutput, body, allocator);
}
