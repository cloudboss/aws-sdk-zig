const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DetachVolumeInput = struct {
    /// Set to `true` to forcibly remove the iSCSI connection of the target volume
    /// and detach the volume. The default is `false`. If this value is set to
    /// `false`, you must manually disconnect the iSCSI connection from the target
    /// volume.
    ///
    /// Valid Values: `true` | `false`
    force_detach: ?bool = null,

    /// The Amazon Resource Name (ARN) of the volume to detach from the gateway.
    volume_arn: []const u8,

    pub const json_field_names = .{
        .force_detach = "ForceDetach",
        .volume_arn = "VolumeARN",
    };
};

pub const DetachVolumeOutput = struct {
    /// The Amazon Resource Name (ARN) of the volume that was detached.
    volume_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .volume_arn = "VolumeARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetachVolumeInput, options: CallOptions) !DetachVolumeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetachVolumeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DetachVolume");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetachVolumeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetachVolumeOutput, body, allocator);
}
