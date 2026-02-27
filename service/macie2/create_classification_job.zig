const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const JobType = @import("job_type.zig").JobType;
const ManagedDataIdentifierSelector = @import("managed_data_identifier_selector.zig").ManagedDataIdentifierSelector;
const S3JobDefinition = @import("s3_job_definition.zig").S3JobDefinition;
const JobScheduleFrequency = @import("job_schedule_frequency.zig").JobScheduleFrequency;

pub const CreateClassificationJobInput = struct {
    /// An array of unique identifiers, one for each allow list for the job to use
    /// when it analyzes data.
    allow_list_ids: ?[]const []const u8 = null,

    /// A unique, case-sensitive token that you provide to ensure the idempotency of
    /// the request.
    client_token: []const u8,

    /// An array of unique identifiers, one for each custom data identifier for the
    /// job to use when it analyzes data. To use only managed data identifiers,
    /// don't specify a value for this property and specify a value other than NONE
    /// for the managedDataIdentifierSelector property.
    custom_data_identifier_ids: ?[]const []const u8 = null,

    /// A custom description of the job. The description can contain as many as 200
    /// characters.
    description: ?[]const u8 = null,

    /// For a recurring job, specifies whether to analyze all existing, eligible
    /// objects immediately after the job is created (true). To analyze only those
    /// objects that are created or changed after you create the job and before the
    /// job's first scheduled run, set this value to false.
    ///
    /// If you configure the job to run only once, don't specify a value for this
    /// property.
    initial_run: ?bool = null,

    /// The schedule for running the job. Valid values are:
    ///
    /// * ONE_TIME - Run the job only once. If you specify this value, don't specify
    ///   a value for the scheduleFrequency property.
    /// * SCHEDULED - Run the job on a daily, weekly, or monthly basis. If you
    ///   specify this value, use the scheduleFrequency property to specify the
    ///   recurrence pattern for the job.
    job_type: JobType,

    /// An array of unique identifiers, one for each managed data identifier for the
    /// job to include (use) or exclude (not use) when it analyzes data. Inclusion
    /// or exclusion depends on the managed data identifier selection type that you
    /// specify for the job (managedDataIdentifierSelector).
    ///
    /// To retrieve a list of valid values for this property, use the
    /// ListManagedDataIdentifiers operation.
    managed_data_identifier_ids: ?[]const []const u8 = null,

    /// The selection type to apply when determining which managed data identifiers
    /// the job uses to analyze data. Valid values are:
    ///
    /// * ALL - Use all managed data identifiers. If you specify this value, don't
    ///   specify any values for the managedDataIdentifierIds property.
    /// * EXCLUDE - Use all managed data identifiers except the ones specified by
    ///   the managedDataIdentifierIds property.
    /// * INCLUDE - Use only the managed data identifiers specified by the
    ///   managedDataIdentifierIds property.
    /// * NONE - Don't use any managed data identifiers. If you specify this value,
    ///   specify at least one value for the customDataIdentifierIds property and
    ///   don't specify any values for the managedDataIdentifierIds property.
    /// * RECOMMENDED (default) - Use the recommended set of managed data
    ///   identifiers. If you specify this value, don't specify any values for the
    ///   managedDataIdentifierIds property.
    ///
    /// If you don't specify a value for this property, the job uses the recommended
    /// set of managed data identifiers.
    ///
    /// If the job is a recurring job and you specify ALL or EXCLUDE, each job run
    /// automatically uses new managed data identifiers that are released. If you
    /// don't specify a value for this property or you specify RECOMMENDED for a
    /// recurring job, each job run automatically uses all the managed data
    /// identifiers that are in the recommended set when the run starts.
    ///
    /// To learn about individual managed data identifiers or determine which ones
    /// are in the recommended set, see [Using managed data
    /// identifiers](https://docs.aws.amazon.com/macie/latest/user/managed-data-identifiers.html) or [Recommended managed data identifiers](https://docs.aws.amazon.com/macie/latest/user/discovery-jobs-mdis-recommended.html) in the *Amazon Macie User Guide*.
    managed_data_identifier_selector: ?ManagedDataIdentifierSelector = null,

    /// A custom name for the job. The name can contain as many as 500 characters.
    name: []const u8,

    /// The S3 buckets that contain the objects to analyze, and the scope of that
    /// analysis.
    s_3_job_definition: S3JobDefinition,

    /// The sampling depth, as a percentage, for the job to apply when processing
    /// objects. This value determines the percentage of eligible objects that the
    /// job analyzes. If this value is less than 100, Amazon Macie selects the
    /// objects to analyze at random, up to the specified percentage, and analyzes
    /// all the data in those objects.
    sampling_percentage: ?i32 = null,

    /// The recurrence pattern for running the job. To run the job only once, don't
    /// specify a value for this property and set the value for the jobType property
    /// to ONE_TIME.
    schedule_frequency: ?JobScheduleFrequency = null,

    /// A map of key-value pairs that specifies the tags to associate with the job.
    ///
    /// A job can have a maximum of 50 tags. Each tag consists of a tag key and an
    /// associated tag value. The maximum length of a tag key is 128 characters. The
    /// maximum length of a tag value is 256 characters.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .allow_list_ids = "allowListIds",
        .client_token = "clientToken",
        .custom_data_identifier_ids = "customDataIdentifierIds",
        .description = "description",
        .initial_run = "initialRun",
        .job_type = "jobType",
        .managed_data_identifier_ids = "managedDataIdentifierIds",
        .managed_data_identifier_selector = "managedDataIdentifierSelector",
        .name = "name",
        .s_3_job_definition = "s3JobDefinition",
        .sampling_percentage = "samplingPercentage",
        .schedule_frequency = "scheduleFrequency",
        .tags = "tags",
    };
};

pub const CreateClassificationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the job.
    job_arn: ?[]const u8 = null,

    /// The unique identifier for the job.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_arn = "jobArn",
        .job_id = "jobId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClassificationJobInput, options: Options) !CreateClassificationJobOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateClassificationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/jobs";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.allow_list_ids) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"allowListIds\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, alloc, &body_buf);
    has_prev = true;
    if (input.custom_data_identifier_ids) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"customDataIdentifierIds\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.initial_run) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"initialRun\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"jobType\":");
    try aws.json.writeValue(@TypeOf(input.job_type), input.job_type, alloc, &body_buf);
    has_prev = true;
    if (input.managed_data_identifier_ids) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"managedDataIdentifierIds\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.managed_data_identifier_selector) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"managedDataIdentifierSelector\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"s3JobDefinition\":");
    try aws.json.writeValue(@TypeOf(input.s_3_job_definition), input.s_3_job_definition, alloc, &body_buf);
    has_prev = true;
    if (input.sampling_percentage) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"samplingPercentage\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.schedule_frequency) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"scheduleFrequency\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateClassificationJobOutput {
    var result: CreateClassificationJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateClassificationJobOutput, body, alloc);
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
