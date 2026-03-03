const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RuntimeEnvironment = @import("runtime_environment.zig").RuntimeEnvironment;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;
const ApplicationStatusReason = @import("application_status_reason.zig").ApplicationStatusReason;

pub const CreateApplicationInput = struct {
    /// An Amazon S3 URI to a bucket where you would like Amazon GameLift Streams to
    /// save application logs. Required if you specify one or more
    /// `ApplicationLogPaths`.
    ///
    /// The log bucket must have permissions that give Amazon GameLift Streams
    /// access to write the log files. For more information, see [Application log
    /// bucket permission
    /// policy](https://docs.aws.amazon.com/gameliftstreams/latest/developerguide/applications.html#application-bucket-permission-template) in the *Amazon GameLift Streams Developer Guide*.
    application_log_output_uri: ?[]const u8 = null,

    /// Locations of log files that your content generates during a stream session.
    /// Enter path values that are relative to the `ApplicationSourceUri` location.
    /// You can specify up to 10 log paths. Amazon GameLift Streams uploads
    /// designated log files to the Amazon S3 bucket that you specify in
    /// `ApplicationLogOutputUri` at the end of a stream session. To retrieve stored
    /// log files, call
    /// [GetStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamSession.html) and get the `LogFileLocationUri`.
    application_log_paths: ?[]const []const u8 = null,

    /// The location of the content that you want to stream. Enter an Amazon S3 URI
    /// to a bucket that contains your game or other application. The location can
    /// have a multi-level prefix structure, but it must include all the files
    /// needed to run the content. Amazon GameLift Streams copies everything under
    /// the specified location.
    ///
    /// This value is immutable. To designate a different content location, create a
    /// new application.
    ///
    /// The Amazon S3 bucket and the Amazon GameLift Streams application must be in
    /// the same Amazon Web Services Region.
    application_source_uri: []const u8,

    /// A unique identifier that represents a client request. The request is
    /// idempotent, which ensures that an API request completes only once. When
    /// users send a request, Amazon GameLift Streams automatically populates this
    /// field.
    client_token: ?[]const u8 = null,

    /// A human-readable label for the application. You can update this value later.
    description: []const u8,

    /// The relative path and file name of the executable file that Amazon GameLift
    /// Streams will stream. Specify a path relative to the location set in
    /// `ApplicationSourceUri`. The file must be contained within the application's
    /// root folder. For Windows applications, the file must be a valid Windows
    /// executable or batch file with a filename ending in .exe, .cmd, or .bat. For
    /// Linux applications, the file must be a valid Linux binary executable or a
    /// script that contains an initial interpreter line starting with a shebang
    /// ('`#!`').
    executable_path: []const u8,

    /// Configuration settings that identify the operating system for an application
    /// resource. This can also include a compatibility layer and other drivers.
    ///
    /// A runtime environment can be one of the following:
    ///
    /// * For Linux applications
    ///
    /// * Ubuntu 22.04 LTS (`Type=UBUNTU, Version=22_04_LTS`)
    ///
    /// * For Windows applications
    ///
    /// * Microsoft Windows Server 2022 Base (`Type=WINDOWS, Version=2022`)
    /// * Proton 9.0-2 (`Type=PROTON, Version=20250516`)
    /// * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    /// * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    runtime_environment: RuntimeEnvironment,

    /// A list of labels to assign to the new application resource. Tags are
    /// developer-defined key-value pairs. Tagging Amazon Web Services resources is
    /// useful for resource management, access management and cost allocation. See [
    /// Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference*. You can use
    /// [TagResource](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_TagResource.html) to add tags, [UntagResource](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_UntagResource.html) to remove tags, and [ListTagsForResource](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_ListTagsForResource.html) to view tags on existing resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .application_log_output_uri = "ApplicationLogOutputUri",
        .application_log_paths = "ApplicationLogPaths",
        .application_source_uri = "ApplicationSourceUri",
        .client_token = "ClientToken",
        .description = "Description",
        .executable_path = "ExecutablePath",
        .runtime_environment = "RuntimeEnvironment",
        .tags = "Tags",
    };
};

