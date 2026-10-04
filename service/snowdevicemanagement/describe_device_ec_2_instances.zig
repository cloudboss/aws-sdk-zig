const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceSummary = @import("instance_summary.zig").InstanceSummary;

pub const DescribeDeviceEc2InstancesInput = struct {
    /// A list of instance IDs associated with the managed device.
    instance_ids: []const []const u8,

    /// The ID of the managed device.
    managed_device_id: []const u8,

    pub const json_field_names = .{
        .instance_ids = "instanceIds",
        .managed_device_id = "managedDeviceId",
    };
};

pub const DescribeDeviceEc2InstancesOutput = struct {
    /// A list of structures containing information about each instance.
    instances: ?[]const InstanceSummary = null,

    pub const json_field_names = .{
        .instances = "instances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeviceEc2InstancesInput, options: CallOptions) !DescribeDeviceEc2InstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snow-device-management", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDeviceEc2InstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snow-device-management", "Snow Device Management", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-device/");
    try path_buf.appendSlice(allocator, input.managed_device_id);
    try path_buf.appendSlice(allocator, "/resources/ec2/describe");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"instanceIds\":");
    try aws.json.writeValue(@TypeOf(input.instance_ids), input.instance_ids, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDeviceEc2InstancesOutput {
    const result: DescribeDeviceEc2InstancesOutput = try aws.json.parseJsonObject(
        DescribeDeviceEc2InstancesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
