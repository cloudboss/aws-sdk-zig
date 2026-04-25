const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const JobAction = @import("job_action.zig").JobAction;
const JobActionOptions = @import("job_action_options.zig").JobActionOptions;
const JobInputOptions = @import("job_input_options.zig").JobInputOptions;
const JobOutputOptions = @import("job_output_options.zig").JobOutputOptions;
const JobStatus = @import("job_status.zig").JobStatus;

pub const StartJobInput = struct {
    /// The action to perform on the input data.
    action: JobAction,

    /// Additional parameters that can be requested for each result.
    action_options: ?JobActionOptions = null,

    /// A unique identifier for this request to ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon Location Service
    /// assumes during job processing. Amazon Location Service uses this role to
    /// access the input and output locations specified for the job.
    ///
    /// The IAM role must be created in the same Amazon Web Services account where
    /// you plan to run your job.
    ///
    /// For more information about configuring IAM roles for Amazon Location jobs,
    /// see [Configure IAM
    /// permissions](https://docs.aws.amazon.com/location/latest/developerguide/configure-iam-role-policy-credentials.html) in the *Amazon Location Service Developer Guide*.
    execution_role_arn: []const u8,

    /// Configuration for input data location and format.
    ///
    /// Input files have a limitation of 10gb per file, and 1gb per Parquet
    /// row-group within the file.
    input_options: JobInputOptions,

    /// An optional name for the job resource.
    name: ?[]const u8 = null,

    /// Configuration for output data location and format.
    output_options: JobOutputOptions,

    /// Tags and corresponding values to be associated with the job.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action = "Action",
        .action_options = "ActionOptions",
        .client_token = "ClientToken",
        .execution_role_arn = "ExecutionRoleArn",
        .input_options = "InputOptions",
        .name = "Name",
        .output_options = "OutputOptions",
        .tags = "Tags",
    };
};

pub const StartJobOutput = struct {
    /// Job creation time in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sss`.
    created_at: i64,

    /// The Amazon Resource Name (ARN) for the job resource. Used when you need to
    /// specify a resource across all Amazon Web Services.
    ///
    /// Format example: `arn:aws:geo:region:account-id:job/ExampleJob`
    job_arn: []const u8,

    /// Unique job identifier.
    job_id: []const u8,

    /// Initial job status (always "Pending" for new jobs).
    status: JobStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .job_arn = "JobArn",
        .job_id = "JobId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartJobInput, options: CallOptions) !StartJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "geo");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/metadata/v0/jobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.action_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ActionOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExecutionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InputOptions\":");
    try aws.json.writeValue(@TypeOf(input.input_options), input.input_options, allocator, &body_buf);
    has_prev = true;
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputOptions\":");
    try aws.json.writeValue(@TypeOf(input.output_options), input.output_options, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartJobOutput {
    var result: StartJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartJobOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
