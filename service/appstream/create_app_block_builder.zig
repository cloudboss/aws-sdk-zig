const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessEndpoint = @import("access_endpoint.zig").AccessEndpoint;
const AppBlockBuilderPlatformType = @import("app_block_builder_platform_type.zig").AppBlockBuilderPlatformType;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const AppBlockBuilder = @import("app_block_builder.zig").AppBlockBuilder;

pub const CreateAppBlockBuilderInput = struct {
    /// The list of interface VPC endpoint (interface endpoint) objects.
    /// Administrators can connect to the app block builder only through the
    /// specified endpoints.
    access_endpoints: ?[]const AccessEndpoint = null,

    /// The description of the app block builder.
    description: ?[]const u8 = null,

    /// The display name of the app block builder.
    display_name: ?[]const u8 = null,

    /// Enables or disables default internet access for the app block builder.
    enable_default_internet_access: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role to apply to the app block
    /// builder. To
    /// assume a role, the app block builder calls the AWS Security Token Service
    /// (STS)
    /// `AssumeRole` API operation and passes the ARN of the role to use. The
    /// operation creates a new session with temporary credentials. WorkSpaces
    /// Applications retrieves the
    /// temporary credentials and creates the **appstream_machine_role** credential
    /// profile on the instance.
    ///
    /// For more information, see [Using an IAM Role to Grant Permissions to
    /// Applications and Scripts Running on WorkSpaces Applications Streaming
    /// Instances](https://docs.aws.amazon.com/appstream2/latest/developerguide/using-iam-roles-to-grant-permissions-to-applications-scripts-streaming-instances.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    iam_role_arn: ?[]const u8 = null,

    /// The instance type to use when launching the app block builder. The following
    /// instance
    /// types are available:
    ///
    /// * stream.standard.small
    ///
    /// * stream.standard.medium
    ///
    /// * stream.standard.large
    ///
    /// * stream.standard.xlarge
    ///
    /// * stream.standard.2xlarge
    instance_type: []const u8,

    /// The unique name for the app block builder.
    name: []const u8,

    /// The platform of the app block builder.
    ///
    /// `WINDOWS_SERVER_2019` is the only valid value.
    platform: AppBlockBuilderPlatformType,

    /// The tags to associate with the app block builder. A tag is a key-value pair,
    /// and the
    /// value is optional. For example, Environment=Test. If you do not specify a
    /// value,
    /// Environment=.
    ///
    /// If you do not specify a value, the value is set to an empty string.
    ///
    /// Generally allowed characters are: letters, numbers, and spaces representable
    /// in UTF-8, and the following special characters:
    ///
    /// _ . : / = + \ - @
    ///
    /// For more information, see [Tagging Your
    /// Resources](https://docs.aws.amazon.com/appstream2/latest/developerguide/tagging-basic.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The VPC configuration for the app block builder.
    ///
    /// App block builders require that you specify at least two subnets in
    /// different availability
    /// zones.
    vpc_config: VpcConfig,

    pub const json_field_names = .{
        .access_endpoints = "AccessEndpoints",
        .description = "Description",
        .display_name = "DisplayName",
        .enable_default_internet_access = "EnableDefaultInternetAccess",
        .iam_role_arn = "IamRoleArn",
        .instance_type = "InstanceType",
        .name = "Name",
        .platform = "Platform",
        .tags = "Tags",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateAppBlockBuilderOutput = struct {
    app_block_builder: ?AppBlockBuilder = null,

    pub const json_field_names = .{
        .app_block_builder = "AppBlockBuilder",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAppBlockBuilderInput, options: Options) !CreateAppBlockBuilderOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAppBlockBuilderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream", "AppStream", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "PhotonAdminProxyService.CreateAppBlockBuilder");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAppBlockBuilderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAppBlockBuilderOutput, body, alloc);
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
