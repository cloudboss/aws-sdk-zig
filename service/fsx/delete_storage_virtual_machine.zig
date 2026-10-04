const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageVirtualMachineLifecycle = @import("storage_virtual_machine_lifecycle.zig").StorageVirtualMachineLifecycle;

pub const DeleteStorageVirtualMachineInput = struct {
    client_request_token: ?[]const u8 = null,

    /// The ID of the SVM that you want to delete.
    storage_virtual_machine_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .storage_virtual_machine_id = "StorageVirtualMachineId",
    };
};

pub const DeleteStorageVirtualMachineOutput = struct {
    /// Describes the lifecycle state of the SVM being deleted.
    lifecycle: ?StorageVirtualMachineLifecycle = null,

    /// The ID of the SVM Amazon FSx is deleting.
    storage_virtual_machine_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle = "Lifecycle",
        .storage_virtual_machine_id = "StorageVirtualMachineId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteStorageVirtualMachineInput, options: CallOptions) !DeleteStorageVirtualMachineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteStorageVirtualMachineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DeleteStorageVirtualMachine");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteStorageVirtualMachineOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteStorageVirtualMachineOutput, body, allocator);
}
