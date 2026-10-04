const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;
const RuntimeEnvironment = @import("runtime_environment.zig").RuntimeEnvironment;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;
const ApplicationStatusReason = @import("application_status_reason.zig").ApplicationStatusReason;

pub const UpdateApplicationInput = struct {
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
    /// Enter path values that are relative to the `ApplicationSourceUri` location,
    /// or relative to the user's home directory when using a supported path
    /// variable. You can specify up to 10 log paths. Each individual log file
    /// cannot exceed 50 MB in size.
    ///
    /// Each path can be a directory or an exact file path. When you specify a
    /// directory, Amazon GameLift Streams collects only files with the following
    /// extensions: `.txt`, `.log`, and `.utrace`. To collect files with other
    /// extensions, specify the exact file path. The copy operation is not performed
    /// recursively in subfolders.
    ///
    /// The following path variables are recognized when they appear as the first
    /// component of a path: `%USERPROFILE%` (Windows and Proton), `$HOME` or `~`
    /// (Linux). Use a path variable when your application writes logs outside of
    /// the application directory.
    ///
    /// Amazon GameLift Streams uploads designated log files to the Amazon S3 bucket
    /// that you specify in `ApplicationLogOutputUri` at the end of a stream
    /// session. To retrieve stored log files, call
    /// [GetStreamSession](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamSession.html) and get the `LogFileLocationUri`.
    application_log_paths: ?[]const []const u8 = null,

    /// A human-readable label for the application.
    description: ?[]const u8 = null,

    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    /// Example ID: `a-9ZY8X7Wv6`.
    identifier: []const u8,

    pub const json_field_names = .{
        .application_log_output_uri = "ApplicationLogOutputUri",
        .application_log_paths = "ApplicationLogPaths",
        .description = "Description",
        .identifier = "Identifier",
    };
};

pub const UpdateApplicationOutput = struct {
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

    /// A set of stream groups that this application is associated with. You can use
    /// any of these stream groups to stream your application.
    ///
    /// This value is a set of [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html) that uniquely identify stream group resources. Example ARN: `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
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
    /// * Proton 10.0-4 (`Type=PROTON, Version=20260204`)
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationInput, options: CallOptions) !UpdateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gameliftstreams", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationOutput {
    const result: UpdateApplicationOutput = try aws.json.parseJsonObject(
        UpdateApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
