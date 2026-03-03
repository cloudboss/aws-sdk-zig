const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EnhancedInfrastructureMetrics = @import("enhanced_infrastructure_metrics.zig").EnhancedInfrastructureMetrics;
const ExternalMetricsPreference = @import("external_metrics_preference.zig").ExternalMetricsPreference;
const LookBackPeriodPreference = @import("look_back_period_preference.zig").LookBackPeriodPreference;
const EffectivePreferredResource = @import("effective_preferred_resource.zig").EffectivePreferredResource;
const UtilizationPreference = @import("utilization_preference.zig").UtilizationPreference;

pub const GetEffectiveRecommendationPreferencesInput = struct {
    /// The Amazon Resource Name (ARN) of the resource for which to confirm
    /// effective
    /// recommendation preferences. Only EC2 instance and Amazon EC2 Auto Scaling
    /// group ARNs are
    /// currently supported.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};

pub const GetEffectiveRecommendationPreferencesOutput = struct {
    /// The status of the enhanced infrastructure metrics recommendation preference.
    /// Considers
    /// all applicable preferences that you might have set at the resource, account,
    /// and
    /// organization level.
    ///
    /// A status of `Active` confirms that the preference is applied in the latest
    /// recommendation refresh, and a status of `Inactive` confirms that it's not
    /// yet
    /// applied to recommendations.
    ///
    /// To validate whether the preference is applied to your last generated set of
    /// recommendations, review the `effectiveRecommendationPreferences` value in
    /// the
    /// response of the GetAutoScalingGroupRecommendations and
    /// GetEC2InstanceRecommendations actions.
    ///
    /// For more information, see [Enhanced
    /// infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    enhanced_infrastructure_metrics: ?EnhancedInfrastructureMetrics = null,

    /// The provider of the external metrics recommendation preference. Considers
    /// all
    /// applicable preferences that you might have set at the account and
    /// organization
    /// level.
    ///
    /// If the preference is applied in the latest recommendation refresh, an object
    /// with a
    /// valid `source` value appears in the response. If the preference isn't
    /// applied
    /// to the recommendations already, then this object doesn't appear in the
    /// response.
    ///
    /// To validate whether the preference is applied to your last generated set of
    /// recommendations, review the `effectiveRecommendationPreferences` value in
    /// the
    /// response of the GetEC2InstanceRecommendations actions.
    ///
    /// For more information, see [Enhanced
    /// infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/external-metrics-ingestion.html) in the *Compute Optimizer User
    /// Guide*.
    external_metrics_preference: ?ExternalMetricsPreference = null,

    /// The number of days the utilization metrics of the Amazon Web Services
    /// resource are analyzed.
    ///
    /// To validate that the preference is applied to your last generated set of
    /// recommendations, review
    /// the `effectiveRecommendationPreferences` value in the response of the
    /// GetAutoScalingGroupRecommendations or GetEC2InstanceRecommendations actions.
    look_back_period: ?LookBackPeriodPreference = null,

    /// The resource type values that are considered as candidates when generating
    /// rightsizing recommendations.
    /// This object resolves any wildcard expressions and returns the effective list
    /// of candidate resource type
    /// values. It also considers all applicable preferences that you set at the
    /// resource, account, and
    /// organization level.
    ///
    /// To validate that the preference is applied to your last generated set of
    /// recommendations, review the
    /// `effectiveRecommendationPreferences` value in the response of the
    /// GetAutoScalingGroupRecommendations
    /// or GetEC2InstanceRecommendations actions.
    preferred_resources: ?[]const EffectivePreferredResource = null,

    /// The resource’s CPU and memory utilization preferences, such as threshold and
    /// headroom,
    /// that were used to generate rightsizing recommendations. It considers all
    /// applicable preferences
    /// that you set at the resource, account, and organization level.
    ///
    /// To validate that the preference is applied to your last generated set of
    /// recommendations, review the
    /// `effectiveRecommendationPreferences` value in the response of the
    /// GetAutoScalingGroupRecommendations or GetEC2InstanceRecommendations actions.
    utilization_preferences: ?[]const UtilizationPreference = null,

    pub const json_field_names = .{
        .enhanced_infrastructure_metrics = "enhancedInfrastructureMetrics",
        .external_metrics_preference = "externalMetricsPreference",
        .look_back_period = "lookBackPeriod",
        .preferred_resources = "preferredResources",
        .utilization_preferences = "utilizationPreferences",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEffectiveRecommendationPreferencesInput, options: CallOptions) !GetEffectiveRecommendationPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "computeoptimizer");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEffectiveRecommendationPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("computeoptimizer", "Compute Optimizer", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.GetEffectiveRecommendationPreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEffectiveRecommendationPreferencesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEffectiveRecommendationPreferencesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
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
    if (std.mem.eql(u8, error_code, "MissingAuthenticationToken")) {
        return .{ .arena = arena, .kind = .{ .missing_authentication_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OptInRequiredException")) {
        return .{ .arena = arena, .kind = .{ .opt_in_required_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
