const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GrowthType = @import("growth_type.zig").GrowthType;
const ReplicateTo = @import("replicate_to.zig").ReplicateTo;

pub const UpdateDeploymentStrategyInput = struct {
    /// Total amount of time for a deployment to last.
    deployment_duration_in_minutes: ?i32 = null,

    /// The deployment strategy ID.
    deployment_strategy_id: []const u8,

    /// A description of the deployment strategy.
    description: ?[]const u8 = null,

    /// The amount of time that AppConfig monitors for alarms before considering the
    /// deployment to be complete and no longer eligible for automatic rollback.
    final_bake_time_in_minutes: ?i32 = null,

    /// The percentage of targets to receive a deployed configuration during each
    /// interval.
    growth_factor: ?f32 = null,

    /// The algorithm used to define how percentage grows over time. AppConfig
    /// supports the following growth types:
    ///
    /// **Linear**: For this type, AppConfig processes
    /// the deployment by increments of the growth factor evenly distributed over
    /// the deployment
    /// time. For example, a linear deployment that uses a growth factor of 20
    /// initially makes the
    /// configuration available to 20 percent of the targets. After 1/5th of the
    /// deployment time
    /// has passed, the system updates the percentage to 40 percent. This continues
    /// until 100% of
    /// the targets are set to receive the deployed configuration.
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

    pub const json_field_names = .{
        .deployment_duration_in_minutes = "DeploymentDurationInMinutes",
        .deployment_strategy_id = "DeploymentStrategyId",
        .description = "Description",
        .final_bake_time_in_minutes = "FinalBakeTimeInMinutes",
        .growth_factor = "GrowthFactor",
        .growth_type = "GrowthType",
    };
};

pub const UpdateDeploymentStrategyOutput = @import("deployment_strategy.zig").DeploymentStrategy;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDeploymentStrategyInput, options: CallOptions) !UpdateDeploymentStrategyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDeploymentStrategyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/deploymentstrategies/");
    try path_buf.appendSlice(allocator, input.deployment_strategy_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.deployment_duration_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeploymentDurationInMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.growth_factor) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GrowthFactor\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.growth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GrowthType\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDeploymentStrategyOutput {
    var result: UpdateDeploymentStrategyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDeploymentStrategyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
