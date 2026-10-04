const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceDataSyncSource = @import("resource_data_sync_source.zig").ResourceDataSyncSource;

pub const UpdateResourceDataSyncInput = struct {
    /// The name of the resource data sync you want to update.
    sync_name: []const u8,

    /// Specify information about the data sources to synchronize.
    sync_source: ResourceDataSyncSource,

    /// The type of resource data sync. The supported `SyncType` is
    /// SyncFromSource.
    sync_type: []const u8,

    pub const json_field_names = .{
        .sync_name = "SyncName",
        .sync_source = "SyncSource",
        .sync_type = "SyncType",
    };
};

pub const UpdateResourceDataSyncOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResourceDataSyncInput, options: CallOptions) !UpdateResourceDataSyncOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResourceDataSyncInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateResourceDataSync");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResourceDataSyncOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
