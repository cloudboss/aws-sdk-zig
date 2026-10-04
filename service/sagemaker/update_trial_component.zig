const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrialComponentArtifact = @import("trial_component_artifact.zig").TrialComponentArtifact;
const TrialComponentParameterValue = @import("trial_component_parameter_value.zig").TrialComponentParameterValue;
const TrialComponentStatus = @import("trial_component_status.zig").TrialComponentStatus;

pub const UpdateTrialComponentInput = struct {
    /// The name of the component as displayed. The name doesn't need to be unique.
    /// If `DisplayName` isn't specified, `TrialComponentName` is displayed.
    display_name: ?[]const u8 = null,

    /// When the component ended.
    end_time: ?i64 = null,

    /// Replaces all of the component's input artifacts with the specified artifacts
    /// or adds new input artifacts. Existing input artifacts are replaced if the
    /// trial component is updated with an identical input artifact key.
    input_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    /// The input artifacts to remove from the component.
    input_artifacts_to_remove: ?[]const []const u8 = null,

    /// Replaces all of the component's output artifacts with the specified
    /// artifacts or adds new output artifacts. Existing output artifacts are
    /// replaced if the trial component is updated with an identical output artifact
    /// key.
    output_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    /// The output artifacts to remove from the component.
    output_artifacts_to_remove: ?[]const []const u8 = null,

    /// Replaces all of the component's hyperparameters with the specified
    /// hyperparameters or add new hyperparameters. Existing hyperparameters are
    /// replaced if the trial component is updated with an identical hyperparameter
    /// key.
    parameters: ?[]const aws.map.MapEntry(TrialComponentParameterValue) = null,

    /// The hyperparameters to remove from the component.
    parameters_to_remove: ?[]const []const u8 = null,

    /// When the component started.
    start_time: ?i64 = null,

    /// The new status of the component.
    status: ?TrialComponentStatus = null,

    /// The name of the component to update.
    trial_component_name: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .end_time = "EndTime",
        .input_artifacts = "InputArtifacts",
        .input_artifacts_to_remove = "InputArtifactsToRemove",
        .output_artifacts = "OutputArtifacts",
        .output_artifacts_to_remove = "OutputArtifactsToRemove",
        .parameters = "Parameters",
        .parameters_to_remove = "ParametersToRemove",
        .start_time = "StartTime",
        .status = "Status",
        .trial_component_name = "TrialComponentName",
    };
};

pub const UpdateTrialComponentOutput = struct {
    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .trial_component_arn = "TrialComponentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTrialComponentInput, options: CallOptions) !UpdateTrialComponentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTrialComponentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateTrialComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTrialComponentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateTrialComponentOutput, body, allocator);
}
