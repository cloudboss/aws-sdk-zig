const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterSoftwareInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
