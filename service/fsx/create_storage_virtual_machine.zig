const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateSvmActiveDirectoryConfiguration = @import("create_svm_active_directory_configuration.zig").CreateSvmActiveDirectoryConfiguration;
const StorageVirtualMachineRootVolumeSecurityStyle = @import("storage_virtual_machine_root_volume_security_style.zig").StorageVirtualMachineRootVolumeSecurityStyle;
const Tag = @import("tag.zig").Tag;
const StorageVirtualMachine = @import("storage_virtual_machine.zig").StorageVirtualMachine;

pub const CreateStorageVirtualMachineInput = struct {
    /// Describes the self-managed Microsoft Active Directory to which you want to
    /// join the SVM.
    /// Joining an Active Directory provides user authentication and access control
    /// for SMB clients,
    /// including Microsoft Windows and macOS clients accessing the file system.
    active_directory_configuration: ?CreateSvmActiveDirectoryConfiguration = null,

    client_request_token: ?[]const u8 = null,

    file_system_id: []const u8,

    /// The name of the SVM.
    name: []const u8,

    /// The security style of the root volume of the SVM. Specify one of the
    /// following values:
    ///
    /// * `UNIX` if the file system is managed by a UNIX
    /// administrator, the majority of users are NFS clients, and an application
    /// accessing the data uses a UNIX user as the service account.
    ///
    /// * `NTFS` if the file system is managed by a Microsoft Windows
    /// administrator, the majority of users are SMB clients, and an application
    /// accessing the data uses a Microsoft Windows user as the service account.
    ///
    /// * `MIXED` This is an advanced setting. For more information, see
    /// [Volume security
    /// style](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/volume-security-style.html)
    /// in the Amazon FSx for NetApp ONTAP User Guide.
    root_volume_security_style: ?StorageVirtualMachineRootVolumeSecurityStyle = null,

    /// The password to use when managing the SVM using the NetApp ONTAP CLI or REST
    /// API.
    /// If you do not specify a password, you can still use the file system's
    /// `fsxadmin` user to manage the SVM.
    svm_admin_password: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .active_directory_configuration = "ActiveDirectoryConfiguration",
        .client_request_token = "ClientRequestToken",
        .file_system_id = "FileSystemId",
        .name = "Name",
        .root_volume_security_style = "RootVolumeSecurityStyle",
        .svm_admin_password = "SvmAdminPassword",
        .tags = "Tags",
    };
};

pub const CreateStorageVirtualMachineOutput = struct {
    /// Returned after a successful `CreateStorageVirtualMachine` operation;
    /// describes the SVM just created.
    storage_virtual_machine: ?StorageVirtualMachine = null,

    pub const json_field_names = .{
        .storage_virtual_machine = "StorageVirtualMachine",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStorageVirtualMachineInput, options: CallOptions) !CreateStorageVirtualMachineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStorageVirtualMachineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateStorageVirtualMachine");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStorageVirtualMachineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateStorageVirtualMachineOutput, body, allocator);
}