pub const CreateApplicationOutput = struct {
    /// An Amazon S3 URI to a bucket where you would like Amazon GameLift Streams to
    /// save application logs. Required if you specify one or more
    /// `ApplicationLogPaths`.
    application_log_output_uri: ?[]const u8 = null,

    /// Locations of log files that your content generates during a stream session.
    /// Amazon GameLift Streams uploads log files to the Amazon S3 bucket that you
    /// specify in `ApplicationLogOutputUri` at the end of a stream session. To
    /// retrieve stored log files, call
    /// [GetStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamSession.html) and get the `LogFileLocationUri`.
    application_log_paths: ?[]const []const u8 = null,

    /// The original Amazon S3 location of uploaded stream content for the
    /// application.
    application_source_uri: ?[]const u8 = null,

    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that's assigned to an application resource and uniquely identifies it across
    /// all Amazon Web Services Regions. Format is `arn:aws:gameliftstreams:[AWS
    /// Region]:[AWS account]:application/[resource ID]`.
    arn: []const u8,

    /// A newly created application is not associated to any stream groups. This
    /// value is empty.
    associated_stream_groups: ?[]const []const u8 = null,

    /// A timestamp that indicates when this resource was created. Timestamps are
    /// expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    created_at: ?i64 = null,

    /// A human-readable label for the application. You can edit this value.
    description: ?[]const u8 = null,

    /// The relative path and file name of the executable file that launches the
    /// content for streaming.
    executable_path: ?[]const u8 = null,

    /// A unique ID value that is assigned to the resource when it's created. Format
    /// example: `a-9ZY8X7Wv6`.
    id: ?[]const u8 = null,

    /// A timestamp that indicates when this resource was last updated. Timestamps
    /// are expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    last_updated_at: ?i64 = null,

    /// A set of replication statuses for each location.
    replication_statuses: ?[]const ReplicationStatus = null,

    /// Configuration settings that identify the operating system for an application
    /// resource. This can also include a compatibility layer and other drivers.
    ///
    /// A runtime environment can be one of the following:
    ///
    /// * For Linux applications
    ///
    /// * Ubuntu 22.04 LTS (`Type=UBUNTU, Version=22_04_LTS`)
    ///
    /// * For Windows applications
    ///
    /// * Microsoft Windows Server 2022 Base (`Type=WINDOWS, Version=2022`)
    /// * Proton 9.0-2 (`Type=PROTON, Version=20250516`)
    /// * Proton 8.0-5 (`Type=PROTON, Version=20241007`)
    /// * Proton 8.0-2c (`Type=PROTON, Version=20230704`)
    runtime_environment: ?RuntimeEnvironment = null,

    /// The current status of the application resource. Possible statuses include
    /// the following:
    ///
    /// * `INITIALIZED`: Amazon GameLift Streams has received the request and is
    ///   initiating the work flow to create an application.
    /// * `PROCESSING`: The create application work flow is in process. Amazon
    ///   GameLift Streams is copying the content and caching for future deployment
    ///   in a stream group.
    /// * `READY`: The application is ready to deploy in a stream group.
    /// * `ERROR`: An error occurred when setting up the application. See
    ///   `StatusReason` for more information.
    /// * `DELETING`: Amazon GameLift Streams is in the process of deleting the
    ///   application.
    status: ?ApplicationStatus = null,

    /// A short description of the status reason when the application is in `ERROR`
    /// status.
    status_reason: ?ApplicationStatusReason = null,

    pub const json_field_names = .{
        .application_log_output_uri = "ApplicationLogOutputUri",
        .application_log_paths = "ApplicationLogPaths",
        .application_source_uri = "ApplicationSourceUri",
        .arn = "Arn",
        .associated_stream_groups = "AssociatedStreamGroups",
        .created_at = "CreatedAt",
        .description = "Description",
        .executable_path = "ExecutablePath",
        .id = "Id",
        .last_updated_at = "LastUpdatedAt",
        .replication_statuses = "ReplicationStatuses",
        .runtime_environment = "RuntimeEnvironment",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: Options) !CreateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "gameliftstreams");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/applications";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.application_log_output_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ApplicationLogOutputUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.application_log_paths) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ApplicationLogPaths\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ApplicationSourceUri\":");
    try aws.json.writeValue(@TypeOf(input.application_source_uri), input.application_source_uri, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExecutablePath\":");
    try aws.json.writeValue(@TypeOf(input.executable_path), input.executable_path, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RuntimeEnvironment\":");
    try aws.json.writeValue(@TypeOf(input.runtime_environment), input.runtime_environment, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    var result: CreateApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
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
