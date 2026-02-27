const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateComputeNodeGroupInput, options: Options) !UpdateComputeNodeGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pcs");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateComputeNodeGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pcs", "PCS", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AWSParallelComputingService.UpdateComputeNodeGroup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateComputeNodeGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateComputeNodeGroupOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
