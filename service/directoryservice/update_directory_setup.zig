const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectorySizeUpdateSettings = @import("directory_size_update_settings.zig").DirectorySizeUpdateSettings;
const NetworkUpdateSettings = @import("network_update_settings.zig").NetworkUpdateSettings;
const OSUpdateSettings = @import("os_update_settings.zig").OSUpdateSettings;
const UpdateType = @import("update_type.zig").UpdateType;

pub const UpdateDirectorySetupInput = struct {
    /// Specifies whether to create a directory snapshot before performing the
    /// update.
    create_snapshot_before_update: ?bool = null,

    /// The identifier of the directory to update.
    directory_id: []const u8,

    /// Directory size configuration to apply during the update operation.
    directory_size_update_settings: ?DirectorySizeUpdateSettings = null,

    /// Network configuration to apply during the directory update operation.
    network_update_settings: ?NetworkUpdateSettings = null,

    /// Operating system configuration to apply during the directory update
    /// operation.
    os_update_settings: ?OSUpdateSettings = null,

    /// The type of update to perform on the directory.
    update_type: UpdateType,

    pub const json_field_names = .{
        .create_snapshot_before_update = "CreateSnapshotBeforeUpdate",
        .directory_id = "DirectoryId",
        .directory_size_update_settings = "DirectorySizeUpdateSettings",
        .network_update_settings = "NetworkUpdateSettings",
        .os_update_settings = "OSUpdateSettings",
        .update_type = "UpdateType",
    };
};

pub const UpdateDirectorySetupOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDirectorySetupInput, options: CallOptions) !UpdateDirectorySetupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDirectorySetupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.UpdateDirectorySetup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDirectorySetupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
