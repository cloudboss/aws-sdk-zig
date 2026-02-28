const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DatabaseOutput = @import("database_output.zig").DatabaseOutput;
const DataCatalogOutput = @import("data_catalog_output.zig").DataCatalogOutput;
const EncryptionMode = @import("encryption_mode.zig").EncryptionMode;
const LogSubscription = @import("log_subscription.zig").LogSubscription;
const Output = @import("output.zig").Output;

pub const UpdateRecipeJobInput = struct {
    /// Represents a list of JDBC database output objects which defines the output
    /// destination for a
    /// DataBrew recipe job to write into.
    database_outputs: ?[]const DatabaseOutput = null,

    /// One or more artifacts that represent the Glue Data Catalog output from
    /// running the job.
    data_catalog_outputs: ?[]const DataCatalogOutput = null,

    /// The Amazon Resource Name (ARN) of an encryption key that is used to protect
    /// the
    /// job.
    encryption_key_arn: ?[]const u8 = null,

    /// The encryption mode for the job, which can be one of the following:
    ///
    /// * `SSE-KMS` - Server-side encryption with keys managed by KMS.
    ///
    /// * `SSE-S3` - Server-side encryption with keys managed by Amazon S3.
    encryption_mode: ?EncryptionMode = null,

    /// Enables or disables Amazon CloudWatch logging for the job. If logging is
    /// enabled,
    /// CloudWatch writes one log stream for each job run.
    log_subscription: ?LogSubscription = null,

    /// The maximum number of nodes that DataBrew can consume when the job processes
    /// data.
    max_capacity: ?i32 = null,

    /// The maximum number of times to retry the job after a job run fails.
    max_retries: ?i32 = null,

    /// The name of the job to update.
    name: []const u8,

    /// One or more artifacts that represent the output from running the job.
    outputs: ?[]const Output = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role to
    /// be assumed when DataBrew runs the job.
    role_arn: []const u8,

    /// The job's timeout in minutes. A job that attempts to run longer than this
    /// timeout
    /// period ends with a status of `TIMEOUT`.
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .database_outputs = "DatabaseOutputs",
        .data_catalog_outputs = "DataCatalogOutputs",
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_mode = "EncryptionMode",
        .log_subscription = "LogSubscription",
        .max_capacity = "MaxCapacity",
        .max_retries = "MaxRetries",
        .name = "Name",
        .outputs = "Outputs",
        .role_arn = "RoleArn",
        .timeout = "Timeout",
    };
};

pub const UpdateRecipeJobOutput = struct {
    /// The name of the job that you updated.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRecipeJobInput, options: Options) !UpdateRecipeJobOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateRecipeJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/recipeJobs/");
    try path_buf.appendSlice(alloc, input.name);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.database_outputs) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DatabaseOutputs\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.data_catalog_outputs) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DataCatalogOutputs\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EncryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.encryption_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EncryptionMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.log_subscription) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LogSubscription\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaxCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_retries) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaxRetries\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.outputs) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Outputs\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, alloc, &body_buf);
    has_prev = true;
    if (input.timeout) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Timeout\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateRecipeJobOutput {
    var result: UpdateRecipeJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateRecipeJobOutput, body, alloc);
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
