const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoRaWANDeviceMetadata = @import("lo_ra_wan_device_metadata.zig").LoRaWANDeviceMetadata;
const SidewalkDeviceMetadata = @import("sidewalk_device_metadata.zig").SidewalkDeviceMetadata;

pub const GetWirelessDeviceStatisticsInput = struct {
    /// The ID of the wireless device for which to get the data.
    wireless_device_id: []const u8,

    pub const json_field_names = .{
        .wireless_device_id = "WirelessDeviceId",
    };
};

pub const GetWirelessDeviceStatisticsOutput = struct {
    /// The date and time when the most recent uplink was received.
    ///
    /// This value is only valid for 3 months.
    last_uplink_received_at: ?[]const u8 = null,

    /// Information about the wireless device's operations.
    lo_ra_wan: ?LoRaWANDeviceMetadata = null,

    /// MetaData for Sidewalk device.
    sidewalk: ?SidewalkDeviceMetadata = null,

    /// The ID of the wireless device.
    wireless_device_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_uplink_received_at = "LastUplinkReceivedAt",
        .lo_ra_wan = "LoRaWAN",
        .sidewalk = "Sidewalk",
        .wireless_device_id = "WirelessDeviceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWirelessDeviceStatisticsInput, options: CallOptions) !GetWirelessDeviceStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotwireless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWirelessDeviceStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/wireless-devices/");
    try path_buf.appendSlice(allocator, input.wireless_device_id);
    try path_buf.appendSlice(allocator, "/statistics");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWirelessDeviceStatisticsOutput {
    const result: GetWirelessDeviceStatisticsOutput = try aws.json.parseJsonObject(
        GetWirelessDeviceStatisticsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
