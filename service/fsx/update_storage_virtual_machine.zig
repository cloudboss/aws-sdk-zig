const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateSvmActiveDirectoryConfiguration = @import("update_svm_active_directory_configuration.zig").UpdateSvmActiveDirectoryConfiguration;
const StorageVirtualMachine = @import("storage_virtual_machine.zig").StorageVirtualMachine;

pub const UpdateStorageVirtualMachineInput = struct {
    /// Specifies updates to an SVM's Microsoft Active Directory (AD) configuration.
    active_directory_configuration: ?UpdateSvmActiveDirectoryConfiguration = null,

    client_request_token: ?[]const u8 = null,

    /// The ID of the SVM that you want to update, in the format
    /// `svm-0123456789abcdef0`.
    storage_virtual_machine_id: []const u8,

    /// Specifies a new SvmAdminPassword.
    svm_admin_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_directory_configuration = "ActiveDirectoryConfiguration",
        .client_request_token = "ClientRequestToken",
        .storage_virtual_machine_id = "StorageVirtualMachineId",
        .svm_admin_password = "SvmAdminPassword",
    };
};

pub const UpdateStorageVirtualMachineOutput = struct {
    storage_virtual_machine: ?StorageVirtualMachine = null,

    pub const json_field_names = .{
        .storage_virtual_machine = "StorageVirtualMachine",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStorageVirtualMachineInput, options: CallOptions) !UpdateStorageVirtualMachineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStorageVirtualMachineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.UpdateStorageVirtualMachine");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStorageVirtualMachineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateStorageVirtualMachineOutput, body, allocator);
}
