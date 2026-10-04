const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceState = @import("device_state.zig").DeviceState;
const DistanceUnit = @import("distance_unit.zig").DistanceUnit;
const InferredState = @import("inferred_state.zig").InferredState;

pub const VerifyDevicePositionInput = struct {
    /// The device's state, including position, IP address, cell signals and Wi-Fi
    /// access points.
    device_state: DeviceState,

    /// The distance unit for the verification request.
    ///
    /// Default Value: `Kilometers`
    distance_unit: ?DistanceUnit = null,

    /// The name of the tracker resource to be associated with verification request.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .device_state = "DeviceState",
        .distance_unit = "DistanceUnit",
        .tracker_name = "TrackerName",
    };
};

pub const VerifyDevicePositionOutput = struct {
    /// The device identifier.
    device_id: []const u8,

    /// The distance unit for the verification response.
    distance_unit: DistanceUnit,

    /// The inferred state of the device, given the provided position, IP address,
    /// cellular signals, and Wi-Fi- access points.
    inferred_state: ?InferredState = null,

    /// The timestamp for when the tracker resource received the device position in
    /// [ ISO 8601 ](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    received_time: i64,

    /// The timestamp at which the device's position was determined. Uses [ ISO 8601
    /// ](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    sample_time: i64,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .distance_unit = "DistanceUnit",
        .inferred_state = "InferredState",
        .received_time = "ReceivedTime",
        .sample_time = "SampleTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: VerifyDevicePositionInput, options: CallOptions) !VerifyDevicePositionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: VerifyDevicePositionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tracking/v0/trackers/");
    try path_buf.appendSlice(allocator, input.tracker_name);
    try path_buf.appendSlice(allocator, "/positions/verify");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceState\":");
    try aws.json.writeValue(@TypeOf(input.device_state), input.device_state, allocator, &body_buf);
    has_prev = true;
    if (input.distance_unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DistanceUnit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !VerifyDevicePositionOutput {
    const result: VerifyDevicePositionOutput = try aws.json.parseJsonObject(
        VerifyDevicePositionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
