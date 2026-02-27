const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScheduledActionInput, options: Options) !UpdateScheduledActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "redshiftserverless");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateScheduledActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshiftserverless", "Redshift Serverless", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "RedshiftServerless.UpdateScheduledAction");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateScheduledActionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateScheduledActionOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "DryRunException")) {
        return .{ .arena = arena, .kind = .{ .dry_run_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidPaginationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "Ipv6CidrBlockNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .ipv_6_cidr_block_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
