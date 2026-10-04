const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoRaWANDeviceProfile = @import("lo_ra_wan_device_profile.zig").LoRaWANDeviceProfile;
const SidewalkGetDeviceProfile = @import("sidewalk_get_device_profile.zig").SidewalkGetDeviceProfile;

pub const GetDeviceProfileInput = struct {
    /// The ID of the resource to get.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const GetDeviceProfileOutput = struct {
    /// The Amazon Resource Name of the resource.
    arn: ?[]const u8 = null,

    /// The ID of the device profile.
    id: ?[]const u8 = null,

    /// Information about the device profile.
    lo_ra_wan: ?LoRaWANDeviceProfile = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// Information about the Sidewalk parameters in the device profile.
    sidewalk: ?SidewalkGetDeviceProfile = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .lo_ra_wan = "LoRaWAN",
        .name = "Name",
        .sidewalk = "Sidewalk",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeviceProfileInput, options: CallOptions) !GetDeviceProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeviceProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotwireless", "IoT Wireless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/device-profiles/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeviceProfileOutput {
    var result: GetDeviceProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDeviceProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
