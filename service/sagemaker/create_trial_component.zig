const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrialComponentArtifact = @import("trial_component_artifact.zig").TrialComponentArtifact;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const TrialComponentParameterValue = @import("trial_component_parameter_value.zig").TrialComponentParameterValue;
const TrialComponentStatus = @import("trial_component_status.zig").TrialComponentStatus;
const Tag = @import("tag.zig").Tag;

pub const CreateTrialComponentInput = struct {
    /// The name of the component as displayed. The name doesn't need to be unique.
    /// If `DisplayName` isn't specified, `TrialComponentName` is displayed.
    display_name: ?[]const u8 = null,

    /// When the component ended.
    end_time: ?i64 = null,

    /// The input artifacts for the component. Examples of input artifacts are
    /// datasets, algorithms, hyperparameters, source code, and instance types.
    input_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    metadata_properties: ?MetadataProperties = null,

    /// The output artifacts for the component. Examples of output artifacts are
    /// metrics, snapshots, logs, and images.
    output_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    /// The hyperparameters for the component.
    parameters: ?[]const aws.map.MapEntry(TrialComponentParameterValue) = null,

    /// When the component started.
    start_time: ?i64 = null,

    /// The status of the component. States include:
    ///
    /// * InProgress
    /// * Completed
    /// * Failed
    status: ?TrialComponentStatus = null,

    /// A list of tags to associate with the component. You can use
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search on the tags.
    tags: ?[]const Tag = null,

    /// The name of the component. The name must be unique in your Amazon Web
    /// Services account and is not case-sensitive.
    trial_component_name: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .end_time = "EndTime",
        .input_artifacts = "InputArtifacts",
        .metadata_properties = "MetadataProperties",
        .output_artifacts = "OutputArtifacts",
        .parameters = "Parameters",
        .start_time = "StartTime",
        .status = "Status",
        .tags = "Tags",
        .trial_component_name = "TrialComponentName",
    };
};

pub const CreateTrialComponentOutput = struct {
    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .trial_component_arn = "TrialComponentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrialComponentInput, options: CallOptions) !CreateTrialComponentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrialComponentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateTrialComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrialComponentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTrialComponentOutput, body, allocator);
}
