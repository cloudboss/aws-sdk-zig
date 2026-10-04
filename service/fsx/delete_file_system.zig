const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteFileSystemLustreConfiguration = @import("delete_file_system_lustre_configuration.zig").DeleteFileSystemLustreConfiguration;
const DeleteFileSystemOpenZFSConfiguration = @import("delete_file_system_open_zfs_configuration.zig").DeleteFileSystemOpenZFSConfiguration;
const DeleteFileSystemWindowsConfiguration = @import("delete_file_system_windows_configuration.zig").DeleteFileSystemWindowsConfiguration;
const FileSystemLifecycle = @import("file_system_lifecycle.zig").FileSystemLifecycle;
const DeleteFileSystemLustreResponse = @import("delete_file_system_lustre_response.zig").DeleteFileSystemLustreResponse;
const DeleteFileSystemOpenZFSResponse = @import("delete_file_system_open_zfs_response.zig").DeleteFileSystemOpenZFSResponse;
const DeleteFileSystemWindowsResponse = @import("delete_file_system_windows_response.zig").DeleteFileSystemWindowsResponse;

pub const DeleteFileSystemInput = struct {
    /// A string of up to 63 ASCII characters that Amazon FSx uses to ensure
    /// idempotent deletion. This token is automatically filled on your behalf when
    /// using the
    /// Command Line Interface (CLI) or an Amazon Web Services SDK.
    client_request_token: ?[]const u8 = null,

    /// The ID of the file system that you want to delete.
    file_system_id: []const u8,

    lustre_configuration: ?DeleteFileSystemLustreConfiguration = null,

    /// The configuration object for the OpenZFS file system used in the
    /// `DeleteFileSystem` operation.
    open_zfs_configuration: ?DeleteFileSystemOpenZFSConfiguration = null,

    windows_configuration: ?DeleteFileSystemWindowsConfiguration = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .file_system_id = "FileSystemId",
        .lustre_configuration = "LustreConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .windows_configuration = "WindowsConfiguration",
    };
};

pub const DeleteFileSystemOutput = struct {
    /// The ID of the file system that's being deleted.
    file_system_id: ?[]const u8 = null,

    /// The file system lifecycle for the deletion request. If the
    /// `DeleteFileSystem` operation is successful, this status is
    /// `DELETING`.
    lifecycle: ?FileSystemLifecycle = null,

    lustre_response: ?DeleteFileSystemLustreResponse = null,

    /// The response object for the OpenZFS file system that's being deleted in the
    /// `DeleteFileSystem` operation.
    open_zfs_response: ?DeleteFileSystemOpenZFSResponse = null,

    windows_response: ?DeleteFileSystemWindowsResponse = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .lifecycle = "Lifecycle",
        .lustre_response = "LustreResponse",
        .open_zfs_response = "OpenZFSResponse",
        .windows_response = "WindowsResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteFileSystemInput, options: CallOptions) !DeleteFileSystemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteFileSystemInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DeleteFileSystem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteFileSystemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteFileSystemOutput, body, allocator);
}
