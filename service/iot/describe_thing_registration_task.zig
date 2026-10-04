const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Status = @import("status.zig").Status;

pub const DescribeThingRegistrationTaskInput = struct {
    /// The task ID.
    task_id: []const u8,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub const DescribeThingRegistrationTaskOutput = struct {
    /// The task creation date.
    creation_date: ?i64 = null,

    /// The number of things that failed to be provisioned.
    failure_count: ?i32 = null,

    /// The S3 bucket that contains the input file.
    input_file_bucket: ?[]const u8 = null,

    /// The input file key.
    input_file_key: ?[]const u8 = null,

    /// The date when the task was last modified.
    last_modified_date: ?i64 = null,

    /// The message.
    message: ?[]const u8 = null,

    /// The progress of the bulk provisioning task expressed as a percentage.
    percentage_progress: ?i32 = null,

    /// The role ARN that grants access to the input file bucket.
    role_arn: ?[]const u8 = null,

    /// The status of the bulk thing provisioning task.
    status: ?Status = null,

    /// The number of things successfully provisioned.
    success_count: ?i32 = null,

    /// The task ID.
    task_id: ?[]const u8 = null,

    /// The task's template.
    template_body: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .failure_count = "failureCount",
        .input_file_bucket = "inputFileBucket",
        .input_file_key = "inputFileKey",
        .last_modified_date = "lastModifiedDate",
        .message = "message",
        .percentage_progress = "percentageProgress",
        .role_arn = "roleArn",
        .status = "status",
        .success_count = "successCount",
        .task_id = "taskId",
        .template_body = "templateBody",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeThingRegistrationTaskInput, options: CallOptions) !DescribeThingRegistrationTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeThingRegistrationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/thing-registration-tasks/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeThingRegistrationTaskOutput {
    var result: DescribeThingRegistrationTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeThingRegistrationTaskOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
