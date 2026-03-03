const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const NotebookInstanceAcceleratorType = @import("notebook_instance_accelerator_type.zig").NotebookInstanceAcceleratorType;
const DirectInternetAccess = @import("direct_internet_access.zig").DirectInternetAccess;
const InstanceMetadataServiceConfiguration = @import("instance_metadata_service_configuration.zig").InstanceMetadataServiceConfiguration;
const InstanceType = @import("instance_type.zig").InstanceType;
const IPAddressType = @import("ip_address_type.zig").IPAddressType;
const RootAccess = @import("root_access.zig").RootAccess;
const Tag = @import("tag.zig").Tag;

pub const CreateNotebookInstanceInput = struct {
    /// This parameter is no longer supported. Elastic Inference (EI) is no longer
    /// available.
    ///
    /// This parameter was used to specify a list of EI instance types to associate
    /// with this notebook instance.
    accelerator_types: ?[]const NotebookInstanceAcceleratorType = null,

    /// An array of up to three Git repositories to associate with the notebook
    /// instance. These can be either the names of Git repositories stored as
    /// resources in your account, or the URL of Git repositories in [Amazon Web
    /// Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository. These repositories are cloned at the same level as the default repository of your notebook instance. For more information, see [Associating Git Repositories with SageMaker AI Notebook Instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html).
    additional_code_repositories: ?[]const []const u8 = null,

    /// A Git repository to associate with the notebook instance as its default code
    /// repository. This can be either the name of a Git repository stored as a
    /// resource in your account, or the URL of a Git repository in [Amazon Web
    /// Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository. When you open a notebook instance, it opens in the directory that contains this repository. For more information, see [Associating Git Repositories with SageMaker AI Notebook Instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html).
    default_code_repository: ?[]const u8 = null,

    /// Sets whether SageMaker AI provides internet access to the notebook instance.
    /// If you set this to `Disabled` this notebook instance is able to access
    /// resources only in your VPC, and is not be able to connect to SageMaker AI
    /// training and endpoint services unless you configure a NAT Gateway in your
    /// VPC.
    ///
    /// For more information, see [Notebook Instances Are Internet-Enabled by
    /// Default](https://docs.aws.amazon.com/sagemaker/latest/dg/appendix-additional-considerations.html#appendix-notebook-and-internet-access). You can set the value of this parameter to `Disabled` only if you set a value for the `SubnetId` parameter.
    direct_internet_access: ?DirectInternetAccess = null,

    /// Information on the IMDS configuration of the notebook instance
    instance_metadata_service_configuration: ?InstanceMetadataServiceConfiguration = null,

    /// The type of ML compute instance to launch for the notebook instance.
    instance_type: InstanceType,

    /// The IP address type for the notebook instance. Specify `ipv4` for IPv4-only
    /// connectivity or `dualstack` for both IPv4 and IPv6 connectivity. When you
    /// specify `dualstack`, the subnet must support IPv6 CIDR blocks. If not
    /// specified, defaults to `ipv4`.
    ip_address_type: ?IPAddressType = null,

    /// The Amazon Resource Name (ARN) of a Amazon Web Services Key Management
    /// Service key that SageMaker AI uses to encrypt data on the storage volume
    /// attached to your notebook instance. The KMS key you provide must be enabled.
    /// For information, see [Enabling and Disabling
    /// Keys](https://docs.aws.amazon.com/kms/latest/developerguide/enabling-keys.html) in the *Amazon Web Services Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8 = null,

    /// The name of a lifecycle configuration to associate with the notebook
    /// instance. For information about lifestyle configurations, see [Step 2.1:
    /// (Optional) Customize a Notebook
    /// Instance](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html).
    lifecycle_config_name: ?[]const u8 = null,

    /// The name of the new notebook instance.
    notebook_instance_name: []const u8,

    /// The platform identifier of the notebook instance runtime environment. The
    /// default value is `notebook-al2-v2`.
    platform_identifier: ?[]const u8 = null,

    /// When you send any requests to Amazon Web Services resources from the
    /// notebook instance, SageMaker AI assumes this role to perform tasks on your
    /// behalf. You must grant this role necessary permissions so SageMaker AI can
    /// perform these tasks. The policy must allow the SageMaker AI service
    /// principal (sagemaker.amazonaws.com) permissions to assume this role. For
    /// more information, see [SageMaker AI
    /// Roles](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-roles.html).
    ///
    /// To be able to pass this role to SageMaker AI, the caller of this API must
    /// have the `iam:PassRole` permission.
    role_arn: []const u8,

    /// Whether root access is enabled or disabled for users of the notebook
    /// instance. The default value is `Enabled`.
    ///
    /// Lifecycle configurations need root access to be able to set up a notebook
    /// instance. Because of this, lifecycle configurations associated with a
    /// notebook instance always run with root access even if you disable root
    /// access for users.
    root_access: ?RootAccess = null,

    /// The VPC security group IDs, in the form sg-xxxxxxxx. The security groups
    /// must be for the same VPC as specified in the subnet.
    security_group_ids: ?[]const []const u8 = null,

    /// The ID of the subnet in a VPC to which you would like to have a connectivity
    /// from your ML compute instance.
    subnet_id: ?[]const u8 = null,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const Tag = null,

    /// The size, in GB, of the ML storage volume to attach to the notebook
    /// instance. The default value is 5 GB.
    volume_size_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .accelerator_types = "AcceleratorTypes",
        .additional_code_repositories = "AdditionalCodeRepositories",
        .default_code_repository = "DefaultCodeRepository",
        .direct_internet_access = "DirectInternetAccess",
        .instance_metadata_service_configuration = "InstanceMetadataServiceConfiguration",
        .instance_type = "InstanceType",
        .ip_address_type = "IpAddressType",
        .kms_key_id = "KmsKeyId",
        .lifecycle_config_name = "LifecycleConfigName",
        .notebook_instance_name = "NotebookInstanceName",
        .platform_identifier = "PlatformIdentifier",
        .role_arn = "RoleArn",
        .root_access = "RootAccess",
        .security_group_ids = "SecurityGroupIds",
        .subnet_id = "SubnetId",
        .tags = "Tags",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};

pub const CreateNotebookInstanceOutput = struct {
    /// The Amazon Resource Name (ARN) of the notebook instance.
    notebook_instance_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .notebook_instance_arn = "NotebookInstanceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNotebookInstanceInput, options: CallOptions) !CreateNotebookInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNotebookInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateNotebookInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNotebookInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateNotebookInstanceOutput, body, allocator);
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
