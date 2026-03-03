const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const JobExecutionStatus = @import("job_execution_status.zig").JobExecutionStatus;
const JobExecutionState = @import("job_execution_state.zig").JobExecutionState;

pub const UpdateJobExecutionInput = struct {
    /// Optional. A number that identifies a particular job execution on a
    /// particular
    /// device.
    execution_number: ?i64 = null,

    /// Optional. The expected current version of the job execution. Each time you
    /// update the
    /// job execution, its version is incremented. If the version of the job
    /// execution stored in
    /// Jobs does not match, the update is rejected with a VersionMismatch error,
    /// and an
    /// ErrorResponse that contains the current job execution status data is
    /// returned. (This makes
    /// it unnecessary to perform a separate DescribeJobExecution request in order
    /// to obtain the
    /// job execution status data.)
    expected_version: ?i64 = null,

    /// Optional. When set to true, the response contains the job document. The
    /// default is
    /// false.
    include_job_document: ?bool = null,

    /// Optional. When included and set to true, the response contains the
    /// JobExecutionState
    /// data. The default is false.
    include_job_execution_state: ?bool = null,

    /// The unique identifier assigned to this job when it was created.
    job_id: []const u8,

    /// The new status for the job execution (IN_PROGRESS, FAILED, SUCCESS, or
    /// REJECTED).
    /// This must be specified on every update.
    status: JobExecutionStatus,

    /// Optional. A collection of name/value pairs that describe the status of the
    /// job
    /// execution. If not specified, the statusDetails are unchanged.
    ///
    /// The maximum length of the value in the name/value pair is 1,024 characters.
    status_details: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the amount of time this device has to finish execution of this
    /// job. If the job
    /// execution status is not set to a terminal state before this timer expires,
    /// or before the
    /// timer is reset (by again calling `UpdateJobExecution`, setting the status to
    /// `IN_PROGRESS`, and specifying a new timeout value in this field) the job
    /// execution status will be automatically set to `TIMED_OUT`. Note that setting
    /// or
    /// resetting the step timeout has no effect on the in progress timeout that may
    /// have been
    /// specified when the job was created (`CreateJob` using field
    /// `timeoutConfig`).
    ///
    /// Valid values for this parameter range from 1 to 10080 (1 minute to 7 days).
    /// A value of
    /// -1 is also valid and will cancel the current step timer (created by an
    /// earlier use of
    /// `UpdateJobExecutionRequest`).
    step_timeout_in_minutes: ?i64 = null,

    /// The name of the thing associated with the device.
    thing_name: []const u8,

    pub const json_field_names = .{
        .execution_number = "executionNumber",
        .expected_version = "expectedVersion",
        .include_job_document = "includeJobDocument",
        .include_job_execution_state = "includeJobExecutionState",
        .job_id = "jobId",
        .status = "status",
        .status_details = "statusDetails",
        .step_timeout_in_minutes = "stepTimeoutInMinutes",
        .thing_name = "thingName",
    };
};

pub const UpdateJobExecutionOutput = struct {
    /// A JobExecutionState object.
    execution_state: ?JobExecutionState = null,

    /// The contents of the Job Documents.
    job_document: ?[]const u8 = null,

    pub const json_field_names = .{
        .execution_state = "executionState",
        .job_document = "jobDocument",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateJobExecutionInput, options: CallOptions) !UpdateJobExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotjobsdataplane");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateJobExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotjobsdataplane", "IoT Jobs Data Plane", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/jobs/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.execution_number) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionNumber\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.expected_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expectedVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_job_document) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeJobDocument\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_job_execution_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeJobExecutionState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
    has_prev = true;
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateJobExecutionOutput {
    var result: UpdateJobExecutionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateJobExecutionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "CertificateValidationException")) {
        return .{ .arena = arena, .kind = .{ .certificate_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_transition_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TerminalStateException")) {
        return .{ .arena = arena, .kind = .{ .terminal_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
