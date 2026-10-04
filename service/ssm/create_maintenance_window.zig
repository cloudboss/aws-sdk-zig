const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateMaintenanceWindowInput = struct {
    /// Enables a maintenance window task to run on managed nodes, even if you
    /// haven't registered
    /// those nodes as targets. If enabled, then you must specify the unregistered
    /// managed nodes (by node
    /// ID) when you register a task with the maintenance window.
    ///
    /// If you don't enable this option, then you must specify previously-registered
    /// targets when
    /// you register a task with the maintenance window.
    allow_unassociated_targets: ?bool = null,

    /// User-provided idempotency token.
    client_token: ?[]const u8 = null,

    /// The number of hours before the end of the maintenance window that Amazon Web
    /// Services Systems Manager stops scheduling
    /// new tasks for execution.
    cutoff: ?i32 = null,

    /// An optional description for the maintenance window. We recommend specifying
    /// a description to
    /// help you organize your maintenance windows.
    description: ?[]const u8 = null,

    /// The duration of the maintenance window in hours.
    duration: i32,

    /// The date and time, in ISO-8601 Extended format, for when you want the
    /// maintenance window to
    /// become inactive. `EndDate` allows you to set a date and time in the future
    /// when the
    /// maintenance window will no longer run.
    end_date: ?[]const u8 = null,

    /// The name of the maintenance window.
    name: []const u8,

    /// The schedule of the maintenance window in the form of a cron or rate
    /// expression.
    schedule: []const u8,

    /// The number of days to wait after the date and time specified by a cron
    /// expression before
    /// running the maintenance window.
    ///
    /// For example, the following cron expression schedules a maintenance window to
    /// run on the
    /// third Tuesday of every month at 11:30 PM.
    ///
    /// `cron(30 23 ? * TUE#3 *)`
    ///
    /// If the schedule offset is `2`, the maintenance window won't run until two
    /// days
    /// later.
    schedule_offset: ?i32 = null,

    /// The time zone that the scheduled maintenance window executions are based on,
    /// in Internet
    /// Assigned Numbers Authority (IANA) format. For example:
    /// "America/Los_Angeles", "UTC", or
    /// "Asia/Seoul". For more information, see the [Time
    /// Zone Database](https://www.iana.org/time-zones) on the IANA website.
    schedule_timezone: ?[]const u8 = null,

    /// The date and time, in ISO-8601 Extended format, for when you want the
    /// maintenance window to
    /// become active. `StartDate` allows you to delay activation of the maintenance
    /// window
    /// until the specified future date.
    ///
    /// When using a rate schedule, if you provide a start date that occurs in the
    /// past, the
    /// current date and time are used as the start date.
    start_date: ?[]const u8 = null,

    /// Optional metadata that you assign to a resource. Tags enable you to
    /// categorize a resource in
    /// different ways, such as by purpose, owner, or environment. For example, you
    /// might want to tag a
    /// maintenance window to identify the type of tasks it will run, the types of
    /// targets, and the
    /// environment it will run in. In this case, you could specify the following
    /// key-value pairs:
    ///
    /// * `Key=TaskType,Value=AgentUpdate`
    ///
    /// * `Key=OS,Value=Windows`
    ///
    /// * `Key=Environment,Value=Production`
    ///
    /// To add tags to an existing maintenance window, use the AddTagsToResource
    /// operation.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .allow_unassociated_targets = "AllowUnassociatedTargets",
        .client_token = "ClientToken",
        .cutoff = "Cutoff",
        .description = "Description",
        .duration = "Duration",
        .end_date = "EndDate",
        .name = "Name",
        .schedule = "Schedule",
        .schedule_offset = "ScheduleOffset",
        .schedule_timezone = "ScheduleTimezone",
        .start_date = "StartDate",
        .tags = "Tags",
    };
};

pub const CreateMaintenanceWindowOutput = struct {
    /// The ID of the created maintenance window.
    window_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .window_id = "WindowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMaintenanceWindowInput, options: CallOptions) !CreateMaintenanceWindowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMaintenanceWindowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.CreateMaintenanceWindow");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMaintenanceWindowOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMaintenanceWindowOutput, body, allocator);
}
