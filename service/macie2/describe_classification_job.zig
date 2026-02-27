const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const JobStatus = @import("job_status.zig").JobStatus;
const JobType = @import("job_type.zig").JobType;
const LastRunErrorStatus = @import("last_run_error_status.zig").LastRunErrorStatus;
const ManagedDataIdentifierSelector = @import("managed_data_identifier_selector.zig").ManagedDataIdentifierSelector;
const S3JobDefinition = @import("s3_job_definition.zig").S3JobDefinition;
const JobScheduleFrequency = @import("job_schedule_frequency.zig").JobScheduleFrequency;
const Statistics = @import("statistics.zig").Statistics;
const UserPausedDetails = @import("user_paused_details.zig").UserPausedDetails;

pub const DescribeClassificationJobInput = struct {
    /// The unique identifier for the classification job.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
    };
};

pub const DescribeClassificationJobOutput = struct {
    /// An array of unique identifiers, one for each allow list that the job is
    /// configured to use when it analyzes data.
    allow_list_ids: ?[]const []const u8 = null,

    /// The token that was provided to ensure the idempotency of the request to
    /// create the job.
    client_token: ?[]const u8 = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the job was
    /// created.
    created_at: ?i64 = null,

    /// An array of unique identifiers, one for each custom data identifier that the
    /// job is configured to use when it analyzes data. This value is null if the
    /// job is configured to use only managed data identifiers to analyze data.
    custom_data_identifier_ids: ?[]const []const u8 = null,

    /// The custom description of the job.
    description: ?[]const u8 = null,

    /// For a recurring job, specifies whether you configured the job to analyze all
    /// existing, eligible objects immediately after the job was created (true). If
    /// you configured the job to analyze only those objects that were created or
    /// changed after the job was created and before the job's first scheduled run,
    /// this value is false. This value is also false for a one-time job.
    initial_run: ?bool = null,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: ?[]const u8 = null,

    /// The unique identifier for the job.
    job_id: ?[]const u8 = null,

    /// The current status of the job. Possible values are:
    ///
    /// * CANCELLED - You cancelled the job or, if it's a one-time job, you paused
    ///   the job and didn't resume it within 30 days.
    /// * COMPLETE - For a one-time job, Amazon Macie finished processing the data
    ///   specified for the job. This value doesn't apply to recurring jobs.
    /// * IDLE - For a recurring job, the previous scheduled run is complete and the
    ///   next scheduled run is pending. This value doesn't apply to one-time jobs.
    /// * PAUSED - Macie started running the job but additional processing would
    ///   exceed the monthly sensitive data discovery quota for your account or one
    ///   or more member accounts that the job analyzes data for.
    /// * RUNNING - For a one-time job, the job is in progress. For a recurring job,
    ///   a scheduled run is in progress.
    /// * USER_PAUSED - You paused the job. If you paused the job while it had a
    ///   status of RUNNING and you don't resume it within 30 days of pausing it,
    ///   the job or job run will expire and be cancelled, depending on the job's
    ///   type. To check the expiration date, refer to the
    ///   UserPausedDetails.jobExpiresAt property.
    job_status: ?JobStatus = null,

    /// The schedule for running the job. Possible values are:
    ///
    /// * ONE_TIME - The job runs only once.
    /// * SCHEDULED - The job runs on a daily, weekly, or monthly basis. The
    ///   scheduleFrequency property indicates the recurrence pattern for the job.
    job_type: ?JobType = null,

    /// Specifies whether any account- or bucket-level access errors occurred when
    /// the job ran. For a recurring job, this value indicates the error status of
    /// the job's most recent run.
    last_run_error_status: ?LastRunErrorStatus = null,

    /// The date and time, in UTC and extended ISO 8601 format, when the job
    /// started. If the job is a recurring job, this value indicates when the most
    /// recent run started or, if the job hasn't run yet, when the job was created.
    last_run_time: ?i64 = null,

    /// An array of unique identifiers, one for each managed data identifier that
    /// the job is explicitly configured to include (use) or exclude (not use) when
    /// it analyzes data. Inclusion or exclusion depends on the managed data
    /// identifier selection type specified for the job
    /// (managedDataIdentifierSelector).
    ///
    /// This value is null if the job's managed data identifier selection type is
    /// ALL, NONE, or RECOMMENDED.
    managed_data_identifier_ids: ?[]const []const u8 = null,

    /// The selection type that determines which managed data identifiers the job
    /// uses when it analyzes data. Possible values are:
    ///
    /// * ALL - Use all managed data identifiers.
    /// * EXCLUDE - Use all managed data identifiers except the ones specified by
    ///   the managedDataIdentifierIds property.
    /// * INCLUDE - Use only the managed data identifiers specified by the
    ///   managedDataIdentifierIds property.
    /// * NONE - Don't use any managed data identifiers. Use only custom data
    ///   identifiers (customDataIdentifierIds).
    /// * RECOMMENDED (default) - Use the recommended set of managed data
    ///   identifiers.
    ///
    /// If this value is null, the job uses the recommended set of managed data
    /// identifiers.
    ///
    /// If the job is a recurring job and this value is ALL or EXCLUDE, each job run
    /// automatically uses new managed data identifiers that are released. If this
    /// value is null or RECOMMENDED for a recurring job, each job run uses all the
    /// managed data identifiers that are in the recommended set when the run
    /// starts.
    ///
    /// To learn about individual managed data identifiers or determine which ones
    /// are in the recommended set, see [Using managed data
    /// identifiers](https://docs.aws.amazon.com/macie/latest/user/managed-data-identifiers.html) or [Recommended managed data identifiers](https://docs.aws.amazon.com/macie/latest/user/discovery-jobs-mdis-recommended.html) in the *Amazon Macie User Guide*.
    managed_data_identifier_selector: ?ManagedDataIdentifierSelector = null,

    /// The custom name of the job.
    name: ?[]const u8 = null,

    /// The S3 buckets that contain the objects to analyze, and the scope of that
    /// analysis.
    s_3_job_definition: ?S3JobDefinition = null,

    /// The sampling depth, as a percentage, that determines the percentage of
    /// eligible objects that the job analyzes.
    sampling_percentage: ?i32 = null,

    /// The recurrence pattern for running the job. This value is null if the job is
    /// configured to run only once.
    schedule_frequency: ?JobScheduleFrequency = null,

    /// The number of times that the job has run and processing statistics for the
    /// job's current run.
    statistics: ?Statistics = null,

    /// A map of key-value pairs that specifies which tags (keys and values) are
    /// associated with the job.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// If the current status of the job is USER_PAUSED, specifies when the job was
    /// paused and when the job or job run will expire and be cancelled if it isn't
    /// resumed. This value is present only if the value for jobStatus is
    /// USER_PAUSED.
    user_paused_details: ?UserPausedDetails = null,

    pub const json_field_names = .{
        .allow_list_ids = "allowListIds",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .custom_data_identifier_ids = "customDataIdentifierIds",
        .description = "description",
        .initial_run = "initialRun",
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_status = "jobStatus",
        .job_type = "jobType",
        .last_run_error_status = "lastRunErrorStatus",
        .last_run_time = "lastRunTime",
        .managed_data_identifier_ids = "managedDataIdentifierIds",
        .managed_data_identifier_selector = "managedDataIdentifierSelector",
        .name = "name",
        .s_3_job_definition = "s3JobDefinition",
        .sampling_percentage = "samplingPercentage",
        .schedule_frequency = "scheduleFrequency",
        .statistics = "statistics",
        .tags = "tags",
        .user_paused_details = "userPausedDetails",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClassificationJobInput, options: Options) !DescribeClassificationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "macie2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeClassificationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/jobs/");
    try path_buf.appendSlice(alloc, input.job_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeClassificationJobOutput {
    var result: DescribeClassificationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeClassificationJobOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
