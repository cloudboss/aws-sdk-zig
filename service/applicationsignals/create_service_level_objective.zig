const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BurnRateConfiguration = @import("burn_rate_configuration.zig").BurnRateConfiguration;
const Goal = @import("goal.zig").Goal;
const RequestBasedServiceLevelIndicatorConfig = @import("request_based_service_level_indicator_config.zig").RequestBasedServiceLevelIndicatorConfig;
const ServiceLevelIndicatorConfig = @import("service_level_indicator_config.zig").ServiceLevelIndicatorConfig;
const Tag = @import("tag.zig").Tag;
const ServiceLevelObjective = @import("service_level_objective.zig").ServiceLevelObjective;

pub const CreateServiceLevelObjectiveInput = struct {
    /// Indicates whether DevOps Agent will automatically investigate this SLO when
    /// it is breached
    auto_investigation_enabled: ?bool = null,

    /// Use this array to create *burn rates* for this SLO. Each burn rate is a
    /// metric that indicates how fast the service is consuming the error budget,
    /// relative to the attainment goal of the SLO.
    burn_rate_configurations: ?[]const BurnRateConfiguration = null,

    /// Set this to `true` to create a recommended SLO out of the box. When set to
    /// `true`, you don't need to specify the `MetricThreshold` or
    /// `ComparisonOperator` in the `SliConfig` or `RequestBasedSliConfig`. The
    /// default value is `false`.
    ///
    /// This is supported for SLOs on a service, service operation, or a dependency.
    create_recommended_slo: ?bool = null,

    /// An optional description for this SLO.
    description: ?[]const u8 = null,

    /// This structure contains the attributes that determine the goal of the SLO.
    goal: ?Goal = null,

    /// A name for this SLO.
    name: []const u8,

    /// If this SLO is a request-based SLO, this structure defines the information
    /// about what performance metric this SLO will monitor.
    ///
    /// You can't specify both `RequestBasedSliConfig` and `SliConfig` in the same
    /// operation.
    request_based_sli_config: ?RequestBasedServiceLevelIndicatorConfig = null,

    /// If this SLO is a period-based SLO, this structure defines the information
    /// about what performance metric this SLO will monitor.
    ///
    /// You can't specify both `RequestBasedSliConfig` and `SliConfig` in the same
    /// operation.
    sli_config: ?ServiceLevelIndicatorConfig = null,

    /// A list of key-value pairs to associate with the SLO. You can associate as
    /// many as 50 tags with an SLO. To be able to associate tags with the SLO when
    /// you create the SLO, you must have the `cloudwatch:TagResource` permission.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions by granting a user permission to access or
    /// change only resources with certain tag values.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .auto_investigation_enabled = "AutoInvestigationEnabled",
        .burn_rate_configurations = "BurnRateConfigurations",
        .create_recommended_slo = "CreateRecommendedSlo",
        .description = "Description",
        .goal = "Goal",
        .name = "Name",
        .request_based_sli_config = "RequestBasedSliConfig",
        .sli_config = "SliConfig",
        .tags = "Tags",
    };
};

pub const CreateServiceLevelObjectiveOutput = struct {
    /// A structure that contains information about the SLO that you just created.
    slo: ?ServiceLevelObjective = null,

    pub const json_field_names = .{
        .slo = "Slo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceLevelObjectiveInput, options: CallOptions) !CreateServiceLevelObjectiveOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceLevelObjectiveInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-signals", "Application Signals", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/slo";

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
    if (input.create_recommended_slo) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CreateRecommendedSlo\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceLevelObjectiveOutput {
    var result: CreateServiceLevelObjectiveOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateServiceLevelObjectiveOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
