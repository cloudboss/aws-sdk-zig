const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ErrorReportLocation = @import("error_report_location.zig").ErrorReportLocation;
const File = @import("file.zig").File;
const JobConfiguration = @import("job_configuration.zig").JobConfiguration;
const JobStatus = @import("job_status.zig").JobStatus;

pub const CreateBulkImportJobInput = struct {
    /// If set to true, ingest new data into IoT SiteWise storage. Measurements with
    /// notifications, metrics and transforms are
    /// computed. If set to false, historical data is ingested into IoT SiteWise as
    /// is.
    adaptive_ingestion: ?bool = null,

    /// If set to true, your data files is deleted from S3, after ingestion into IoT
    /// SiteWise storage.
    delete_files_after_import: ?bool = null,

    /// The Amazon S3 destination where errors associated with the job creation
    /// request are saved.
    error_report_location: ErrorReportLocation,

    /// The files in the specified Amazon S3 bucket that contain your data.
    files: []const File,

    /// Contains the configuration information of a job, such as the file format
    /// used to save data in Amazon S3.
    job_configuration: JobConfiguration,

    /// The unique name that helps identify the job request.
    job_name: []const u8,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the IAM role that allows IoT SiteWise to read Amazon S3 data.
    job_role_arn: []const u8,

    pub const json_field_names = .{
        .adaptive_ingestion = "adaptiveIngestion",
        .delete_files_after_import = "deleteFilesAfterImport",
        .error_report_location = "errorReportLocation",
        .files = "files",
        .job_configuration = "jobConfiguration",
        .job_name = "jobName",
        .job_role_arn = "jobRoleArn",
    };
};

pub const CreateBulkImportJobOutput = struct {
    /// The ID of the job.
    job_id: []const u8,

    /// The unique name that helps identify the job request.
    job_name: []const u8,

    /// The status of the bulk import job can be one of following values:
    ///
    /// * `PENDING` – IoT SiteWise is waiting for the current bulk import job to
    ///   finish.
    ///
    /// * `CANCELLED` – The bulk import job has been canceled.
    ///
    /// * `RUNNING` – IoT SiteWise is processing your request to import your data
    ///   from Amazon S3.
    ///
    /// * `COMPLETED` – IoT SiteWise successfully completed your request to import
    ///   data from Amazon S3.
    ///
    /// * `FAILED` – IoT SiteWise couldn't process your request to import data from
    ///   Amazon S3.
    /// You can use logs saved in the specified error report location in Amazon S3
    /// to troubleshoot issues.
    ///
    /// * `COMPLETED_WITH_FAILURES` – IoT SiteWise completed your request to import
    ///   data from Amazon S3 with errors.
    /// You can use logs saved in the specified error report location in Amazon S3
    /// to troubleshoot issues.
    job_status: JobStatus,

    pub const json_field_names = .{
        .job_id = "jobId",
        .job_name = "jobName",
        .job_status = "jobStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBulkImportJobInput, options: Options) !CreateBulkImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotsitewise");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBulkImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/jobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.adaptive_ingestion) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"adaptiveIngestion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.delete_files_after_import) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deleteFilesAfterImport\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"errorReportLocation\":");
    try aws.json.writeValue(@TypeOf(input.error_report_location), input.error_report_location, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"files\":");
    try aws.json.writeValue(@TypeOf(input.files), input.files, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.job_configuration), input.job_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobName\":");
    try aws.json.writeValue(@TypeOf(input.job_name), input.job_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"jobRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.job_role_arn), input.job_role_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBulkImportJobOutput {
    var result: CreateBulkImportJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBulkImportJobOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictingOperationException")) {
        return .{ .arena = arena, .kind = .{ .conflicting_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .query_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
