const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CachediSCSIVolume = @import("cachedi_scsi_volume.zig").CachediSCSIVolume;

pub const DescribeCachediSCSIVolumesInput = struct {
    /// An array of strings where each string represents the Amazon Resource Name
    /// (ARN) of a
    /// cached volume. All of the specified cached volumes must be from the same
    /// gateway. Use ListVolumes to get volume ARNs for a gateway.
    volume_ar_ns: []const []const u8,

    pub const json_field_names = .{
        .volume_ar_ns = "VolumeARNs",
    };
};

pub const DescribeCachediSCSIVolumesOutput = struct {
    /// An array of objects where each object contains metadata about one cached
    /// volume.
    cachedi_scsi_volumes: ?[]const CachediSCSIVolume = null,

    pub const json_field_names = .{
        .cachedi_scsi_volumes = "CachediSCSIVolumes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCachediSCSIVolumesInput, options: CallOptions) !DescribeCachediSCSIVolumesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCachediSCSIVolumesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeCachediSCSIVolumes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCachediSCSIVolumesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCachediSCSIVolumesOutput, body, allocator);
}
