const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthType = @import("auth_type.zig").AuthType;
const AutoDeploymentMode = @import("auto_deployment_mode.zig").AutoDeploymentMode;
const RevisionWeight = @import("revision_weight.zig").RevisionWeight;
const ScalingConfig = @import("scaling_config.zig").ScalingConfig;
const ThrottleConfig = @import("throttle_config.zig").ThrottleConfig;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const RegionalEndpoint = @import("regional_endpoint.zig").RegionalEndpoint;
const EndpointState = @import("endpoint_state.zig").EndpointState;
const EndpointUpdateStatus = @import("endpoint_update_status.zig").EndpointUpdateStatus;

pub const UpdateWebFunctionEndpointInput = struct {
    /// The authorization type for the endpoint.
    auth_type: ?AuthType = null,

    /// The auto-deployment mode for the endpoint.
    auto_deployment_mode: ?AutoDeploymentMode = null,

    /// A description of the endpoint.
    description: ?[]const u8 = null,

    /// The name of the endpoint to update. You can specify the endpoint name or the
    /// endpoint ARN. The length constraint applies only to the full ARN. If you
    /// specify only the endpoint name, it is limited to 64 characters in length.
    endpoint_name: []const u8,

    /// The name of the web function. You can specify the function name or the
    /// function ARN. The length constraint applies only to the full ARN. If you
    /// specify only the function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// A list of revision weights that determine how traffic is distributed across
    /// revisions.
    revision_weights: ?[]const RevisionWeight = null,

    /// The scaling configuration for the endpoint. Omit this field to keep the
    /// current scaling configuration. To clear a previously set `maxEnvironments`
    /// value, specify an empty object.
    scaling_config: ?ScalingConfig = null,

    /// The throttling configuration for the endpoint. Omit this field to keep the
    /// current throttling configuration. To clear a previously set `rateLimit`
    /// value, specify an empty object.
    throttle_config: ?ThrottleConfig = null,

    pub const json_field_names = .{
        .auth_type = "authType",
        .auto_deployment_mode = "autoDeploymentMode",
        .description = "description",
        .endpoint_name = "endpointName",
        .function_name = "functionName",
        .revision_weights = "revisionWeights",
        .scaling_config = "scalingConfig",
        .throttle_config = "throttleConfig",
    };
};

pub const UpdateWebFunctionEndpointOutput = struct {
    auth_type: AuthType,

    auto_deployment_mode: AutoDeploymentMode,

    /// The date and time the endpoint was created.
    created_at: i64,

    /// The description of the endpoint.
    description: ?[]const u8 = null,

    /// The domain name assigned to the endpoint.
    domain_name: []const u8,

    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: []const u8,

    /// The name of the endpoint.
    endpoint_name: []const u8,

    endpoint_type: EndpointType,

    /// The Amazon Resource Name (ARN) of the web function.
    function_arn: []const u8,

    /// The list of regional endpoint configurations.
    regional_endpoints: ?[]const aws.map.MapEntry(RegionalEndpoint) = null,

    /// The Regions configured for the endpoint.
    regions: ?[]const []const u8 = null,

    /// The traffic distribution across revisions for the endpoint. Each entry maps
    /// a revision to a weight from 1 to 100.
    revision_weights: ?[]const RevisionWeight = null,

    scaling_config: ?ScalingConfig = null,

    /// The current state of the endpoint.
    state: EndpointState,

    /// The reason for the current state of the endpoint.
    state_reason: []const u8,

    throttle_config: ?ThrottleConfig = null,

    /// The date and time the endpoint was last updated.
    updated_at: i64,

    update_status: ?EndpointUpdateStatus = null,

    /// The reason for the endpoint's most recent update status.
    update_status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_type = "authType",
        .auto_deployment_mode = "autoDeploymentMode",
        .created_at = "createdAt",
        .description = "description",
        .domain_name = "domainName",
        .endpoint_arn = "endpointArn",
        .endpoint_name = "endpointName",
        .endpoint_type = "endpointType",
        .function_arn = "functionArn",
        .regional_endpoints = "regionalEndpoints",
        .regions = "regions",
        .revision_weights = "revisionWeights",
        .scaling_config = "scalingConfig",
        .state = "state",
        .state_reason = "stateReason",
        .throttle_config = "throttleConfig",
        .updated_at = "updatedAt",
        .update_status = "updateStatus",
        .update_status_reason = "updateStatusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWebFunctionEndpointInput, options: CallOptions) !UpdateWebFunctionEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWebFunctionEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-03-07/web-functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auth_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_deployment_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoDeploymentMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revision_weights) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"revisionWeights\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scalingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.throttle_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"throttleConfig\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWebFunctionEndpointOutput {
    const result: UpdateWebFunctionEndpointOutput = try aws.json.parseJsonObject(
        UpdateWebFunctionEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
