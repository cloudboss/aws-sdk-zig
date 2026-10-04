const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetMaintenanceWindowInput = struct {
    /// The ID of the maintenance window for which you want to retrieve information.
    window_id: []const u8,

    pub const json_field_names = .{
        .window_id = "WindowId",
    };
};

pub const GetMaintenanceWindowOutput = struct {
    /// Whether targets must be registered with the maintenance window before tasks
    /// can be defined
    /// for those targets.
    allow_unassociated_targets: ?bool = null,

    /// The date the maintenance window was created.
    created_date: ?i64 = null,

    /// The number of hours before the end of the maintenance window that Amazon Web
    /// Services Systems Manager stops scheduling
    /// new tasks for execution.
    cutoff: ?i32 = null,

    /// The description of the maintenance window.
    description: ?[]const u8 = null,

    /// The duration of the maintenance window in hours.
    duration: ?i32 = null,

    /// Indicates whether the maintenance window is enabled.
    enabled: ?bool = null,

    /// The date and time, in ISO-8601 Extended format, for when the maintenance
    /// window is scheduled
    /// to become inactive. The maintenance window won't run after this specified
    /// time.
    end_date: ?[]const u8 = null,

    /// The date the maintenance window was last modified.
    modified_date: ?i64 = null,

    /// The name of the maintenance window.
    name: ?[]const u8 = null,

    /// The next time the maintenance window will actually run, taking into account
    /// any specified
    /// times for the maintenance window to become active or inactive.
    next_execution_time: ?[]const u8 = null,

    /// The schedule of the maintenance window in the form of a cron or rate
    /// expression.
    schedule: ?[]const u8 = null,

    /// The number of days to wait to run a maintenance window after the scheduled
    /// cron expression
    /// date and time.
    schedule_offset: ?i32 = null,

    /// The time zone that the scheduled maintenance window executions are based on,
    /// in Internet
    /// Assigned Numbers Authority (IANA) format. For example:
    /// "America/Los_Angeles", "UTC", or
    /// "Asia/Seoul". For more information, see the [Time
    /// Zone Database](https://www.iana.org/time-zones) on the IANA website.
    schedule_timezone: ?[]const u8 = null,

    /// The date and time, in ISO-8601 Extended format, for when the maintenance
    /// window is scheduled
    /// to become active. The maintenance window won't run before this specified
    /// time.
    start_date: ?[]const u8 = null,

    /// The ID of the created maintenance window.
    window_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .allow_unassociated_targets = "AllowUnassociatedTargets",
        .created_date = "CreatedDate",
        .cutoff = "Cutoff",
        .description = "Description",
        .duration = "Duration",
        .enabled = "Enabled",
        .end_date = "EndDate",
        .modified_date = "ModifiedDate",
        .name = "Name",
        .next_execution_time = "NextExecutionTime",
        .schedule = "Schedule",
        .schedule_offset = "ScheduleOffset",
        .schedule_timezone = "ScheduleTimezone",
        .start_date = "StartDate",
        .window_id = "WindowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMaintenanceWindowInput, options: CallOptions) !GetMaintenanceWindowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMaintenanceWindowInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetMaintenanceWindow");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMaintenanceWindowOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMaintenanceWindowOutput, body, allocator);
}
