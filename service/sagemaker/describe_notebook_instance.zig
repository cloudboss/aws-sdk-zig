const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NotebookInstanceAcceleratorType = @import("notebook_instance_accelerator_type.zig").NotebookInstanceAcceleratorType;
const DirectInternetAccess = @import("direct_internet_access.zig").DirectInternetAccess;
const InstanceMetadataServiceConfiguration = @import("instance_metadata_service_configuration.zig").InstanceMetadataServiceConfiguration;
const InstanceType = @import("instance_type.zig").InstanceType;
const IPAddressType = @import("ip_address_type.zig").IPAddressType;
const NotebookInstanceStatus = @import("notebook_instance_status.zig").NotebookInstanceStatus;
const RootAccess = @import("root_access.zig").RootAccess;

pub const DescribeNotebookInstanceInput = struct {
    /// The name of the notebook instance that you want information about.
    notebook_instance_name: []const u8,

    pub const json_field_names = .{
        .notebook_instance_name = "NotebookInstanceName",
    };
};

pub const DescribeNotebookInstanceOutput = struct {
    /// This parameter is no longer supported. Elastic Inference (EI) is no longer
    /// available.
    ///
    /// This parameter was used to specify a list of the EI instance types
    /// associated with this notebook instance.
    accelerator_types: ?[]const NotebookInstanceAcceleratorType = null,

    /// An array of up to three Git repositories associated with the notebook
    /// instance. These can be either the names of Git repositories stored as
    /// resources in your account, or the URL of Git repositories in [Amazon Web
    /// Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository. These repositories are cloned at the same level as the default repository of your notebook instance. For more information, see [Associating Git Repositories with SageMaker AI Notebook Instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html).
    additional_code_repositories: ?[]const []const u8 = null,

    /// A timestamp. Use this parameter to return the time when the notebook
    /// instance was created
    creation_time: ?i64 = null,

    /// The Git repository associated with the notebook instance as its default code
    /// repository. This can be either the name of a Git repository stored as a
    /// resource in your account, or the URL of a Git repository in [Amazon Web
    /// Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository. When you open a notebook instance, it opens in the directory that contains this repository. For more information, see [Associating Git Repositories with SageMaker AI Notebook Instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html).
    default_code_repository: ?[]const u8 = null,

    /// Describes whether SageMaker AI provides internet access to the notebook
    /// instance. If this value is set to *Disabled*, the notebook instance does not
    /// have internet access, and cannot connect to SageMaker AI training and
    /// endpoint services.
    ///
    /// For more information, see [Notebook Instances Are Internet-Enabled by
    /// Default](https://docs.aws.amazon.com/sagemaker/latest/dg/appendix-additional-considerations.html#appendix-notebook-and-internet-access).
    direct_internet_access: ?DirectInternetAccess = null,

    /// If status is `Failed`, the reason it failed.
    failure_reason: ?[]const u8 = null,

    /// Information on the IMDS configuration of the notebook instance
    instance_metadata_service_configuration: ?InstanceMetadataServiceConfiguration = null,

    /// The type of ML compute instance running on the notebook instance.
    instance_type: ?InstanceType = null,

    /// The IP address type configured for the notebook instance. Returns `ipv4` for
    /// IPv4-only connectivity or `dualstack` for both IPv4 and IPv6 connectivity.
    ip_address_type: ?IPAddressType = null,

    /// The Amazon Web Services KMS key ID SageMaker AI uses to encrypt data when
    /// storing it on the ML storage volume attached to the instance.
    kms_key_id: ?[]const u8 = null,

    /// A timestamp. Use this parameter to retrieve the time when the notebook
    /// instance was last modified.
    last_modified_time: ?i64 = null,

    /// The network interface IDs that SageMaker AI created at the time of creating
    /// the instance.
    network_interface_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the notebook instance.
    notebook_instance_arn: ?[]const u8 = null,

    /// Returns the name of a notebook instance lifecycle configuration.
    ///
    /// For information about notebook instance lifestyle configurations, see [Step
    /// 2.1: (Optional) Customize a Notebook
    /// Instance](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html)
    notebook_instance_lifecycle_config_name: ?[]const u8 = null,

    /// The name of the SageMaker AI notebook instance.
    notebook_instance_name: ?[]const u8 = null,

    /// The status of the notebook instance.
    notebook_instance_status: ?NotebookInstanceStatus = null,

    /// The platform identifier of the notebook instance runtime environment.
    platform_identifier: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role associated with the instance.
    role_arn: ?[]const u8 = null,

    /// Whether root access is enabled or disabled for users of the notebook
    /// instance.
    ///
    /// Lifecycle configurations need root access to be able to set up a notebook
    /// instance. Because of this, lifecycle configurations associated with a
    /// notebook instance always run with root access even if you disable root
    /// access for users.
    root_access: ?RootAccess = null,

    /// The IDs of the VPC security groups.
    security_groups: ?[]const []const u8 = null,

    /// The ID of the VPC subnet.
    subnet_id: ?[]const u8 = null,

    /// The URL that you use to connect to the Jupyter notebook that is running in
    /// your notebook instance.
    url: ?[]const u8 = null,

    /// The size, in GB, of the ML storage volume attached to the notebook instance.
    volume_size_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .accelerator_types = "AcceleratorTypes",
        .additional_code_repositories = "AdditionalCodeRepositories",
        .creation_time = "CreationTime",
        .default_code_repository = "DefaultCodeRepository",
        .direct_internet_access = "DirectInternetAccess",
        .failure_reason = "FailureReason",
        .instance_metadata_service_configuration = "InstanceMetadataServiceConfiguration",
        .instance_type = "InstanceType",
        .ip_address_type = "IpAddressType",
        .kms_key_id = "KmsKeyId",
        .last_modified_time = "LastModifiedTime",
        .network_interface_id = "NetworkInterfaceId",
        .notebook_instance_arn = "NotebookInstanceArn",
        .notebook_instance_lifecycle_config_name = "NotebookInstanceLifecycleConfigName",
        .notebook_instance_name = "NotebookInstanceName",
        .notebook_instance_status = "NotebookInstanceStatus",
        .platform_identifier = "PlatformIdentifier",
        .role_arn = "RoleArn",
        .root_access = "RootAccess",
        .security_groups = "SecurityGroups",
        .subnet_id = "SubnetId",
        .url = "Url",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeNotebookInstanceInput, options: Options) !DescribeNotebookInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeNotebookInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeNotebookInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeNotebookInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeNotebookInstanceOutput, body, allocator);
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
