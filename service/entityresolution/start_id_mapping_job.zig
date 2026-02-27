const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const JobType = @import("job_type.zig").JobType;
const IdMappingJobOutputSource = @import("id_mapping_job_output_source.zig").IdMappingJobOutputSource;

pub const StartIdMappingJobInput = struct {
    /// The job type for the ID mapping job.
    ///
    /// If the `jobType` value is set to `INCREMENTAL`, only new or changed data is
    /// processed since the last job run. This is the default value if the
    /// `CreateIdMappingWorkflow` API is configured with an `incrementalRunConfig`.
    ///
    /// If the `jobType` value is set to `BATCH`, all data is processed from the
    /// input source, regardless of previous job runs. This is the default value if
    /// the `CreateIdMappingWorkflow` API isn't configured with an
    /// `incrementalRunConfig`.
    ///
    /// If the `jobType` value is set to `DELETE_ONLY`, only deletion requests from
    /// `BatchDeleteUniqueIds` are processed.
    job_type: ?JobType = null,

    /// A list of `OutputSource` objects.
    output_source_config: ?[]const IdMappingJobOutputSource = null,

    /// The name of the ID mapping job to be retrieved.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .job_type = "jobType",
        .output_source_config = "outputSourceConfig",
        .workflow_name = "workflowName",
    };
};

pub const StartIdMappingJobOutput = struct {
    /// The ID of the job.
    job_id: []const u8,

    /// The job type for the started ID mapping job.
    ///
    /// A value of `INCREMENTAL` indicates that only new or changed data was
    /// processed since the last job run. This is the default job type if the
    /// workflow was created with an `incrementalRunConfig`.
    ///
    /// A value of `BATCH` indicates that all data was processed from the input
    /// source, regardless of previous job runs. This is the default job type if the
    /// workflow wasn't created with an `incrementalRunConfig`.
    ///
    /// A value of `DELETE_ONLY` indicates that only deletion requests from
    /// `BatchDeleteUniqueIds` were processed.
    job_type: ?JobType = null,

    /// A list of `OutputSource` objects.
    output_source_config: ?[]const IdMappingJobOutputSource = null,

    pub const json_field_names = .{
        .job_id = "jobId",
        .job_type = "jobType",
        .output_source_config = "outputSourceConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartIdMappingJobInput, options: Options) !StartIdMappingJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "entityresolution");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: StartIdMappingJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/idmappingworkflows/");
    try path_buf.appendSlice(alloc, input.workflow_name);
    try path_buf.appendSlice(alloc, "/jobs");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.job_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"jobType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.output_source_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"outputSourceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartIdMappingJobOutput {
    var result: StartIdMappingJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartIdMappingJobOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "ExceedsLimitException")) {
        return .{ .arena = arena, .kind = .{ .exceeds_limit_exception = .{
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
