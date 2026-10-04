const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeviceJobConfig = @import("device_job_config.zig").DeviceJobConfig;
const JobType = @import("job_type.zig").JobType;
const Job = @import("job.zig").Job;

pub const CreateJobForDevicesInput = struct {
    /// ID of target device.
    device_ids: []const []const u8,

    /// Configuration settings for a software update job.
    device_job_config: ?DeviceJobConfig = null,

    /// The type of job to run.
    job_type: JobType,

    pub const json_field_names = .{
        .device_ids = "DeviceIds",
        .device_job_config = "DeviceJobConfig",
        .job_type = "JobType",
    };
};

pub const CreateJobForDevicesOutput = struct {
    /// A list of jobs.
    jobs: ?[]const Job = null,

    pub const json_field_names = .{
        .jobs = "Jobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobForDevicesInput, options: CallOptions) !CreateJobForDevicesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateJobForDevicesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeviceIds\":");
    try aws.json.writeValue(@TypeOf(input.device_ids), input.device_ids, allocator, &body_buf);
    has_prev = true;
    if (input.device_job_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeviceJobConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"JobType\":");
    try aws.json.writeValue(@TypeOf(input.job_type), input.job_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateJobForDevicesOutput {
    var result: CreateJobForDevicesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateJobForDevicesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
