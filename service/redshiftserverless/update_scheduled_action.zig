const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Schedule = @import("schedule.zig").Schedule;
const TargetAction = @import("target_action.zig").TargetAction;
const ScheduledActionResponse = @import("scheduled_action_response.zig").ScheduledActionResponse;

pub const UpdateScheduledActionInput = struct {
    /// Specifies whether to enable the scheduled action.
    enabled: ?bool = null,

    /// The end time in UTC of the scheduled action to update.
    end_time: ?i64 = null,

    /// The ARN of the IAM role to assume to run the scheduled action. This IAM role
    /// must have permission to run the Amazon Redshift Serverless API operation in
    /// the scheduled action. This IAM role must allow the Amazon Redshift scheduler
    /// to schedule creating snapshots (Principal scheduler.redshift.amazonaws.com)
    /// to assume permissions on your behalf. For more information about the IAM
    /// role to use with the Amazon Redshift scheduler, see [Using Identity-Based
    /// Policies for Amazon
    /// Redshift](https://docs.aws.amazon.com/redshift/latest/mgmt/redshift-iam-access-control-identity-based.html) in the Amazon Redshift Management Guide
    role_arn: ?[]const u8 = null,

    /// The schedule for a one-time (at timestamp format) or recurring (cron format)
    /// scheduled action. Schedule invocations must be separated by at least one
    /// hour. Times are in UTC.
    ///
    /// * Format of at timestamp is `yyyy-mm-ddThh:mm:ss`. For example,
    ///   `2016-03-04T17:27:00`.
    /// * Format of cron expression is `(Minutes Hours Day-of-month Month
    ///   Day-of-week Year)`. For example, `"(0 10 ? * MON *)"`. For more
    ///   information, see [Cron
    ///   Expressions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions) in the *Amazon CloudWatch Events User Guide*.
    schedule: ?Schedule = null,

    /// The descripion of the scheduled action to update to.
    scheduled_action_description: ?[]const u8 = null,

    /// The name of the scheduled action to update to.
    scheduled_action_name: []const u8,

    /// The start time in UTC of the scheduled action to update to.
    start_time: ?i64 = null,

    target_action: ?TargetAction = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .end_time = "endTime",
        .role_arn = "roleArn",
        .schedule = "schedule",
        .scheduled_action_description = "scheduledActionDescription",
        .scheduled_action_name = "scheduledActionName",
        .start_time = "startTime",
        .target_action = "targetAction",
    };
};

pub const UpdateScheduledActionOutput = struct {
    /// The ScheduledAction object that was updated.
    scheduled_action: ?ScheduledActionResponse = null,

    pub const json_field_names = .{
        .scheduled_action = "scheduledAction",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScheduledActionInput, options: CallOptions) !UpdateScheduledActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScheduledActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.UpdateScheduledAction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScheduledActionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateScheduledActionOutput, body, allocator);
}
