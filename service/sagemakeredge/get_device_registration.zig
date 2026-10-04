const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetDeviceRegistrationInput = struct {
    /// The name of the fleet that the device belongs to.
    device_fleet_name: []const u8,

    /// The unique name of the device you want to get the registration status from.
    device_name: []const u8,

    pub const json_field_names = .{
        .device_fleet_name = "DeviceFleetName",
        .device_name = "DeviceName",
    };
};

pub const GetDeviceRegistrationOutput = struct {
    /// The amount of time, in seconds, that the registration status is stored on
    /// the device’s cache before it is refreshed.
    cache_ttl: ?[]const u8 = null,

    /// Describes if the device is currently registered with SageMaker Edge Manager.
    device_registration: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_ttl = "CacheTTL",
        .device_registration = "DeviceRegistration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeviceRegistrationInput, options: CallOptions) !GetDeviceRegistrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeviceRegistrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("edge.sagemaker", "Sagemaker Edge", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetDeviceRegistration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceFleetName\":");
    try aws.json.writeValue(@TypeOf(input.device_fleet_name), input.device_fleet_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceName\":");
    try aws.json.writeValue(@TypeOf(input.device_name), input.device_name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeviceRegistrationOutput {
    const result: GetDeviceRegistrationOutput = try aws.json.parseJsonObject(
        GetDeviceRegistrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
