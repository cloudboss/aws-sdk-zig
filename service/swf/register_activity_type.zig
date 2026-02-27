const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TaskList = @import("task_list.zig").TaskList;

pub const RegisterActivityTypeInput = struct {
    /// If set, specifies the default maximum time before which a worker processing
    /// a task of
    /// this type must report progress by calling RecordActivityTaskHeartbeat. If
    /// the timeout is exceeded, the activity task is automatically timed out. This
    /// default can be
    /// overridden when scheduling an activity task using the `ScheduleActivityTask`
    /// Decision. If the activity worker subsequently attempts to record a heartbeat
    /// or returns a result, the activity worker receives an `UnknownResource`
    /// fault. In
    /// this case, Amazon SWF no longer considers the activity task to be valid; the
    /// activity worker should
    /// clean up the activity task.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_heartbeat_timeout: ?[]const u8 = null,

    /// If set, specifies the default task list to use for scheduling tasks of this
    /// activity
    /// type. This default task list is used if a task list isn't provided when a
    /// task is scheduled
    /// through the `ScheduleActivityTask`
    /// Decision.
    default_task_list: ?TaskList = null,

    /// The default task priority to assign to the activity type. If not assigned,
    /// then
    /// `0` is used. Valid values are integers that range from Java's
    /// `Integer.MIN_VALUE` (-2147483648) to `Integer.MAX_VALUE` (2147483647).
    /// Higher numbers indicate higher priority.
    ///
    /// For more information about setting task priority, see [Setting Task
    /// Priority](https://docs.aws.amazon.com/amazonswf/latest/developerguide/programming-priority.html) in the *in the
    /// Amazon SWF Developer Guide*..
    default_task_priority: ?[]const u8 = null,

    /// If set, specifies the default maximum duration for a task of this activity
    /// type. This
    /// default can be overridden when scheduling an activity task using the
    /// `ScheduleActivityTask`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_schedule_to_close_timeout: ?[]const u8 = null,

    /// If set, specifies the default maximum duration that a task of this activity
    /// type can
    /// wait before being assigned to a worker. This default can be overridden when
    /// scheduling an
    /// activity task using the `ScheduleActivityTask`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_schedule_to_start_timeout: ?[]const u8 = null,

    /// If set, specifies the default maximum duration that a worker can take to
    /// process tasks
    /// of this activity type. This default can be overridden when scheduling an
    /// activity task using
    /// the `ScheduleActivityTask`
    /// Decision.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`. You can use `NONE` to specify unlimited duration.
    default_task_start_to_close_timeout: ?[]const u8 = null,

    /// A textual description of the activity type.
    description: ?[]const u8 = null,

    /// The name of the domain in which this activity is to be registered.
    domain: []const u8,

    /// The name of the activity type within the domain.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    name: []const u8,

    /// The version of the activity type.
    ///
    /// The activity type consists of the name and version, the combination of which
    /// must be
    /// unique within the domain.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    version: []const u8,

    pub const json_field_names = .{
        .default_task_heartbeat_timeout = "defaultTaskHeartbeatTimeout",
        .default_task_list = "defaultTaskList",
        .default_task_priority = "defaultTaskPriority",
        .default_task_schedule_to_close_timeout = "defaultTaskScheduleToCloseTimeout",
        .default_task_schedule_to_start_timeout = "defaultTaskScheduleToStartTimeout",
        .default_task_start_to_close_timeout = "defaultTaskStartToCloseTimeout",
        .description = "description",
        .domain = "domain",
        .name = "name",
        .version = "version",
    };
};

const RegisterActivityTypeOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterActivityTypeInput, options: Options) !RegisterActivityTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "swf");

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

fn serializeRequest(alloc: std.mem.Allocator, input: RegisterActivityTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "SimpleWorkflowService.RegisterActivityType");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RegisterActivityTypeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
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

    if (std.mem.eql(u8, error_code, "DefaultUndefinedFault")) {
        return .{ .arena = arena, .kind = .{ .default_undefined_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .domain_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .domain_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedFault")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsFault")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .type_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .type_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TypeNotDeprecatedFault")) {
        return .{ .arena = arena, .kind = .{ .type_not_deprecated_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnknownResourceFault")) {
        return .{ .arena = arena, .kind = .{ .unknown_resource_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "WorkflowExecutionAlreadyStartedFault")) {
        return .{ .arena = arena, .kind = .{ .workflow_execution_already_started_fault = .{
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
