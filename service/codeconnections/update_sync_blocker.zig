const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyncConfigurationType = @import("sync_configuration_type.zig").SyncConfigurationType;
const SyncBlocker = @import("sync_blocker.zig").SyncBlocker;

pub const UpdateSyncBlockerInput = struct {
    /// The ID of the sync blocker to be updated.
    id: []const u8,

    /// The reason for resolving the sync blocker.
    resolved_reason: []const u8,

    /// The name of the resource for the sync blocker to be updated.
    resource_name: []const u8,

    /// The sync type of the sync blocker to be updated.
    sync_type: SyncConfigurationType,

    pub const json_field_names = .{
        .id = "Id",
        .resolved_reason = "ResolvedReason",
        .resource_name = "ResourceName",
        .sync_type = "SyncType",
    };
};

pub const UpdateSyncBlockerOutput = struct {
    /// The parent resource name for the sync blocker.
    parent_resource_name: ?[]const u8 = null,

    /// The resource name for the sync blocker.
    resource_name: []const u8,

    /// Information about the sync blocker to be updated.
    sync_blocker: ?SyncBlocker = null,

    pub const json_field_names = .{
        .parent_resource_name = "ParentResourceName",
        .resource_name = "ResourceName",
        .sync_blocker = "SyncBlocker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSyncBlockerInput, options: CallOptions) !UpdateSyncBlockerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeconnections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSyncBlockerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeconnections", "CodeConnections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.UpdateSyncBlocker");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSyncBlockerOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateSyncBlockerOutput, body, allocator);
}
