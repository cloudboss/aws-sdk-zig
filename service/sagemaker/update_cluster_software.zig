const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const UpdateClusterSoftwareInstanceGroupSpecification = @import("update_cluster_software_instance_group_specification.zig").UpdateClusterSoftwareInstanceGroupSpecification;

pub const UpdateClusterSoftwareInput = struct {
    /// Specify the name or the Amazon Resource Name (ARN) of the SageMaker HyperPod
    /// cluster you want to update for security patching.
    cluster_name: []const u8,

    /// The configuration to use when updating the AMI versions.
    deployment_config: ?DeploymentConfiguration = null,

    /// When configuring your HyperPod cluster, you can specify an image ID using
    /// one of the following options:
    ///
    /// * `HyperPodPublicAmiId`: Use a HyperPod public AMI
    /// * `CustomAmiId`: Use your custom AMI
    /// * `default`: Use the default latest system image
    ///
    /// If you choose to use a custom AMI (`CustomAmiId`), ensure it meets the
    /// following requirements:
    ///
    /// * Encryption: The custom AMI must be unencrypted.
    /// * Ownership: The custom AMI must be owned by the same Amazon Web Services
    ///   account that is creating the HyperPod cluster.
    /// * Volume support: Only the primary AMI snapshot volume is supported;
    ///   additional AMI volumes are not supported.
    ///
    /// When updating the instance group's AMI through the `UpdateClusterSoftware`
    /// operation, if an instance group uses a custom AMI, you must provide an
    /// `ImageId` or use the default as input. Note that if you don't specify an
    /// instance group in your `UpdateClusterSoftware` request, then all of the
    /// instance groups are patched with the specified image.
    image_id: ?[]const u8 = null,

    /// The array of instance groups for which to update AMI versions.
    instance_groups: ?[]const UpdateClusterSoftwareInstanceGroupSpecification = null,

    pub const json_field_names = .{
        .cluster_name = "ClusterName",
        .deployment_config = "DeploymentConfig",
        .image_id = "ImageId",
        .instance_groups = "InstanceGroups",
    };
};

pub const UpdateClusterSoftwareOutput = struct {
    /// The Amazon Resource Name (ARN) of the SageMaker HyperPod cluster being
    /// updated for security patching.
    cluster_arn: []const u8,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterSoftwareInput, options: CallOptions) !UpdateClusterSoftwareOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterSoftwareInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateClusterSoftware");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterSoftwareOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateClusterSoftwareOutput, body, allocator);
}
