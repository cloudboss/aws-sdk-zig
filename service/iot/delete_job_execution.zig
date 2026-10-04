const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteJobExecutionInput = struct {
    /// The ID of the job execution to be deleted. The `executionNumber` refers
    /// to the execution of a particular job on a particular device.
    ///
    /// Note that once a job execution is deleted, the `executionNumber` may be
    /// reused by IoT, so be sure you get and use the correct value here.
    execution_number: i64,

    /// (Optional) When true, you can delete a job execution which is "IN_PROGRESS".
    /// Otherwise, you can only delete a job execution which is in a terminal state
    /// ("SUCCEEDED", "FAILED", "REJECTED", "REMOVED" or "CANCELED") or an exception
    /// will occur.
    /// The default is false.
    ///
    /// Deleting a job execution which is "IN_PROGRESS", will cause the device to be
    /// unable to access job information or update the job execution status. Use
    /// caution and
    /// ensure that the device is able to recover to a valid state.
    force: ?bool = null,

    /// The ID of the job whose execution on a particular device will be deleted.
    job_id: []const u8,

    /// The namespace used to indicate that a job is a customer-managed job.
    ///
    /// When you specify a value for this parameter, Amazon Web Services IoT Core
    /// sends jobs notifications to
    /// MQTT topics that contain the value in the following format.
    ///
    /// `$aws/things/*THING_NAME*/jobs/*JOB_ID*/notify-namespace-*NAMESPACE_ID*/`
    ///
    /// The `namespaceId` feature is only supported by IoT Greengrass at this time.
    /// For
    /// more information, see [Setting up IoT Greengrass core
    /// devices.](https://docs.aws.amazon.com/greengrass/v2/developerguide/setting-up.html)
    namespace_id: ?[]const u8 = null,

    /// The name of the thing whose job execution will be deleted.
    thing_name: []const u8,

    pub const json_field_names = .{
        .execution_number = "executionNumber",
        .force = "force",
        .job_id = "jobId",
        .namespace_id = "namespaceId",
        .thing_name = "thingName",
    };
};

pub const DeleteJobExecutionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteJobExecutionInput, options: CallOptions) !DeleteJobExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteJobExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    try path_buf.appendSlice(allocator, "/executionNumber/");
    try path_buf.appendSlice(allocator, input.execution_number);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.force) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "force=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.namespace_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "namespaceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteJobExecutionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteJobExecutionOutput = .{};

    return result;
}
