const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub const RegisterActivityTypeOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterActivityTypeInput, options: CallOptions) !RegisterActivityTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterActivityTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.RegisterActivityType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterActivityTypeOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
