const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceType = @import("device_type.zig").DeviceType;
const JobType = @import("job_type.zig").JobType;
const UpdateProgress = @import("update_progress.zig").UpdateProgress;

pub const DescribeDeviceJobInput = struct {
    /// The job's ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const DescribeDeviceJobOutput = struct {
    /// When the job was created.
    created_time: ?i64 = null,

    /// The device's ARN.
    device_arn: ?[]const u8 = null,

    /// The device's ID.
    device_id: ?[]const u8 = null,

    /// The device's name.
    device_name: ?[]const u8 = null,

    /// The device's type.
    device_type: ?DeviceType = null,

    /// For an OTA job, the target version of the device software.
    image_version: ?[]const u8 = null,

    /// The job's ID.
    job_id: ?[]const u8 = null,

    /// The job's type.
    job_type: ?JobType = null,

    /// The job's status.
    status: ?UpdateProgress = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .device_arn = "DeviceArn",
        .device_id = "DeviceId",
        .device_name = "DeviceName",
        .device_type = "DeviceType",
        .image_version = "ImageVersion",
        .job_id = "JobId",
        .job_type = "JobType",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeviceJobInput, options: CallOptions) !DescribeDeviceJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDeviceJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDeviceJobOutput {
    var result: DescribeDeviceJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDeviceJobOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
