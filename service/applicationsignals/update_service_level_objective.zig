const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BurnRateConfiguration = @import("burn_rate_configuration.zig").BurnRateConfiguration;
const Goal = @import("goal.zig").Goal;
const RequestBasedServiceLevelIndicatorConfig = @import("request_based_service_level_indicator_config.zig").RequestBasedServiceLevelIndicatorConfig;
const ServiceLevelIndicatorConfig = @import("service_level_indicator_config.zig").ServiceLevelIndicatorConfig;
const ServiceLevelObjective = @import("service_level_objective.zig").ServiceLevelObjective;

pub const UpdateServiceLevelObjectiveInput = struct {
    /// Indicates whether DevOps Agent will automatically investigate this SLO when
    /// it is breached
    auto_investigation_enabled: ?bool = null,

    /// Use this array to create *burn rates* for this SLO. Each burn rate is a
    /// metric that indicates how fast the service is consuming the error budget,
    /// relative to the attainment goal of the SLO.
    burn_rate_configurations: ?[]const BurnRateConfiguration = null,

    /// An optional description for the SLO.
    description: ?[]const u8 = null,

    /// A structure that contains the attributes that determine the goal of the SLO.
    /// This includes the time period for evaluation and the attainment threshold.
    goal: ?Goal = null,

    /// The Amazon Resource Name (ARN) or name of the service level objective that
    /// you want to update.
    id: []const u8,

    /// If this SLO is a request-based SLO, this structure defines the information
    /// about what performance metric this SLO will monitor.
    ///
    /// You can't specify both `SliConfig` and `RequestBasedSliConfig` in the same
    /// operation.
    request_based_sli_config: ?RequestBasedServiceLevelIndicatorConfig = null,

    /// If this SLO is a period-based SLO, this structure defines the information
    /// about what performance metric this SLO will monitor.
    sli_config: ?ServiceLevelIndicatorConfig = null,

    pub const json_field_names = .{
        .auto_investigation_enabled = "AutoInvestigationEnabled",
        .burn_rate_configurations = "BurnRateConfigurations",
        .description = "Description",
        .goal = "Goal",
        .id = "Id",
        .request_based_sli_config = "RequestBasedSliConfig",
        .sli_config = "SliConfig",
    };
};

pub const UpdateServiceLevelObjectiveOutput = struct {
    /// A structure that contains information about the SLO that you just updated.
    slo: ?ServiceLevelObjective = null,

    pub const json_field_names = .{
        .slo = "Slo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceLevelObjectiveInput, options: CallOptions) !UpdateServiceLevelObjectiveOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-signals", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceLevelObjectiveInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/slo/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_investigation_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoInvestigationEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.burn_rate_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BurnRateConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.goal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Goal\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_based_sli_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequestBasedSliConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sli_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SliConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceLevelObjectiveOutput {
    const result: UpdateServiceLevelObjectiveOutput = try aws.json.parseJsonObject(
        UpdateServiceLevelObjectiveOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
