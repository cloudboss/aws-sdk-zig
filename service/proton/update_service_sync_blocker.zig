const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyncBlocker = @import("sync_blocker.zig").SyncBlocker;

pub const UpdateServiceSyncBlockerInput = struct {
    /// The ID of the service sync blocker.
    id: []const u8,

    /// The reason the service sync blocker was resolved.
    resolved_reason: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .resolved_reason = "resolvedReason",
    };
};

pub const UpdateServiceSyncBlockerOutput = struct {
    /// The name of the service instance that you want to update the service sync
    /// blocker
    /// for.
    service_instance_name: ?[]const u8 = null,

    /// The name of the service that you want to update the service sync blocker
    /// for.
    service_name: []const u8,

    /// The detailed data on the service sync blocker that was updated.
    service_sync_blocker: ?SyncBlocker = null,

    pub const json_field_names = .{
        .service_instance_name = "serviceInstanceName",
        .service_name = "serviceName",
        .service_sync_blocker = "serviceSyncBlocker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceSyncBlockerInput, options: CallOptions) !UpdateServiceSyncBlockerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceSyncBlockerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateServiceSyncBlocker");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceSyncBlockerOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateServiceSyncBlockerOutput, body, allocator);
}
