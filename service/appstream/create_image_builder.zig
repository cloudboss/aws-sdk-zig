const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const DomainJoinInfo = @import("domain_join_info.zig").DomainJoinInfo;
const VolumeConfig = @import("volume_config.zig").VolumeConfig;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const ImageBuilder = @import("image_builder.zig").ImageBuilder;

pub const CreateImageBuilderInput = struct {
    /// The list of interface VPC endpoint (interface endpoint) objects.
    /// Administrators can connect to the image builder only through the specified
    /// endpoints.
    access_endpoints: ?[]const AccessEndpoint = null,

    /// The version of the WorkSpaces Applications agent to use for this image
    /// builder. To use the latest version of the WorkSpaces Applications agent,
    /// specify [LATEST].
    appstream_agent_version: ?[]const u8 = null,

    /// The description to display.
    description: ?[]const u8 = null,

    /// The image builder name to display.
    display_name: ?[]const u8 = null,

    /// The name of the directory and organizational unit (OU) to use to join the
    /// image builder to a Microsoft Active Directory domain.
    domain_join_info: ?DomainJoinInfo = null,

    /// Enables or disables default internet access for the image builder.
    enable_default_internet_access: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role to apply to the image
    /// builder. To assume a role, the image builder calls the AWS Security Token
    /// Service (STS) `AssumeRole` API operation and passes the ARN of the role to
    /// use. The operation creates a new session with temporary credentials.
    /// WorkSpaces Applications retrieves the temporary credentials and creates the
    /// **appstream_machine_role** credential profile on the instance.
    ///
    /// For more information, see [Using an IAM Role to Grant Permissions to
    /// Applications and Scripts Running on WorkSpaces Applications Streaming
    /// Instances](https://docs.aws.amazon.com/appstream2/latest/developerguide/using-iam-roles-to-grant-permissions-to-applications-scripts-streaming-instances.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    iam_role_arn: ?[]const u8 = null,

    /// The ARN of the public, private, or shared image to use.
    image_arn: ?[]const u8 = null,

    /// The name of the image used to create the image builder.
    image_name: ?[]const u8 = null,

    /// The instance type to use when launching the image builder. The following
    /// instance types are available:
    ///
    /// * stream.standard.small
    ///
    /// * stream.standard.medium
    ///
    /// * stream.standard.large
    ///
    /// * stream.compute.large
    ///
    /// * stream.compute.xlarge
    ///
    /// * stream.compute.2xlarge
    ///
    /// * stream.compute.4xlarge
    ///
    /// * stream.compute.8xlarge
    ///
    /// * stream.memory.large
    ///
    /// * stream.memory.xlarge
    ///
    /// * stream.memory.2xlarge
    ///
    /// * stream.memory.4xlarge
    ///
    /// * stream.memory.8xlarge
    ///
    /// * stream.memory.z1d.large
    ///
    /// * stream.memory.z1d.xlarge
    ///
    /// * stream.memory.z1d.2xlarge
    ///
    /// * stream.memory.z1d.3xlarge
    ///
    /// * stream.memory.z1d.6xlarge
    ///
    /// * stream.memory.z1d.12xlarge
    ///
    /// * stream.graphics.g4dn.xlarge
    ///
    /// * stream.graphics.g4dn.2xlarge
    ///
    /// * stream.graphics.g4dn.4xlarge
    ///
    /// * stream.graphics.g4dn.8xlarge
    ///
    /// * stream.graphics.g4dn.12xlarge
    ///
    /// * stream.graphics.g4dn.16xlarge
    ///
    /// * stream.graphics.g5.xlarge
    ///
    /// * stream.graphics.g5.2xlarge
    ///
    /// * stream.graphics.g5.4xlarge
    ///
    /// * stream.graphics.g5.8xlarge
    ///
    /// * stream.graphics.g5.16xlarge
    ///
    /// * stream.graphics.g5.12xlarge
    ///
    /// * stream.graphics.g5.24xlarge
    ///
    /// * stream.graphics.g6.xlarge
    ///
    /// * stream.graphics.g6.2xlarge
    ///
    /// * stream.graphics.g6.4xlarge
    ///
    /// * stream.graphics.g6.8xlarge
    ///
    /// * stream.graphics.g6.16xlarge
    ///
    /// * stream.graphics.g6.12xlarge
    ///
    /// * stream.graphics.g6.24xlarge
    ///
    /// * stream.graphics.gr6.4xlarge
    ///
    /// * stream.graphics.gr6.8xlarge
    ///
    /// * stream.graphics.g6f.large
    ///
    /// * stream.graphics.g6f.xlarge
    ///
    /// * stream.graphics.g6f.2xlarge
    ///
    /// * stream.graphics.g6f.4xlarge
    ///
    /// * stream.graphics.gr6f.4xlarge
    instance_type: []const u8,

    /// A unique name for the image builder.
    name: []const u8,

    /// The configuration for the root volume of the image builder. Use this to
    /// customize storage capacity from 200 GB up to 500 GB based on your
    /// application installation requirements.
    root_volume_config: ?VolumeConfig = null,

    /// The list of license included applications to install on the image builder
    /// during creation.
    ///
    /// Possible values include the following:
    ///
    /// * Microsoft_Office_2021_LTSC_Professional_Plus_32Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Professional_Plus_64Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Professional_Plus_32Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Professional_Plus_64Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Professional_32Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Professional_64Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Professional_32Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Professional_64Bit
    ///
    /// * Microsoft_Project_2021_Professional_32Bit
    ///
    /// * Microsoft_Project_2021_Professional_64Bit
    ///
    /// * Microsoft_Project_2024_Professional_32Bit
    ///
    /// * Microsoft_Project_2024_Professional_64Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Project_2021_Standard_32Bit
    ///
    /// * Microsoft_Project_2021_Standard_64Bit
    ///
    /// * Microsoft_Project_2024_Standard_32Bit
    ///
    /// * Microsoft_Project_2024_Standard_64Bit
    softwares_to_install: ?[]const []const u8 = null,

    /// The list of license included applications to uninstall from the image
    /// builder during creation.
    ///
    /// Possible values include the following:
    ///
    /// * Microsoft_Office_2021_LTSC_Professional_Plus_32Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Professional_Plus_64Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Professional_Plus_32Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Professional_Plus_64Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Professional_32Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Professional_64Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Professional_32Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Professional_64Bit
    ///
    /// * Microsoft_Project_2021_Professional_32Bit
    ///
    /// * Microsoft_Project_2021_Professional_64Bit
    ///
    /// * Microsoft_Project_2024_Professional_32Bit
    ///
    /// * Microsoft_Project_2024_Professional_64Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Office_2021_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Office_2024_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Visio_2021_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Standard_32Bit
    ///
    /// * Microsoft_Visio_2024_LTSC_Standard_64Bit
    ///
    /// * Microsoft_Project_2021_Standard_32Bit
    ///
    /// * Microsoft_Project_2021_Standard_64Bit
    ///
    /// * Microsoft_Project_2024_Standard_32Bit
    ///
    /// * Microsoft_Project_2024_Standard_64Bit
    softwares_to_uninstall: ?[]const []const u8 = null,

    /// The tags to associate with the image builder. A tag is a key-value pair, and
    /// the value is optional. For example, Environment=Test. If you do not specify
    /// a value, Environment=.
    ///
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in UTF-8, and the following special characters:
    ///
    /// _ . : / = + \ - @
    ///
    /// If you do not specify a value, the value is set to an empty string.
    ///
    /// For more information about tags, see [Tagging Your
    /// Resources](https://docs.aws.amazon.com/appstream2/latest/developerguide/tagging-basic.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The VPC configuration for the image builder. You can specify only one
    /// subnet.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .appstream_agent_version = "AppstreamAgentVersion",
        .description = "Description",
        .display_name = "DisplayName",
        .domain_join_info = "DomainJoinInfo",
        .enable_default_internet_access = "EnableDefaultInternetAccess",
        .iam_role_arn = "IamRoleArn",
        .image_arn = "ImageArn",
        .image_name = "ImageName",
        .instance_type = "InstanceType",
        .name = "Name",
        .root_volume_config = "RootVolumeConfig",
        .softwares_to_install = "SoftwaresToInstall",
        .softwares_to_uninstall = "SoftwaresToUninstall",
        .tags = "Tags",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateImageBuilderOutput = struct {
    /// Information about the image builder.
    image_builder: ?ImageBuilder = null,

    pub const json_field_names = .{
        .image_builder = "ImageBuilder",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateImageBuilderInput, options: Options) !CreateImageBuilderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appstream");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateImageBuilderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream", "AppStream", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateImageBuilder");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateImageBuilderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateImageBuilderOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DryRunOperationException")) {
        return .{ .arena = arena, .kind = .{ .dry_run_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntitlementAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .entitlement_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntitlementNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .entitlement_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleImageException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_image_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAccountStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_account_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRoleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_role_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .request_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotAvailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_available_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
