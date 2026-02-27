const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EngineConfiguration = @import("engine_configuration.zig").EngineConfiguration;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const Tag = @import("tag.zig").Tag;
const SessionState = @import("session_state.zig").SessionState;

pub const StartSessionInput = struct {
    /// A unique case-sensitive string used to ensure the request to create the
    /// session is
    /// idempotent (executes only once). If another `StartSessionRequest` is
    /// received, the same response is returned and another session is not created.
    /// If a
    /// parameter has changed, an error is returned.
    ///
    /// This token is listed as not required because Amazon Web Services SDKs (for
    /// example
    /// the Amazon Web Services SDK for Java) auto-generate the token for users. If
    /// you are
    /// not using the Amazon Web Services SDK or the Amazon Web Services CLI, you
    /// must provide
    /// this token or the action will fail.
    client_request_token: ?[]const u8 = null,

    /// Copies the tags from the Workgroup to the Session when.
    copy_work_group_tags: ?bool = null,

    /// The session description.
    description: ?[]const u8 = null,

    /// Contains engine data processing unit (DPU) configuration settings and
    /// parameter
    /// mappings.
    engine_configuration: EngineConfiguration,

    /// The ARN of the execution role used to access user resources for Spark
    /// sessions and
    /// Identity Center enabled workgroups. This property applies only to Spark
    /// enabled
    /// workgroups and Identity Center enabled workgroups.
    execution_role: ?[]const u8 = null,

    /// Contains the configuration settings for managed log persistence, delivering
    /// logs to Amazon S3 buckets,
    /// Amazon CloudWatch log groups etc.
    monitoring_configuration: ?MonitoringConfiguration = null,

    /// The notebook version. This value is supplied automatically for notebook
    /// sessions in
    /// the Athena console and is not required for programmatic session access. The
    /// only valid notebook version is `Athena notebook version 1`. If
    /// you specify a value for `NotebookVersion`, you must also specify a value for
    /// `NotebookId`. See EngineConfiguration$AdditionalConfigs.
    notebook_version: ?[]const u8 = null,

    /// The idle timeout in minutes for the session.
    session_idle_timeout_in_minutes: ?i32 = null,

    /// A list of comma separated tags to add to the session that is created.
    tags: ?[]const Tag = null,

    /// The workgroup to which the session belongs.
    work_group: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .copy_work_group_tags = "CopyWorkGroupTags",
        .description = "Description",
        .engine_configuration = "EngineConfiguration",
        .execution_role = "ExecutionRole",
        .monitoring_configuration = "MonitoringConfiguration",
        .notebook_version = "NotebookVersion",
        .session_idle_timeout_in_minutes = "SessionIdleTimeoutInMinutes",
        .tags = "Tags",
        .work_group = "WorkGroup",
    };
};

pub const StartSessionOutput = struct {
    /// The session ID.
    session_id: ?[]const u8 = null,

    /// The state of the session. A description of each state follows.
    ///
    /// `CREATING` - The session is being started, including acquiring
    /// resources.
    ///
    /// `CREATED` - The session has been started.
    ///
    /// `IDLE` - The session is able to accept a calculation.
    ///
    /// `BUSY` - The session is processing another task and is unable to accept a
    /// calculation.
    ///
    /// `TERMINATING` - The session is in the process of shutting down.
    ///
    /// `TERMINATED` - The session and its resources are no longer running.
    ///
    /// `DEGRADED` - The session has no healthy coordinators.
    ///
    /// `FAILED` - Due to a failure, the session and its resources are no longer
    /// running.
    state: ?SessionState = null,

    pub const json_field_names = .{
        .session_id = "SessionId",
        .state = "State",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSessionInput, options: Options) !StartSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "athena");

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

fn serializeRequest(alloc: std.mem.Allocator, input: StartSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonAthena.StartSession");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartSessionOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "MetadataException")) {
        return .{ .arena = arena, .kind = .{ .metadata_exception = .{
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
    if (std.mem.eql(u8, error_code, "SessionAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .session_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
