const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentTarget = @import("deployment_target.zig").DeploymentTarget;

pub const BatchGetDeploymentTargetsInput = struct {
    /// The unique ID of a deployment.
    deployment_id: []const u8,

    /// The unique IDs of the deployment targets. The compute platform of the
    /// deployment
    /// determines the type of the targets and their formats. The maximum number of
    /// deployment
    /// target IDs you can specify is 25.
    ///
    /// * For deployments that use the EC2/On-premises compute platform, the target
    ///   IDs
    /// are Amazon EC2 or on-premises instances IDs, and their target type is
    /// `instanceTarget`.
    ///
    /// * For deployments that use the Lambda compute platform, the
    /// target IDs are the names of Lambda functions, and their target type
    /// is `instanceTarget`.
    ///
    /// * For deployments that use the Amazon ECS compute platform, the target
    /// IDs are pairs of Amazon ECS clusters and services specified using the
    /// format `:`. Their target type
    /// is `ecsTarget`.
    ///
    /// * For deployments that are deployed with CloudFormation, the target IDs are
    /// CloudFormation stack IDs. Their target type is
    /// `cloudFormationTarget`.
    target_ids: []const []const u8,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
        .target_ids = "targetIds",
    };
};

pub const BatchGetDeploymentTargetsOutput = struct {
    /// A list of target objects for a deployment. Each target object contains
    /// details about
    /// the target, such as its status and lifecycle events. The type of the target
    /// objects
    /// depends on the deployment' compute platform.
    ///
    /// * **EC2/On-premises**: Each target object is an
    /// Amazon EC2 or on-premises instance.
    ///
    /// * **Lambda**: The target object is a
    /// specific version of an Lambda function.
    ///
    /// * **Amazon ECS**: The target object is an
    /// Amazon ECS service.
    ///
    /// * **CloudFormation**: The target object is
    /// an CloudFormation blue/green deployment.
    deployment_targets: ?[]const DeploymentTarget = null,

    pub const json_field_names = .{
        .deployment_targets = "deploymentTargets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetDeploymentTargetsInput, options: CallOptions) !BatchGetDeploymentTargetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetDeploymentTargetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.BatchGetDeploymentTargets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetDeploymentTargetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetDeploymentTargetsOutput, body, allocator);
}
