const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageDetails = @import("image_details.zig").ImageDetails;
const TaskStatus = @import("task_status.zig").TaskStatus;

pub const GetRunTaskInput = struct {
    /// The workflow run ID.
    id: []const u8,

    /// The task's ID.
    task_id: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .task_id = "taskId",
    };
};

pub const GetRunTaskOutput = struct {
    /// Set to true if Amazon Web Services HealthOmics found a matching entry in the
    /// run cache for this task.
    cache_hit: ?bool = null,

    /// The S3 URI of the cache location.
    cache_s3_uri: ?[]const u8 = null,

    /// The task's CPU usage.
    cpus: ?i32 = null,

    /// When the task was created.
    creation_time: ?i64 = null,

    /// The reason a task has failed.
    failure_reason: ?[]const u8 = null,

    /// The number of Graphics Processing Units (GPU) specified in the task.
    gpus: ?i32 = null,

    /// Details about the container image that this task uses.
    image_details: ?ImageDetails = null,

    /// The instance type for a task.
    instance_type: ?[]const u8 = null,

    /// The task's log stream.
    log_stream: ?[]const u8 = null,

    /// The task's memory use in gigabytes.
    memory: ?i32 = null,

    /// The task's name.
    name: ?[]const u8 = null,

    /// The task's start time.
    start_time: ?i64 = null,

    /// The task's status.
    status: ?TaskStatus = null,

    /// The task's status message.
    status_message: ?[]const u8 = null,

    /// The task's stop time.
    stop_time: ?i64 = null,

    /// The task's ID.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .cache_hit = "cacheHit",
        .cache_s3_uri = "cacheS3Uri",
        .cpus = "cpus",
        .creation_time = "creationTime",
        .failure_reason = "failureReason",
        .gpus = "gpus",
        .image_details = "imageDetails",
        .instance_type = "instanceType",
        .log_stream = "logStream",
        .memory = "memory",
        .name = "name",
        .start_time = "startTime",
        .status = "status",
        .status_message = "statusMessage",
        .stop_time = "stopTime",
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRunTaskInput, options: CallOptions) !GetRunTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRunTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/run/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/task/");
    try path_buf.appendSlice(allocator, input.task_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRunTaskOutput {
    var result: GetRunTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRunTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
