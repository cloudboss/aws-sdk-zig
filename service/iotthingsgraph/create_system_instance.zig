const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DefinitionDocument = @import("definition_document.zig").DefinitionDocument;
const MetricsConfiguration = @import("metrics_configuration.zig").MetricsConfiguration;
const Tag = @import("tag.zig").Tag;
const DeploymentTarget = @import("deployment_target.zig").DeploymentTarget;
const SystemInstanceSummary = @import("system_instance_summary.zig").SystemInstanceSummary;

pub const CreateSystemInstanceInput = struct {
    definition: DefinitionDocument,

    /// The ARN of the IAM role that AWS IoT Things Graph will assume when it
    /// executes the flow. This role must have
    /// read and write access to AWS Lambda and AWS IoT and any other AWS services
    /// that the flow uses when it executes. This
    /// value is required if the value of the `target` parameter is `CLOUD`.
    flow_actions_role_arn: ?[]const u8 = null,

    /// The name of the Greengrass group where the system instance will be deployed.
    /// This value is required if
    /// the value of the `target` parameter is `GREENGRASS`.
    greengrass_group_name: ?[]const u8 = null,

    metrics_configuration: ?MetricsConfiguration = null,

    /// The name of the Amazon Simple Storage Service bucket that will be used to
    /// store and deploy the system instance's resource file. This value is required
    /// if
    /// the value of the `target` parameter is `GREENGRASS`.
    s_3_bucket_name: ?[]const u8 = null,

    /// Metadata, consisting of key-value pairs, that can be used to categorize your
    /// system instances.
    tags: ?[]const Tag = null,

    /// The target type of the deployment. Valid values are `GREENGRASS` and
    /// `CLOUD`.
    target: DeploymentTarget,

    pub const json_field_names = .{
        .definition = "definition",
        .flow_actions_role_arn = "flowActionsRoleArn",
        .greengrass_group_name = "greengrassGroupName",
        .metrics_configuration = "metricsConfiguration",
        .s_3_bucket_name = "s3BucketName",
        .tags = "tags",
        .target = "target",
    };
};

pub const CreateSystemInstanceOutput = struct {
    /// The summary object that describes the new system instance.
    summary: ?SystemInstanceSummary = null,

    pub const json_field_names = .{
        .summary = "summary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSystemInstanceInput, options: CallOptions) !CreateSystemInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotthingsgraph", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSystemInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "IotThingsGraphFrontEndService.CreateSystemInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSystemInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSystemInstanceOutput, body, allocator);
}
