const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AgentSoftwareVersion = @import("agent_software_version.zig").AgentSoftwareVersion;
const ApplicationConfig = @import("application_config.zig").ApplicationConfig;
const RuntimeValidationConfig = @import("runtime_validation_config.zig").RuntimeValidationConfig;
const Image = @import("image.zig").Image;

pub const CreateImportedImageInput = struct {
    /// The version of the WorkSpaces Applications agent to use for the imported
    /// image. Choose CURRENT_LATEST to use the agent version available at the time
    /// of import, or ALWAYS_LATEST to automatically update to the latest agent
    /// version when new versions are released.
    agent_software_version: ?AgentSoftwareVersion = null,

    /// Configuration for the application catalog of the imported image. This allows
    /// you to specify applications available for streaming, including their paths,
    /// icons, and launch parameters. This field contains sensitive data.
    app_catalog_config: ?[]const ApplicationConfig = null,

    /// An optional description for the imported image. The description must match
    /// approved regex patterns and can be up to 256 characters.
    description: ?[]const u8 = null,

    /// An optional display name for the imported image. The display name must match
    /// approved regex patterns and can be up to 100 characters.
    display_name: ?[]const u8 = null,

    /// When set to true, performs validation checks without actually creating the
    /// imported image. Use this to verify your configuration before executing the
    /// actual import operation.
    dry_run: ?bool = null,

    /// The ARN of the IAM role that allows WorkSpaces Applications to access your
    /// AMI. The role must have permissions to modify image attributes and describe
    /// images, with a trust relationship allowing appstream.amazonaws.com to assume
    /// the role.
    iam_role_arn: []const u8,

    /// A unique name for the imported image. The name must be between 1 and 100
    /// characters and can contain letters, numbers, underscores, periods, and
    /// hyphens.
    name: []const u8,

    /// Configuration for runtime validation of the imported image. When specified,
    /// WorkSpaces Applications provisions an instance to test streaming
    /// functionality, which helps ensure the image is suitable for use.
    runtime_validation_config: ?RuntimeValidationConfig = null,

    /// The ID of the EC2 AMI to import. The AMI must meet specific requirements
    /// including Windows Server 2022 Full Base, UEFI boot mode, TPM 2.0 support,
    /// and proper drivers.
    source_ami_id: []const u8,

    /// The tags to apply to the imported image. Tags help you organize and manage
    /// your WorkSpaces Applications resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agent_software_version = "AgentSoftwareVersion",
        .app_catalog_config = "AppCatalogConfig",
        .description = "Description",
        .display_name = "DisplayName",
        .dry_run = "DryRun",
        .iam_role_arn = "IamRoleArn",
        .name = "Name",
        .runtime_validation_config = "RuntimeValidationConfig",
        .source_ami_id = "SourceAmiId",
        .tags = "Tags",
    };
};

pub const CreateImportedImageOutput = struct {
    image: ?Image = null,

    pub const json_field_names = .{
        .image = "Image",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateImportedImageInput, options: Options) !CreateImportedImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateImportedImageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateImportedImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateImportedImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateImportedImageOutput, body, allocator);
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
