const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DatabaseOutput = @import("database_output.zig").DatabaseOutput;
const DataCatalogOutput = @import("data_catalog_output.zig").DataCatalogOutput;
const JobSample = @import("job_sample.zig").JobSample;
const LogSubscription = @import("log_subscription.zig").LogSubscription;
const Output = @import("output.zig").Output;
const ProfileConfiguration = @import("profile_configuration.zig").ProfileConfiguration;
const RecipeReference = @import("recipe_reference.zig").RecipeReference;
const JobRunState = @import("job_run_state.zig").JobRunState;
const ValidationConfiguration = @import("validation_configuration.zig").ValidationConfiguration;

pub const DescribeJobRunInput = struct {
    /// The name of the job being processed during this run.
    name: []const u8,

    /// The unique identifier of the job run.
    run_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .run_id = "RunId",
    };
};

pub const DescribeJobRunOutput = struct {
    /// The number of times that DataBrew has attempted to run the job.
    attempt: i32 = 0,

    /// The date and time when the job completed processing.
    completed_on: ?i64 = null,

    /// Represents a list of JDBC database output objects which defines the output
    /// destination for a DataBrew recipe job to write into.
    database_outputs: ?[]const DatabaseOutput = null,

    /// One or more artifacts that represent the Glue Data Catalog output from
    /// running the job.
    data_catalog_outputs: ?[]const DataCatalogOutput = null,

    /// The name of the dataset for the job to process.
    dataset_name: ?[]const u8 = null,

    /// A message indicating an error (if any) that was encountered when the job
    /// ran.
    error_message: ?[]const u8 = null,

    /// The amount of time, in seconds, during which the job run consumed resources.
    execution_time: i32 = 0,

    /// The name of the job being processed during this run.
    job_name: []const u8,

    /// Sample configuration for profile jobs only. Determines the number of rows on
    /// which the
    /// profile job will be executed. If a JobSample value is not provided, the
    /// default value
    /// will be used. The default value is CUSTOM_ROWS for the mode parameter and
    /// 20000 for the
    /// size parameter.
    job_sample: ?JobSample = null,

    /// The name of an Amazon CloudWatch log group, where the job writes diagnostic
    /// messages
    /// when it runs.
    log_group_name: ?[]const u8 = null,

    /// The current status of Amazon CloudWatch logging for the job run.
    log_subscription: ?LogSubscription = null,

    /// One or more output artifacts from a job run.
    outputs: ?[]const Output = null,

    /// Configuration for profile jobs. Used to select columns, do evaluations,
    /// and override default parameters of evaluations. When configuration is null,
    /// the
    /// profile job will run with default settings.
    profile_configuration: ?ProfileConfiguration = null,

    recipe_reference: ?RecipeReference = null,

    /// The unique identifier of the job run.
    run_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user who started the job run.
    started_by: ?[]const u8 = null,

    /// The date and time when the job run began.
    started_on: ?i64 = null,

    /// The current state of the job run entity itself.
    state: ?JobRunState = null,

    /// List of validation configurations that are applied to the profile job.
    validation_configurations: ?[]const ValidationConfiguration = null,

    pub const json_field_names = .{
        .attempt = "Attempt",
        .completed_on = "CompletedOn",
        .database_outputs = "DatabaseOutputs",
        .data_catalog_outputs = "DataCatalogOutputs",
        .dataset_name = "DatasetName",
        .error_message = "ErrorMessage",
        .execution_time = "ExecutionTime",
        .job_name = "JobName",
        .job_sample = "JobSample",
        .log_group_name = "LogGroupName",
        .log_subscription = "LogSubscription",
        .outputs = "Outputs",
        .profile_configuration = "ProfileConfiguration",
        .recipe_reference = "RecipeReference",
        .run_id = "RunId",
        .started_by = "StartedBy",
        .started_on = "StartedOn",
        .state = "State",
        .validation_configurations = "ValidationConfigurations",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeJobRunInput, options: Options) !DescribeJobRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "databrew");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeJobRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/jobs/");
    try path_buf.appendSlice(alloc, input.name);
    try path_buf.appendSlice(alloc, "/jobRun/");
    try path_buf.appendSlice(alloc, input.run_id);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeJobRunOutput {
    var result: DescribeJobRunOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeJobRunOutput, body, alloc);
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
