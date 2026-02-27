const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Application = @import("application.zig").Application;
const WorkspaceImageIngestionProcess = @import("workspace_image_ingestion_process.zig").WorkspaceImageIngestionProcess;
const Tag = @import("tag.zig").Tag;

pub const ImportWorkspaceImageInput = struct {
    /// If specified, the version of Microsoft Office to subscribe to. Valid only
    /// for Windows 10 and 11
    /// BYOL images. For more information about subscribing to Office for BYOL
    /// images, see [ Bring
    /// Your Own Windows Desktop
    /// Licenses](https://docs.aws.amazon.com/workspaces/latest/adminguide/byol-windows-images.html).
    ///
    /// * Although this parameter is an array, only one item is allowed at this
    /// time.
    ///
    /// * During the image import process, non-GPU DCV (formerly WSP) WorkSpaces
    ///   with Windows 11 support
    /// only `Microsoft_Office_2019`. GPU DCV (formerly WSP) WorkSpaces with Windows
    /// 11 do not
    /// support Office installation.
    applications: ?[]const Application = null,

    /// The identifier of the EC2 image.
    ec_2_image_id: []const u8,

    /// The description of the WorkSpace image.
    image_description: []const u8,

    /// The name of the WorkSpace image.
    image_name: []const u8,

    /// The ingestion process to be used when importing the image, depending on
    /// which protocol
    /// you want to use for your BYOL Workspace image, either PCoIP, WSP, or
    /// bring your own protocol (BYOP). To use DCV, specify a value that ends in
    /// `_WSP`. To use PCoIP, specify a value that does not end in `_WSP`.
    /// To use BYOP, specify a value that ends in `_BYOP`.
    ///
    /// For non-GPU-enabled bundles (bundles other than Graphics or GraphicsPro),
    /// specify
    /// `BYOL_REGULAR`, `BYOL_REGULAR_WSP`, or `BYOL_REGULAR_BYOP`,
    /// depending on the protocol.
    ///
    /// The `BYOL_REGULAR_BYOP` and `BYOL_GRAPHICS_G4DN_BYOP` values
    /// are only supported by Amazon WorkSpaces Core. Contact your account team to
    /// be
    /// allow-listed to use these values. For more information, see [Amazon
    /// WorkSpaces Core](http://aws.amazon.com/workspaces/core/).
    ingestion_process: WorkspaceImageIngestionProcess,

    /// The tags. Each WorkSpaces resource can have a maximum of 50 tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .applications = "Applications",
        .ec_2_image_id = "Ec2ImageId",
        .image_description = "ImageDescription",
        .image_name = "ImageName",
        .ingestion_process = "IngestionProcess",
        .tags = "Tags",
    };
};

pub const ImportWorkspaceImageOutput = struct {
    /// The identifier of the WorkSpace image.
    image_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_id = "ImageId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportWorkspaceImageInput, options: Options) !ImportWorkspaceImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "workspaces");

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

fn serializeRequest(alloc: std.mem.Allocator, input: ImportWorkspaceImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "WorkspacesService.ImportWorkspaceImage");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ImportWorkspaceImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportWorkspaceImageOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ApplicationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .application_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ComputeNotCompatibleException")) {
        return .{ .arena = arena, .kind = .{ .compute_not_compatible_exception = .{
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
    if (std.mem.eql(u8, error_code, "IncompatibleApplicationsException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_applications_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValuesException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_values_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperatingSystemNotCompatibleException")) {
        return .{ .arena = arena, .kind = .{ .operating_system_not_compatible_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .operation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_supported_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceAssociatedException")) {
        return .{ .arena = arena, .kind = .{ .resource_associated_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceCreationFailedException")) {
        return .{ .arena = arena, .kind = .{ .resource_creation_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedNetworkConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_network_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedWorkspaceConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_workspace_configuration_exception = .{
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
    if (std.mem.eql(u8, error_code, "WorkspacesDefaultRoleNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .workspaces_default_role_not_found_exception = .{
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
