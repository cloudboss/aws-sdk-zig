const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomLaunchTemplate = @import("custom_launch_template.zig").CustomLaunchTemplate;
const PurchaseOption = @import("purchase_option.zig").PurchaseOption;
const ScalingConfigurationRequest = @import("scaling_configuration_request.zig").ScalingConfigurationRequest;
const UpdateComputeNodeGroupSlurmConfigurationRequest = @import("update_compute_node_group_slurm_configuration_request.zig").UpdateComputeNodeGroupSlurmConfigurationRequest;
const SpotOptions = @import("spot_options.zig").SpotOptions;
const ComputeNodeGroup = @import("compute_node_group.zig").ComputeNodeGroup;

pub const UpdateComputeNodeGroupInput = struct {
    /// The ID of the Amazon Machine Image (AMI) that PCS uses to launch instances.
    /// If not provided, PCS uses the AMI ID specified in the custom launch
    /// template.
    ami_id: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Idempotency ensures that an API request
    /// completes only once. With an idempotent request, if the original request
    /// completes successfully, the subsequent retries with the same client token
    /// return the result from the original successful request and they have no
    /// additional effect. If you don't specify a client token, the CLI and SDK
    /// automatically generate 1 for you.
    client_token: ?[]const u8 = null,

    /// The name or ID of the cluster of the compute node group.
    cluster_identifier: []const u8,

    /// The name or ID of the compute node group.
    compute_node_group_identifier: []const u8,

    custom_launch_template: ?CustomLaunchTemplate = null,

    /// The Amazon Resource Name (ARN) of the IAM instance profile used to pass an
    /// IAM role when launching EC2 instances. The role contained in your instance
    /// profile must have the `pcs:RegisterComputeNodeGroupInstance` permission and
    /// the role name must start with `AWSPCS` or must have the path `/aws-pcs/`.
    /// For more information, see [IAM instance profiles for
    /// PCS](https://docs.aws.amazon.com/pcs/latest/userguide/security-instance-profiles.html) in the *PCS User Guide*.
    iam_instance_profile_arn: ?[]const u8 = null,

    /// Specifies how EC2 instances are purchased on your behalf. PCS supports
    /// On-Demand Instances, Spot Instances, and Amazon EC2 Capacity Blocks for ML.
    /// For more information, see [Amazon EC2 billing and purchasing
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-purchasing-options.html) in the *Amazon Elastic Compute Cloud User Guide*. For more information about PCS support for Capacity Blocks, see [Using Amazon EC2 Capacity Blocks for ML with PCS](https://docs.aws.amazon.com/pcs/latest/userguide/capacity-blocks.html) in the *PCS User Guide*. If you don't provide this option, it defaults to On-Demand.
    purchase_option: ?PurchaseOption = null,

    /// Specifies the boundaries of the compute node group auto scaling.
    scaling_configuration: ?ScalingConfigurationRequest = null,

    /// Additional options related to the Slurm scheduler.
    slurm_configuration: ?UpdateComputeNodeGroupSlurmConfigurationRequest = null,

    spot_options: ?SpotOptions = null,

    /// The list of subnet IDs where the compute node group provisions instances.
    /// The subnets must be in the same VPC as the cluster.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ami_id = "amiId",
        .client_token = "clientToken",
        .cluster_identifier = "clusterIdentifier",
        .compute_node_group_identifier = "computeNodeGroupIdentifier",
        .custom_launch_template = "customLaunchTemplate",
        .iam_instance_profile_arn = "iamInstanceProfileArn",
        .purchase_option = "purchaseOption",
        .scaling_configuration = "scalingConfiguration",
        .slurm_configuration = "slurmConfiguration",
        .spot_options = "spotOptions",
        .subnet_ids = "subnetIds",
    };
};

pub const UpdateComputeNodeGroupOutput = struct {
    compute_node_group: ?ComputeNodeGroup = null,

    pub const json_field_names = .{
        .compute_node_group = "computeNodeGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateComputeNodeGroupInput, options: CallOptions) !UpdateComputeNodeGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pcs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateComputeNodeGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pcs", "PCS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSParallelComputingService.UpdateComputeNodeGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateComputeNodeGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateComputeNodeGroupOutput, body, allocator);
}
