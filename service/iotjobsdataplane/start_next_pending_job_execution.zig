const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobExecution = @import("job_execution.zig").JobExecution;

pub const StartNextPendingJobExecutionInput = struct {
    /// A collection of name/value pairs that describe the status of the job
    /// execution. If
    /// not specified, the statusDetails are unchanged.
    ///
    /// The maximum length of the value in the name/value pair is 1,024 characters.
    status_details: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the amount of time this device has to finish execution of this
    /// job. If the job
    /// execution status is not set to a terminal state before this timer expires,
    /// or before the
    /// timer is reset (by calling `UpdateJobExecution`, setting the status to
    /// `IN_PROGRESS`, and specifying a new timeout value in field
    /// `stepTimeoutInMinutes`) the job execution status will be automatically set
    /// to
    /// `TIMED_OUT`. Note that setting the step timeout has no effect on the in
    /// progress timeout that may have been specified when the job was created
    /// (`CreateJob` using field `timeoutConfig`).
    ///
    /// Valid values for this parameter range from 1 to 10080 (1 minute to 7 days).
    step_timeout_in_minutes: ?i64 = null,

    /// The name of the thing associated with the device.
    thing_name: []const u8,

    pub const json_field_names = .{
        .status_details = "statusDetails",
        .step_timeout_in_minutes = "stepTimeoutInMinutes",
        .thing_name = "thingName",
    };
};

pub const StartNextPendingJobExecutionOutput = struct {
    /// A JobExecution object.
    execution: ?JobExecution = null,

    pub const json_field_names = .{
        .execution = "execution",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartNextPendingJobExecutionInput, options: CallOptions) !StartNextPendingJobExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot-jobs-data", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartNextPendingJobExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.jobs.iot", "IoT Jobs Data Plane", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/jobs/$next");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.status_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"statusDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.step_timeout_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stepTimeoutInMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartNextPendingJobExecutionOutput {
    var result: StartNextPendingJobExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartNextPendingJobExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
