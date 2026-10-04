const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
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
