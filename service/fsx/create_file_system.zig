const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
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
