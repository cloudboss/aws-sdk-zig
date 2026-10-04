const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CoreDeviceStatus = @import("core_device_status.zig").CoreDeviceStatus;

pub const GetCoreDeviceInput = struct {
    /// The name of the core device. This is also the name of the IoT thing.
    core_device_thing_name: []const u8,

    pub const json_field_names = .{
        .core_device_thing_name = "coreDeviceThingName",
    };
};

pub const GetCoreDeviceOutput = struct {
    /// The computer architecture of the core device.
    architecture: ?[]const u8 = null,

    /// The name of the core device. This is also the name of the IoT thing.
    core_device_thing_name: ?[]const u8 = null,

    /// The version of the IoT Greengrass Core software that the core device runs.
    /// This version is equivalent to
    /// the version of the Greengrass nucleus component that runs on the core
    /// device. For more information,
    /// see the [Greengrass nucleus
    /// component](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-nucleus-component.html) in the *IoT Greengrass V2 Developer Guide*.
    core_version: ?[]const u8 = null,

    /// The time at which the core device's status last updated, expressed in ISO
    /// 8601
    /// format.
    last_status_update_timestamp: ?i64 = null,

    /// The operating system platform that the core device runs.
    platform: ?[]const u8 = null,

    /// The runtime for the core device. The runtime can be:
    ///
    /// * `aws_nucleus_classic`
    ///
    /// * `aws_nucleus_lite`
    runtime: ?[]const u8 = null,

    /// The status of the core device. The core device status can be:
    ///
    /// * `HEALTHY` – The IoT Greengrass Core software and all components run on the
    ///   core device without issue.
    ///
    /// * `UNHEALTHY` – The IoT Greengrass Core software or a component is in a
    ///   failed state
    /// on the core device.
    status: ?CoreDeviceStatus = null,

    /// A list of key-value pairs that contain metadata for the resource. For more
    /// information, see [Tag your
    /// resources](https://docs.aws.amazon.com/greengrass/v2/developerguide/tag-resources.html) in the *IoT Greengrass V2 Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .core_device_thing_name = "coreDeviceThingName",
        .core_version = "coreVersion",
        .last_status_update_timestamp = "lastStatusUpdateTimestamp",
        .platform = "platform",
        .runtime = "runtime",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCoreDeviceInput, options: CallOptions) !GetCoreDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCoreDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "GreengrassV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/v2/coreDevices/");
    try path_buf.appendSlice(allocator, input.core_device_thing_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCoreDeviceOutput {
    var result: GetCoreDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCoreDeviceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
