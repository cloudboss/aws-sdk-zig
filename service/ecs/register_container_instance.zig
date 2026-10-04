const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Attribute = @import("attribute.zig").Attribute;
const PlatformDevice = @import("platform_device.zig").PlatformDevice;
const Tag = @import("tag.zig").Tag;
const Resource = @import("resource.zig").Resource;
const VersionInfo = @import("version_info.zig").VersionInfo;
const ContainerInstance = @import("container_instance.zig").ContainerInstance;

pub const RegisterContainerInstanceInput = struct {
    /// The container instance attributes that this container instance supports.
    attributes: ?[]const Attribute = null,

    /// The short name or full Amazon Resource Name (ARN) of the cluster to register
    /// your container instance with. If you do not specify a cluster, the default
    /// cluster is assumed.
    cluster: ?[]const u8 = null,

    /// The ARN of the container instance (if it was previously registered).
    container_instance_arn: ?[]const u8 = null,

    /// The instance identity document for the EC2 instance to register. This
    /// document can be found by running the following command from the instance:
    /// `curl http://169.254.169.254/latest/dynamic/instance-identity/document/`
    instance_identity_document: ?[]const u8 = null,

    /// The instance identity document signature for the EC2 instance to register.
    /// This signature can be found by running the following command from the
    /// instance: `curl
    /// http://169.254.169.254/latest/dynamic/instance-identity/signature/`
    instance_identity_document_signature: ?[]const u8 = null,

    /// The devices that are available on the container instance. The supported
    /// device types are GPUs and Neuron devices.
    platform_devices: ?[]const PlatformDevice = null,

    /// The metadata that you apply to the container instance to help you categorize
    /// and organize them. Each tag consists of a key and an optional value. You
    /// define both.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: ?[]const Tag = null,

    /// The resources available on the instance.
    total_resources: ?[]const Resource = null,

    /// The version information for the Amazon ECS container agent and Docker daemon
    /// that runs on the container instance.
    version_info: ?VersionInfo = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .cluster = "cluster",
        .container_instance_arn = "containerInstanceArn",
        .instance_identity_document = "instanceIdentityDocument",
        .instance_identity_document_signature = "instanceIdentityDocumentSignature",
        .platform_devices = "platformDevices",
        .tags = "tags",
        .total_resources = "totalResources",
        .version_info = "versionInfo",
    };
};

pub const RegisterContainerInstanceOutput = struct {
    /// The container instance that was registered.
    container_instance: ?ContainerInstance = null,

    pub const json_field_names = .{
        .container_instance = "containerInstance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterContainerInstanceInput, options: CallOptions) !RegisterContainerInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterContainerInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.RegisterContainerInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterContainerInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterContainerInstanceOutput, body, allocator);
}
