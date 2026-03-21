const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DirectoryEdition = @import("directory_edition.zig").DirectoryEdition;
const NetworkType = @import("network_type.zig").NetworkType;
const Tag = @import("tag.zig").Tag;
const DirectoryVpcSettings = @import("directory_vpc_settings.zig").DirectoryVpcSettings;

pub const CreateMicrosoftADInput = struct {
    /// A description for the directory. This label will appear on the Amazon Web
    /// Services console
    /// `Directory Details` page after the directory is created.
    description: ?[]const u8 = null,

    /// Managed Microsoft AD is available in two editions: `Standard` and
    /// `Enterprise`. `Enterprise` is the default.
    edition: ?DirectoryEdition = null,

    /// The fully qualified domain name for the Managed Microsoft AD directory, such
    /// as
    /// `corp.example.com`. This name will resolve inside your VPC only. It does not
    /// need
    /// to be publicly resolvable.
    name: []const u8,

    /// The network type for your domain. The default value is `IPv4` or `IPv6`
    /// based on the provided subnet capabilities.
    network_type: ?NetworkType = null,

    /// The password for the default administrative user named `Admin`.
    ///
    /// If you need to change the password for the administrator account, you can
    /// use the ResetUserPassword API call.
    password: []const u8,

    /// The NetBIOS name for your domain, such as `CORP`. If you don't specify a
    /// NetBIOS name, it will default to the first part of your directory DNS. For
    /// example,
    /// `CORP` for the directory DNS `corp.example.com`.
    short_name: ?[]const u8 = null,

    /// The tags to be assigned to the Managed Microsoft AD directory.
    tags: ?[]const Tag = null,

    /// Contains VPC information for the CreateDirectory or CreateMicrosoftAD
    /// operation.
    vpc_settings: DirectoryVpcSettings,

    pub const json_field_names = .{
        .description = "Description",
        .edition = "Edition",
        .name = "Name",
        .network_type = "NetworkType",
        .password = "Password",
        .short_name = "ShortName",
        .tags = "Tags",
        .vpc_settings = "VpcSettings",
    };
};

pub const CreateMicrosoftADOutput = struct {
    /// The identifier of the directory that was created.
    directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMicrosoftADInput, options: CallOptions) !CreateMicrosoftADOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ds");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMicrosoftADInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.CreateMicrosoftAD");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMicrosoftADOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMicrosoftADOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ADAssessmentLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .ad_assessment_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AuthenticationFailedException")) {
        return .{ .arena = arena, .kind = .{ .authentication_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .certificate_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .certificate_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateInUseException")) {
        return .{ .arena = arena, .kind = .{ .certificate_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .certificate_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryAlreadyInRegionException")) {
        return .{ .arena = arena, .kind = .{ .directory_already_in_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryAlreadySharedException")) {
        return .{ .arena = arena, .kind = .{ .directory_already_shared_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .directory_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryInDesiredStateException")) {
        return .{ .arena = arena, .kind = .{ .directory_in_desired_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .directory_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryNotSharedException")) {
        return .{ .arena = arena, .kind = .{ .directory_not_shared_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .directory_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DisableAlreadyInProgressException")) {
        return .{ .arena = arena, .kind = .{ .disable_already_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DomainControllerLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .domain_controller_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EnableAlreadyInProgressException")) {
        return .{ .arena = arena, .kind = .{ .enable_already_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .entity_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .entity_does_not_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleSettingsException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_settings_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientPermissionsException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_permissions_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_certificate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidClientAuthStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_client_auth_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLDAPSStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_ldaps_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPasswordException")) {
        return .{ .arena = arena, .kind = .{ .invalid_password_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTargetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_target_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IpRouteLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .ip_route_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoAvailableCertificateException")) {
        return .{ .arena = arena, .kind = .{ .no_available_certificate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationsException")) {
        return .{ .arena = arena, .kind = .{ .organizations_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .region_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ShareLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .share_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SnapshotLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .snapshot_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .tag_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedSettingsException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_settings_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UserDoesNotExistException")) {
        return .{ .arena = arena, .kind = .{ .user_does_not_exist_exception = .{
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
