const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ComparisonOperatorType = @import("comparison_operator_type.zig").ComparisonOperatorType;
const MetricName = @import("metric_name.zig").MetricName;
const PolicyType = @import("policy_type.zig").PolicyType;
const ScalingAdjustmentType = @import("scaling_adjustment_type.zig").ScalingAdjustmentType;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;

pub const PutScalingPolicyInput = struct {
    /// Comparison operator to use when measuring the metric against the threshold
    /// value.
    comparison_operator: ?ComparisonOperatorType = null,

    /// Length of time (in minutes) the metric must be at or beyond the threshold
    /// before a
    /// scaling event is triggered.
    evaluation_periods: ?i32 = null,

    /// A unique identifier for the fleet to apply this policy to. You can use
    /// either the fleet ID or ARN value. The fleet
    /// cannot be in any of the following statuses: ERROR or DELETING.
    fleet_id: []const u8,

    /// Name of the Amazon GameLift Servers-defined metric that is used to trigger a
    /// scaling adjustment. For
    /// detailed descriptions of fleet metrics, see [Monitor Amazon GameLift Servers
    /// with Amazon
    /// CloudWatch](https://docs.aws.amazon.com/gamelift/latest/developerguide/monitoring-cloudwatch.html).
    ///
    /// * **ActivatingGameSessions** -- Game sessions in
    /// the process of being created.
    ///
    /// * **ActiveGameSessions** -- Game sessions that
    /// are currently running.
    ///
    /// * **ActiveInstances** -- Fleet instances that
    /// are currently running at least one game session.
    ///
    /// * **AvailableGameSessions** -- Additional game
    /// sessions that fleet could host simultaneously, given current capacity.
    ///
    /// * **AvailablePlayerSessions** -- Empty player
    /// slots in currently active game sessions. This includes game sessions that
    /// are
    /// not currently accepting players. Reserved player slots are not
    /// included.
    ///
    /// * **CurrentPlayerSessions** -- Player slots in
    /// active game sessions that are being used by a player or are reserved for a
    /// player.
    ///
    /// * **IdleInstances** -- Active instances that are
    /// currently hosting zero game sessions.
    ///
    /// * **PercentAvailableGameSessions** -- Unused
    /// percentage of the total number of game sessions that a fleet could host
    /// simultaneously, given current capacity. Use this metric for a target-based
    /// scaling policy.
    ///
    /// * **PercentIdleInstances** -- Percentage of the
    /// total number of active instances that are hosting zero game sessions.
    ///
    /// * **QueueDepth** -- Pending game session
    /// placement requests, in any queue, where the current fleet is the
    /// top-priority
    /// destination.
    ///
    /// * **WaitTime** -- Current wait time for pending
    /// game session placement requests, in any queue, where the current fleet is
    /// the
    /// top-priority destination.
    metric_name: MetricName,

    /// A descriptive label that is associated with a fleet's scaling policy. Policy
    /// names do not need to be unique. A fleet can have only one scaling policy
    /// with the same name.
    name: []const u8,

    /// The type of scaling policy to create. For a target-based policy, set the
    /// parameter
    /// *MetricName* to 'PercentAvailableGameSessions' and specify a
    /// *TargetConfiguration*. For a rule-based policy set the following
    /// parameters: *MetricName*, *ComparisonOperator*,
    /// *Threshold*, *EvaluationPeriods*,
    /// *ScalingAdjustmentType*, and
    /// *ScalingAdjustment*.
    policy_type: ?PolicyType = null,

    /// Amount of adjustment to make, based on the scaling adjustment type.
    scaling_adjustment: ?i32 = null,

    /// The type of adjustment to make to a fleet's instance count:
    ///
    /// * **ChangeInCapacity** -- add (or subtract) the
    /// scaling adjustment value from the current instance count. Positive values
    /// scale
    /// up while negative values scale down.
    ///
    /// * **ExactCapacity** -- set the instance count to the
    /// scaling adjustment value.
    ///
    /// * **PercentChangeInCapacity** -- increase or reduce
    /// the current instance count by the scaling adjustment, read as a percentage.
    /// Positive values scale up while negative values scale down; for example, a
    /// value
    /// of "-10" scales the fleet down by 10%.
    scaling_adjustment_type: ?ScalingAdjustmentType = null,

    /// An object that contains settings for a target-based scaling policy.
    target_configuration: ?TargetConfiguration = null,

    /// Metric value used to trigger a scaling event.
    threshold: ?f64 = null,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .evaluation_periods = "EvaluationPeriods",
        .fleet_id = "FleetId",
        .metric_name = "MetricName",
        .name = "Name",
        .policy_type = "PolicyType",
        .scaling_adjustment = "ScalingAdjustment",
        .scaling_adjustment_type = "ScalingAdjustmentType",
        .target_configuration = "TargetConfiguration",
        .threshold = "Threshold",
    };
};

pub const PutScalingPolicyOutput = struct {
    /// A descriptive label that is associated with a fleet's scaling policy. Policy
    /// names do not need to be unique.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutScalingPolicyInput, options: CallOptions) !PutScalingPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "gamelift");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutScalingPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.PutScalingPolicy");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutScalingPolicyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutScalingPolicyOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FleetCapacityExceededException")) {
        return .{ .arena = arena, .kind = .{ .fleet_capacity_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GameSessionFullException")) {
        return .{ .arena = arena, .kind = .{ .game_session_full_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFleetStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_fleet_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGameSessionStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_game_session_status_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotReadyException")) {
        return .{ .arena = arena, .kind = .{ .not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OutOfCapacityException")) {
        return .{ .arena = arena, .kind = .{ .out_of_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaggingFailedException")) {
        return .{ .arena = arena, .kind = .{ .tagging_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TerminalRoutingStrategyException")) {
        return .{ .arena = arena, .kind = .{ .terminal_routing_strategy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedRegionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_region_exception = .{
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
