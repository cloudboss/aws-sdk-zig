const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentDeploymentSpecification = @import("component_deployment_specification.zig").ComponentDeploymentSpecification;
const DeploymentPolicies = @import("deployment_policies.zig").DeploymentPolicies;
const DeploymentIoTJobConfiguration = @import("deployment_io_t_job_configuration.zig").DeploymentIoTJobConfiguration;

pub const CreateDeploymentInput = struct {
    /// A unique, case-sensitive identifier that you can provide to ensure that the
    /// request is idempotent.
    /// Idempotency means that the request is successfully processed only once, even
    /// if you send the request multiple times.
    /// When a request succeeds, and you specify the same client token for
    /// subsequent successful requests, the IoT Greengrass V2 service
    /// returns the successful response that it caches from the previous request.
    /// IoT Greengrass V2 caches successful responses for
    /// idempotent requests for up to 8 hours.
    client_token: ?[]const u8 = null,

    /// The components to deploy. This is a dictionary, where each key is the name
    /// of a component,
    /// and each key's value is the version and configuration to deploy for that
    /// component.
    components: ?[]const aws.map.MapEntry(ComponentDeploymentSpecification) = null,

    /// The name of the deployment.
    deployment_name: ?[]const u8 = null,

    /// The deployment policies for the deployment. These policies define how the
    /// deployment
    /// updates components and handles failure.
    deployment_policies: ?DeploymentPolicies = null,

    /// The job configuration for the deployment configuration. The job
    /// configuration specifies
    /// the rollout, timeout, and stop configurations for the deployment
    /// configuration.
    iot_job_configuration: ?DeploymentIoTJobConfiguration = null,

    /// The parent deployment's target
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) within a subdeployment.
    parent_target_arn: ?[]const u8 = null,

    /// A list of key-value pairs that contain metadata for the resource. For more
    /// information, see [Tag your
    /// resources](https://docs.aws.amazon.com/greengrass/v2/developerguide/tag-resources.html) in the *IoT Greengrass V2 Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the target IoT thing or thing group. When creating a subdeployment, the targetARN can only be a thing group.
    target_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .components = "components",
        .deployment_name = "deploymentName",
        .deployment_policies = "deploymentPolicies",
        .iot_job_configuration = "iotJobConfiguration",
        .parent_target_arn = "parentTargetArn",
        .tags = "tags",
        .target_arn = "targetArn",
    };
};

pub const CreateDeploymentOutput = struct {
    /// The ID of the deployment.
    deployment_id: ?[]const u8 = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the IoT job that applies the deployment to target devices.
    iot_job_arn: ?[]const u8 = null,

    /// The ID of the IoT job that applies the deployment to target devices.
    iot_job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .iot_job_arn = "iotJobArn",
        .iot_job_id = "iotJobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentInput, options: CallOptions) !CreateDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "GreengrassV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/greengrass/v2/deployments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.components) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"components\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deployment_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deploymentName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deployment_policies) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deploymentPolicies\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.iot_job_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"iotJobConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_target_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentTargetArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetArn\":");
    try aws.json.writeValue(@TypeOf(input.target_arn), input.target_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentOutput {
    var result: CreateDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDeploymentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
