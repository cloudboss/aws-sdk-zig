const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartThingRegistrationTaskInput = struct {
    /// The S3 bucket that contains the input file.
    input_file_bucket: []const u8,

    /// The name of input file within the S3 bucket. This file contains a newline
    /// delimited
    /// JSON file. Each line contains the parameter values to provision one device
    /// (thing).
    input_file_key: []const u8,

    /// The IAM role ARN that grants permission the input file.
    role_arn: []const u8,

    /// The provisioning template.
    template_body: []const u8,

    pub const json_field_names = .{
        .input_file_bucket = "inputFileBucket",
        .input_file_key = "inputFileKey",
        .role_arn = "roleArn",
        .template_body = "templateBody",
    };
};

pub const StartThingRegistrationTaskOutput = struct {
    /// The bulk thing provisioning task ID.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartThingRegistrationTaskInput, options: CallOptions) !StartThingRegistrationTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartThingRegistrationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/thing-registration-tasks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputFileBucket\":");
    try aws.json.writeValue(@TypeOf(input.input_file_bucket), input.input_file_bucket, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputFileKey\":");
    try aws.json.writeValue(@TypeOf(input.input_file_key), input.input_file_key, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateBody\":");
    try aws.json.writeValue(@TypeOf(input.template_body), input.template_body, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartThingRegistrationTaskOutput {
    const result: StartThingRegistrationTaskOutput = try aws.json.parseJsonObject(
        StartThingRegistrationTaskOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
