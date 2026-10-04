const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkProfileType = @import("network_profile_type.zig").NetworkProfileType;
const NetworkProfile = @import("network_profile.zig").NetworkProfile;

pub const UpdateNetworkProfileInput = struct {
    /// The Amazon Resource Name (ARN) of the project for which you want to update
    /// network
    /// profile settings.
    arn: []const u8,

    /// The description of the network profile about which you are returning
    /// information.
    description: ?[]const u8 = null,

    /// The data throughput rate in bits per second, as an integer from 0 to
    /// 104857600.
    downlink_bandwidth_bits: ?i64 = null,

    /// Delay time for all packets to destination in milliseconds as an integer from
    /// 0 to
    /// 2000.
    downlink_delay_ms: ?i64 = null,

    /// Time variation in the delay of received packets in milliseconds as an
    /// integer from
    /// 0 to 2000.
    downlink_jitter_ms: ?i64 = null,

    /// Proportion of received packets that fail to arrive from 0 to 100 percent.
    downlink_loss_percent: ?i32 = null,

    /// The name of the network profile about which you are returning
    /// information.
    name: ?[]const u8 = null,

    /// The type of network profile to return information about. Valid values are
    /// listed here.
    @"type": ?NetworkProfileType = null,

    /// The data throughput rate in bits per second, as an integer from 0 to
    /// 104857600.
    uplink_bandwidth_bits: ?i64 = null,

    /// Delay time for all packets to destination in milliseconds as an integer from
    /// 0 to
    /// 2000.
    uplink_delay_ms: ?i64 = null,

    /// Time variation in the delay of received packets in milliseconds as an
    /// integer from
    /// 0 to 2000.
    uplink_jitter_ms: ?i64 = null,

    /// Proportion of transmitted packets that fail to arrive from 0 to 100
    /// percent.
    uplink_loss_percent: ?i32 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .downlink_bandwidth_bits = "downlinkBandwidthBits",
        .downlink_delay_ms = "downlinkDelayMs",
        .downlink_jitter_ms = "downlinkJitterMs",
        .downlink_loss_percent = "downlinkLossPercent",
        .name = "name",
        .@"type" = "type",
        .uplink_bandwidth_bits = "uplinkBandwidthBits",
        .uplink_delay_ms = "uplinkDelayMs",
        .uplink_jitter_ms = "uplinkJitterMs",
        .uplink_loss_percent = "uplinkLossPercent",
    };
};

pub const UpdateNetworkProfileOutput = struct {
    /// A list of the available network profiles.
    network_profile: ?NetworkProfile = null,

    pub const json_field_names = .{
        .network_profile = "networkProfile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNetworkProfileInput, options: CallOptions) !UpdateNetworkProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNetworkProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.UpdateNetworkProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNetworkProfileOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateNetworkProfileOutput, body, allocator);
}
