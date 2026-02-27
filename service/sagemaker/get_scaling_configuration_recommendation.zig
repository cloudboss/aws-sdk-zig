const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ScalingPolicyObjective = @import("scaling_policy_objective.zig").ScalingPolicyObjective;
const DynamicScalingConfiguration = @import("dynamic_scaling_configuration.zig").DynamicScalingConfiguration;
const ScalingPolicyMetric = @import("scaling_policy_metric.zig").ScalingPolicyMetric;

pub const GetScalingConfigurationRecommendationInput = struct {
    /// The name of an endpoint benchmarked during a previously completed inference
    /// recommendation job. This name should come from one of the recommendations
    /// returned by the job specified in the `InferenceRecommendationsJobName`
    /// field.
    ///
    /// Specify either this field or the `RecommendationId` field.
    endpoint_name: ?[]const u8 = null,

    /// The name of a previously completed Inference Recommender job.
    inference_recommendations_job_name: []const u8,

    /// The recommendation ID of a previously completed inference recommendation.
    /// This ID should come from one of the recommendations returned by the job
    /// specified in the `InferenceRecommendationsJobName` field.
    ///
    /// Specify either this field or the `EndpointName` field.
    recommendation_id: ?[]const u8 = null,

    /// An object where you specify the anticipated traffic pattern for an endpoint.
    scaling_policy_objective: ?ScalingPolicyObjective = null,

    /// The percentage of how much utilization you want an instance to use before
    /// autoscaling. The default value is 50%.
    target_cpu_utilization_per_core: ?i32 = null,

    pub const json_field_names = .{
        .endpoint_name = "EndpointName",
        .inference_recommendations_job_name = "InferenceRecommendationsJobName",
        .recommendation_id = "RecommendationId",
        .scaling_policy_objective = "ScalingPolicyObjective",
        .target_cpu_utilization_per_core = "TargetCpuUtilizationPerCore",
    };
};

pub const GetScalingConfigurationRecommendationOutput = struct {
    /// An object with the recommended values for you to specify when creating an
    /// autoscaling policy.
    dynamic_scaling_configuration: ?DynamicScalingConfiguration = null,

    /// The name of an endpoint benchmarked during a previously completed Inference
    /// Recommender job.
    endpoint_name: ?[]const u8 = null,

    /// The name of a previously completed Inference Recommender job.
    inference_recommendations_job_name: ?[]const u8 = null,

    /// An object with a list of metrics that were benchmarked during the previously
    /// completed Inference Recommender job.
    metric: ?ScalingPolicyMetric = null,

    /// The recommendation ID of a previously completed inference recommendation.
    recommendation_id: ?[]const u8 = null,

    /// An object representing the anticipated traffic pattern for an endpoint that
    /// you specified in the request.
    scaling_policy_objective: ?ScalingPolicyObjective = null,

    /// The percentage of how much utilization you want an instance to use before
    /// autoscaling, which you specified in the request. The default value is 50%.
    target_cpu_utilization_per_core: ?i32 = null,

    pub const json_field_names = .{
        .dynamic_scaling_configuration = "DynamicScalingConfiguration",
        .endpoint_name = "EndpointName",
        .inference_recommendations_job_name = "InferenceRecommendationsJobName",
        .metric = "Metric",
        .recommendation_id = "RecommendationId",
        .scaling_policy_objective = "ScalingPolicyObjective",
        .target_cpu_utilization_per_core = "TargetCpuUtilizationPerCore",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetScalingConfigurationRecommendationInput, options: Options) !GetScalingConfigurationRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetScalingConfigurationRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.GetScalingConfigurationRecommendation");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetScalingConfigurationRecommendationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetScalingConfigurationRecommendationOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
