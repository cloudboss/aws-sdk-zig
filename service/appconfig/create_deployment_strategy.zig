const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GrowthType = @import("growth_type.zig").GrowthType;
const ReplicateTo = @import("replicate_to.zig").ReplicateTo;

pub const CreateDeploymentStrategyInput = struct {
    /// Total amount of time for a deployment to last.
    deployment_duration_in_minutes: ?i32 = null,

    /// A description of the deployment strategy.
    description: ?[]const u8 = null,

    /// Specifies the amount of time AppConfig monitors for Amazon CloudWatch alarms
    /// after the
    /// configuration has been deployed to 100% of its targets, before considering
    /// the deployment
    /// to be complete. If an alarm is triggered during this time, AppConfig rolls
    /// back
    /// the deployment. You must configure permissions for AppConfig to roll back
    /// based
    /// on CloudWatch alarms. For more information, see [Configuring permissions for
    /// rollback based on Amazon CloudWatch
    /// alarms](https://docs.aws.amazon.com/appconfig/latest/userguide/getting-started-with-appconfig-cloudwatch-alarms-permissions.html) in the
    /// *AppConfig User Guide*.
    final_bake_time_in_minutes: ?i32 = null,

    /// The percentage of targets to receive a deployed configuration during each
    /// interval.
    growth_factor: f32,

    /// The algorithm used to define how percentage grows over time. AppConfig
    /// supports the following growth types:
    ///
    /// **Linear**: For this type, AppConfig processes
    /// the deployment by dividing the total number of targets by the value
    /// specified for
    /// `Step percentage`. For example, a linear deployment that uses a `Step
    /// percentage` of 10 deploys the configuration to 10 percent of the hosts.
    /// After
    /// those deployments are complete, the system deploys the configuration to the
    /// next 10
    /// percent. This continues until 100% of the targets have successfully received
    /// the
    /// configuration.
    ///
    /// **Exponential**: For this type, AppConfig
    /// processes the deployment exponentially using the following formula:
    /// `G*(2^N)`.
    /// In this formula, `G` is the growth factor specified by the user and
    /// `N` is the number of steps until the configuration is deployed to all
    /// targets. For example, if you specify a growth factor of 2, then the system
    /// rolls out the
    /// configuration as follows:
    ///
    /// `2*(2^0)`
    ///
    /// `2*(2^1)`
    ///
    /// `2*(2^2)`
    ///
    /// Expressed numerically, the deployment rolls out as follows: 2% of the
    /// targets, 4% of the
    /// targets, 8% of the targets, and continues until the configuration has been
    /// deployed to all
    /// targets.
    growth_type: ?GrowthType = null,

    /// A name for the deployment strategy.
    name: []const u8,

    /// Save the deployment strategy to a Systems Manager (SSM) document.
    replicate_to: ?ReplicateTo = null,

    /// Metadata to assign to the deployment strategy. Tags help organize and
    /// categorize your
    /// AppConfig resources. Each tag consists of a key and an optional value, both
    /// of
    /// which you define.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .deployment_duration_in_minutes = "DeploymentDurationInMinutes",
        .description = "Description",
        .final_bake_time_in_minutes = "FinalBakeTimeInMinutes",
        .growth_factor = "GrowthFactor",
        .growth_type = "GrowthType",
        .name = "Name",
        .replicate_to = "ReplicateTo",
        .tags = "Tags",
    };
};

pub const CreateDeploymentStrategyOutput = @import("deployment_strategy.zig").DeploymentStrategy;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentStrategyInput, options: CallOptions) !CreateDeploymentStrategyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appconfig");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentStrategyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/deploymentstrategies";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DeploymentDurationInMinutes\":");
    try aws.json.writeValue(@TypeOf(input.deployment_duration_in_minutes), input.deployment_duration_in_minutes, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.final_bake_time_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FinalBakeTimeInMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GrowthFactor\":");
    try aws.json.writeValue(@TypeOf(input.growth_factor), input.growth_factor, allocator, &body_buf);
    has_prev = true;
    if (input.growth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GrowthType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.replicate_to) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ReplicateTo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentStrategyOutput {
    var result: CreateDeploymentStrategyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDeploymentStrategyOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "PayloadTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .payload_too_large_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
