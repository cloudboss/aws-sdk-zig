const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetScalingConfigurationRecommendationInput, options: CallOptions) !GetScalingConfigurationRecommendationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetScalingConfigurationRecommendationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.GetScalingConfigurationRecommendation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetScalingConfigurationRecommendationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetScalingConfigurationRecommendationOutput, body, allocator);
}
