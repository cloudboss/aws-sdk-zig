const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VolumeInfo = @import("volume_info.zig").VolumeInfo;

pub const ListVolumesInput = struct {
    gateway_arn: ?[]const u8 = null,

    /// Specifies that the list of volumes returned be limited to the specified
    /// number of
    /// items.
    limit: ?i32 = null,

    /// A string that indicates the position at which to begin the returned list of
    /// volumes.
    /// Obtain the marker from the response of a previous List iSCSI Volumes
    /// request.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .limit = "Limit",
        .marker = "Marker",
    };
};

pub const ListVolumesOutput = struct {
    gateway_arn: ?[]const u8 = null,

    /// Use the marker in your next request to continue pagination of iSCSI volumes.
    /// If there
    /// are no more volumes to list, this field does not appear in the response
    /// body.
    marker: ?[]const u8 = null,

    /// An array of VolumeInfo objects, where each object describes an iSCSI
    /// volume. If no volumes are defined for the gateway, then `VolumeInfos` is an
    /// empty array "[]".
    volume_infos: ?[]const VolumeInfo = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .marker = "Marker",
        .volume_infos = "VolumeInfos",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVolumesInput, options: CallOptions) !ListVolumesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "storagegateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVolumesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.ListVolumes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVolumesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListVolumesOutput, body, allocator);
}
