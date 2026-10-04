const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserContext = @import("user_context.zig").UserContext;
const TrialComponentArtifact = @import("trial_component_artifact.zig").TrialComponentArtifact;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const TrialComponentMetricSummary = @import("trial_component_metric_summary.zig").TrialComponentMetricSummary;
const TrialComponentParameterValue = @import("trial_component_parameter_value.zig").TrialComponentParameterValue;
const TrialComponentSource = @import("trial_component_source.zig").TrialComponentSource;
const TrialComponentStatus = @import("trial_component_status.zig").TrialComponentStatus;

pub const DescribeTrialComponentInput = struct {
    /// The name of the trial component to describe.
    trial_component_name: []const u8,

    pub const json_field_names = .{
        .trial_component_name = "TrialComponentName",
    };
};

pub const DescribeTrialComponentOutput = struct {
    /// Who created the trial component.
    created_by: ?UserContext = null,

    /// When the component was created.
    creation_time: ?i64 = null,

    /// The name of the component as displayed. If `DisplayName` isn't specified,
    /// `TrialComponentName` is displayed.
    display_name: ?[]const u8 = null,

    /// When the component ended.
    end_time: ?i64 = null,

    /// The input artifacts of the component.
    input_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    /// Who last modified the component.
    last_modified_by: ?UserContext = null,

    /// When the component was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the lineage group.
    lineage_group_arn: ?[]const u8 = null,

    metadata_properties: ?MetadataProperties = null,

    /// The metrics for the component.
    metrics: ?[]const TrialComponentMetricSummary = null,

    /// The output artifacts of the component.
    output_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    /// The hyperparameters of the component.
    parameters: ?[]const aws.map.MapEntry(TrialComponentParameterValue) = null,

    /// The Amazon Resource Name (ARN) of the source and, optionally, the job type.
    source: ?TrialComponentSource = null,

    /// A list of ARNs and, if applicable, job types for multiple sources of an
    /// experiment run.
    sources: ?[]const TrialComponentSource = null,

    /// When the component started.
    start_time: ?i64 = null,

    /// The status of the component. States include:
    ///
    /// * InProgress
    /// * Completed
    /// * Failed
    status: ?TrialComponentStatus = null,

    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8 = null,

    /// The name of the trial component.
    trial_component_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .end_time = "EndTime",
        .input_artifacts = "InputArtifacts",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .lineage_group_arn = "LineageGroupArn",
        .metadata_properties = "MetadataProperties",
        .metrics = "Metrics",
        .output_artifacts = "OutputArtifacts",
        .parameters = "Parameters",
        .source = "Source",
        .sources = "Sources",
        .start_time = "StartTime",
        .status = "Status",
        .trial_component_arn = "TrialComponentArn",
        .trial_component_name = "TrialComponentName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrialComponentInput, options: CallOptions) !DescribeTrialComponentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrialComponentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeTrialComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrialComponentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTrialComponentOutput, body, allocator);
}
