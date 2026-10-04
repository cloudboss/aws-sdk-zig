const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Rule = @import("rule.zig").Rule;
const DevicePool = @import("device_pool.zig").DevicePool;

pub const UpdateDevicePoolInput = struct {
    /// The Amazon Resource Name (ARN) of the Device Farm device pool to update.
    arn: []const u8,

    /// Sets whether the `maxDevices` parameter applies to your device pool. If you
    /// set this parameter
    /// to `true`, the `maxDevices` parameter does not apply, and Device Farm does
    /// not limit
    /// the number of devices that it adds to your device pool. In this case, Device
    /// Farm adds all available devices
    /// that meet the criteria specified in the `rules` parameter.
    ///
    /// If you use this parameter in your request, you cannot use the `maxDevices`
    /// parameter in the same request.
    clear_max_devices: ?bool = null,

    /// A description of the device pool to update.
    description: ?[]const u8 = null,

    /// The number of devices that Device Farm can add to your device pool. Device
    /// Farm adds
    /// devices that are available and that meet the criteria that you assign for
    /// the
    /// `rules` parameter. Depending on how many devices meet these constraints,
    /// your device pool might contain fewer devices than the value for this
    /// parameter.
    ///
    /// By specifying the maximum number of devices, you can control the costs that
    /// you incur
    /// by running tests.
    ///
    /// If you use this parameter in your request, you cannot use the
    /// `clearMaxDevices` parameter in the same request.
    max_devices: ?i32 = null,

    /// A string that represents the name of the device pool to update.
    name: ?[]const u8 = null,

    /// Represents the rules to modify for the device pool. Updating rules is
    /// optional. If you update rules for
    /// your request, the update replaces the existing rules.
    rules: ?[]const Rule = null,

    pub const json_field_names = .{
        .arn = "arn",
        .clear_max_devices = "clearMaxDevices",
        .description = "description",
        .max_devices = "maxDevices",
        .name = "name",
        .rules = "rules",
    };
};

pub const UpdateDevicePoolOutput = struct {
    /// The device pool you just updated.
    device_pool: ?DevicePool = null,

    pub const json_field_names = .{
        .device_pool = "devicePool",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDevicePoolInput, options: CallOptions) !UpdateDevicePoolOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDevicePoolInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.UpdateDevicePool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDevicePoolOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDevicePoolOutput, body, allocator);
}
