const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EarthObservationJobErrorDetails = @import("earth_observation_job_error_details.zig").EarthObservationJobErrorDetails;
const ExportErrorDetails = @import("export_error_details.zig").ExportErrorDetails;
const EarthObservationJobExportStatus = @import("earth_observation_job_export_status.zig").EarthObservationJobExportStatus;
const InputConfigOutput = @import("input_config_output.zig").InputConfigOutput;
const JobConfigInput = @import("job_config_input.zig").JobConfigInput;
const OutputBand = @import("output_band.zig").OutputBand;
const EarthObservationJobStatus = @import("earth_observation_job_status.zig").EarthObservationJobStatus;

pub const GetEarthObservationJobInput = struct {
    /// The Amazon Resource Name (ARN) of the Earth Observation job.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub const GetEarthObservationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the Earth Observation job.
    arn: []const u8,

    /// The creation time of the initiated Earth Observation job.
    creation_time: i64,

    /// The duration of Earth Observation job, in seconds.
    duration_in_seconds: i32,

    /// Details about the errors generated during the Earth Observation job.
    error_details: ?EarthObservationJobErrorDetails = null,

    /// The Amazon Resource Name (ARN) of the IAM role that you specified for the
    /// job.
    execution_role_arn: ?[]const u8 = null,

    /// Details about the errors generated during ExportEarthObservationJob.
    export_error_details: ?ExportErrorDetails = null,

    /// The status of the Earth Observation job.
    export_status: ?EarthObservationJobExportStatus = null,

    /// Input data for the Earth Observation job.
    input_config: ?InputConfigOutput = null,

    /// An object containing information about the job configuration.
    job_config: ?JobConfigInput = null,

    /// The Key Management Service key ID for server-side encryption.
    kms_key_id: ?[]const u8 = null,

    /// The name of the Earth Observation job.
    name: []const u8,

    /// Bands available in the output of an operation.
    output_bands: ?[]const OutputBand = null,

    /// The status of a previously initiated Earth Observation job.
    status: EarthObservationJobStatus,

    /// Each tag consists of a key and a value.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .duration_in_seconds = "DurationInSeconds",
        .error_details = "ErrorDetails",
        .execution_role_arn = "ExecutionRoleArn",
        .export_error_details = "ExportErrorDetails",
        .export_status = "ExportStatus",
        .input_config = "InputConfig",
        .job_config = "JobConfig",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .output_bands = "OutputBands",
        .status = "Status",
        .tags = "Tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEarthObservationJobInput, options: Options) !GetEarthObservationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemakergeospatial");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetEarthObservationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemakergeospatial", "SageMaker Geospatial", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/earth-observation-jobs/");
    try path_buf.appendSlice(alloc, input.arn);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetEarthObservationJobOutput {
    var result: GetEarthObservationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEarthObservationJobOutput, body, alloc);
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
