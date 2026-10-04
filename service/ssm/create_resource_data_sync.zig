const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceDataSyncS3Destination = @import("resource_data_sync_s3_destination.zig").ResourceDataSyncS3Destination;
const ResourceDataSyncSource = @import("resource_data_sync_source.zig").ResourceDataSyncSource;

pub const CreateResourceDataSyncInput = struct {
    /// Amazon S3 configuration details for the sync. This parameter is required if
    /// the
    /// `SyncType` value is SyncToDestination.
    s3_destination: ?ResourceDataSyncS3Destination = null,

    /// A name for the configuration.
    sync_name: []const u8,

    /// Specify information about the data sources to synchronize. This parameter is
    /// required if the
    /// `SyncType` value is SyncFromSource.
    sync_source: ?ResourceDataSyncSource = null,

    /// Specify `SyncToDestination` to create a resource data sync that synchronizes
    /// data
    /// to an S3 bucket for Inventory. If you specify `SyncToDestination`, you must
    /// provide a
    /// value for `S3Destination`. Specify `SyncFromSource` to synchronize data
    /// from a single account and multiple Regions, or multiple Amazon Web Services
    /// accounts and Amazon Web Services Regions, as
    /// listed in Organizations for Explorer. If you specify `SyncFromSource`, you
    /// must provide a
    /// value for `SyncSource`. The default value is `SyncToDestination`.
    sync_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_destination = "S3Destination",
        .sync_name = "SyncName",
        .sync_source = "SyncSource",
        .sync_type = "SyncType",
    };
};

pub const CreateResourceDataSyncOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceDataSyncInput, options: CallOptions) !CreateResourceDataSyncOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceDataSyncInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.CreateResourceDataSync");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceDataSyncOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
