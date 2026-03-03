const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NotebookInstanceAcceleratorType = @import("notebook_instance_accelerator_type.zig").NotebookInstanceAcceleratorType;
const InstanceMetadataServiceConfiguration = @import("instance_metadata_service_configuration.zig").InstanceMetadataServiceConfiguration;
const InstanceType = @import("instance_type.zig").InstanceType;
const IPAddressType = @import("ip_address_type.zig").IPAddressType;
const RootAccess = @import("root_access.zig").RootAccess;

pub const UpdateNotebookInstanceInput = struct {
    /// This parameter is no longer supported. Elastic Inference (EI) is no longer
    /// available.
    ///
    /// This parameter was used to specify a list of the EI instance types to
    /// associate with this notebook instance.
    accelerator_types: ?[]const NotebookInstanceAcceleratorType = null,

    /// An array of up to three Git repositories to associate with the notebook
    /// instance. These can be either the names of Git repositories stored as
    /// resources in your account, or the URL of Git repositories in [Amazon Web
    /// Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository. These repositories are cloned at the same level as the default repository of your notebook instance. For more information, see [Associating Git Repositories with SageMaker AI Notebook Instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html).
    additional_code_repositories: ?[]const []const u8 = null,

    /// The Git repository to associate with the notebook instance as its default
    /// code repository. This can be either the name of a Git repository stored as a
    /// resource in your account, or the URL of a Git repository in [Amazon Web
    /// Services
    /// CodeCommit](https://docs.aws.amazon.com/codecommit/latest/userguide/welcome.html) or in any other Git repository. When you open a notebook instance, it opens in the directory that contains this repository. For more information, see [Associating Git Repositories with SageMaker AI Notebook Instances](https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-repo.html).
    default_code_repository: ?[]const u8 = null,

    /// This parameter is no longer supported. Elastic Inference (EI) is no longer
    /// available.
    ///
    /// This parameter was used to specify a list of the EI instance types to remove
    /// from this notebook instance.
    disassociate_accelerator_types: ?bool = null,

    /// A list of names or URLs of the default Git repositories to remove from this
    /// notebook instance. This operation is idempotent. If you specify a Git
    /// repository that is not associated with the notebook instance when you call
    /// this method, it does not throw an error.
    disassociate_additional_code_repositories: ?bool = null,

    /// The name or URL of the default Git repository to remove from this notebook
    /// instance. This operation is idempotent. If you specify a Git repository that
    /// is not associated with the notebook instance when you call this method, it
    /// does not throw an error.
    disassociate_default_code_repository: ?bool = null,

    /// Set to `true` to remove the notebook instance lifecycle configuration
    /// currently associated with the notebook instance. This operation is
    /// idempotent. If you specify a lifecycle configuration that is not associated
    /// with the notebook instance when you call this method, it does not throw an
    /// error.
    disassociate_lifecycle_config: ?bool = null,

    /// Information on the IMDS configuration of the notebook instance
    instance_metadata_service_configuration: ?InstanceMetadataServiceConfiguration = null,

    /// The Amazon ML compute instance type.
    instance_type: ?InstanceType = null,

    /// The IP address type for the notebook instance. Specify `ipv4` for IPv4-only
    /// connectivity or `dualstack` for both IPv4 and IPv6 connectivity. The
    /// notebook instance must be stopped before updating this setting. When you
    /// specify `dualstack`, the subnet must support IPv6 addressing.
    ip_address_type: ?IPAddressType = null,

    /// The name of a lifecycle configuration to associate with the notebook
    /// instance. For information about lifestyle configurations, see [Step 2.1:
    /// (Optional) Customize a Notebook
    /// Instance](https://docs.aws.amazon.com/sagemaker/latest/dg/notebook-lifecycle-config.html).
    lifecycle_config_name: ?[]const u8 = null,

    /// The name of the notebook instance to update.
    notebook_instance_name: []const u8,

    /// The platform identifier of the notebook instance runtime environment.
    platform_identifier: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that SageMaker AI can assume
    /// to access the notebook instance. For more information, see [SageMaker AI
    /// Roles](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-roles.html).
    ///
    /// To be able to pass this role to SageMaker AI, the caller of this API must
    /// have the `iam:PassRole` permission.
    role_arn: ?[]const u8 = null,

    /// Whether root access is enabled or disabled for users of the notebook
    /// instance. The default value is `Enabled`.
    ///
    /// If you set this to `Disabled`, users don't have root access on the notebook
    /// instance, but lifecycle configuration scripts still run with root
    /// permissions.
    root_access: ?RootAccess = null,

    /// The size, in GB, of the ML storage volume to attach to the notebook
    /// instance. The default value is 5 GB. ML storage volumes are encrypted, so
    /// SageMaker AI can't determine the amount of available free space on the
    /// volume. Because of this, you can increase the volume size when you update a
    /// notebook instance, but you can't decrease the volume size. If you want to
    /// decrease the size of the ML storage volume in use, create a new notebook
    /// instance with the desired size.
    volume_size_in_gb: ?i32 = null,

    pub const json_field_names = .{
        .accelerator_types = "AcceleratorTypes",
        .additional_code_repositories = "AdditionalCodeRepositories",
        .default_code_repository = "DefaultCodeRepository",
        .disassociate_accelerator_types = "DisassociateAcceleratorTypes",
        .disassociate_additional_code_repositories = "DisassociateAdditionalCodeRepositories",
        .disassociate_default_code_repository = "DisassociateDefaultCodeRepository",
        .disassociate_lifecycle_config = "DisassociateLifecycleConfig",
        .instance_metadata_service_configuration = "InstanceMetadataServiceConfiguration",
        .instance_type = "InstanceType",
        .ip_address_type = "IpAddressType",
        .lifecycle_config_name = "LifecycleConfigName",
        .notebook_instance_name = "NotebookInstanceName",
        .platform_identifier = "PlatformIdentifier",
        .role_arn = "RoleArn",
        .root_access = "RootAccess",
        .volume_size_in_gb = "VolumeSizeInGB",
    };
};

pub const UpdateNotebookInstanceOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNotebookInstanceInput, options: Options) !UpdateNotebookInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNotebookInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateNotebookInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNotebookInstanceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
