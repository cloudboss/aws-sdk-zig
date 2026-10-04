const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelVariantConfig = @import("model_variant_config.zig").ModelVariantConfig;
const InferenceExperimentStopDesiredState = @import("inference_experiment_stop_desired_state.zig").InferenceExperimentStopDesiredState;
const ModelVariantAction = @import("model_variant_action.zig").ModelVariantAction;

pub const StopInferenceExperimentInput = struct {
    /// An array of `ModelVariantConfig` objects. There is one for each variant that
    /// you want to deploy after the inference experiment stops. Each
    /// `ModelVariantConfig` describes the infrastructure configuration for
    /// deploying the corresponding variant.
    desired_model_variants: ?[]const ModelVariantConfig = null,

    /// The desired state of the experiment after stopping. The possible states are
    /// the following:
    ///
    /// * `Completed`: The experiment completed successfully
    /// * `Cancelled`: The experiment was canceled
    desired_state: ?InferenceExperimentStopDesiredState = null,

    /// Array of key-value pairs, with names of variants mapped to actions. The
    /// possible actions are the following:
    ///
    /// * `Promote` - Promote the shadow variant to a production variant
    /// * `Remove` - Delete the variant
    /// * `Retain` - Keep the variant as it is
    model_variant_actions: []const aws.map.MapEntry(ModelVariantAction),

    /// The name of the inference experiment to stop.
    name: []const u8,

    /// The reason for stopping the experiment.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .desired_model_variants = "DesiredModelVariants",
        .desired_state = "DesiredState",
        .model_variant_actions = "ModelVariantActions",
        .name = "Name",
        .reason = "Reason",
    };
};

pub const StopInferenceExperimentOutput = struct {
    /// The ARN of the stopped inference experiment.
    inference_experiment_arn: []const u8,

    pub const json_field_names = .{
        .inference_experiment_arn = "InferenceExperimentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopInferenceExperimentInput, options: CallOptions) !StopInferenceExperimentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopInferenceExperimentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.StopInferenceExperiment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopInferenceExperimentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StopInferenceExperimentOutput, body, allocator);
}
