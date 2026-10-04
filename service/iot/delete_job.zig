const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteJobInput = struct {
    /// (Optional) When true, you can delete a job which is "IN_PROGRESS".
    /// Otherwise, you
    /// can only delete a job which is in a terminal state ("COMPLETED" or
    /// "CANCELED") or an
    /// exception will occur. The default is false.
    ///
    /// Deleting a job which is "IN_PROGRESS", will cause a device which is
    /// executing
    /// the job to be unable to access job information or update the job execution
    /// status.
    /// Use caution and ensure that each device executing a job which is deleted is
    /// able to
    /// recover to a valid state.
    force: ?bool = null,

    /// The ID of the job to be deleted.
    ///
    /// After a job deletion is completed, you may reuse this jobId when you create
    /// a new
    /// job. However, this is not recommended, and you must ensure that your devices
    /// are not
    /// using the jobId to refer to the deleted job.
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

    pub const json_field_names = .{
        .force = "force",
        .job_id = "jobId",
        .namespace_id = "namespaceId",
    };
};

pub const DeleteJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteJobInput, options: CallOptions) !DeleteJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteJobOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteJobOutput = .{};

    return result;
}
