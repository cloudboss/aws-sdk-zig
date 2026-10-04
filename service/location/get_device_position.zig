const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PositionalAccuracy = @import("positional_accuracy.zig").PositionalAccuracy;

pub const GetDevicePositionInput = struct {
    /// The device whose position you want to retrieve.
    device_id: []const u8,

    /// The tracker resource receiving the position update.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .tracker_name = "TrackerName",
    };
};

pub const GetDevicePositionOutput = struct {
    /// The accuracy of the device position.
    accuracy: ?PositionalAccuracy = null,

    /// The device whose position you retrieved.
    device_id: ?[]const u8 = null,

    /// The last known device position.
    position: ?[]const f64 = null,

    /// The properties associated with the position.
    position_properties: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp for when the tracker resource received the device position.
    /// Uses [ ISO 8601 ](https://www.iso.org/iso-8601-date-and-time-format.html)
    /// format: `YYYY-MM-DDThh:mm:ss.sssZ`.
    received_time: i64,

    /// The timestamp at which the device's position was determined. Uses [ ISO 8601
    /// ](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    sample_time: i64,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .device_id = "DeviceId",
        .position = "Position",
        .position_properties = "PositionProperties",
        .received_time = "ReceivedTime",
        .sample_time = "SampleTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDevicePositionInput, options: CallOptions) !GetDevicePositionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDevicePositionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tracking/v0/trackers/");
    try path_buf.appendSlice(allocator, input.tracker_name);
    try path_buf.appendSlice(allocator, "/devices/");
    try path_buf.appendSlice(allocator, input.device_id);
    try path_buf.appendSlice(allocator, "/positions/latest");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDevicePositionOutput {
    var result: GetDevicePositionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDevicePositionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
