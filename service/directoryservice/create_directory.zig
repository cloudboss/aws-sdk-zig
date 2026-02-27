const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NetworkType = @import("network_type.zig").NetworkType;
const DirectorySize = @import("directory_size.zig").DirectorySize;
const Tag = @import("tag.zig").Tag;
const DirectoryVpcSettings = @import("directory_vpc_settings.zig").DirectoryVpcSettings;

pub const CreateDirectoryInput = struct {
    /// A description for the directory.
    description: ?[]const u8 = null,

    /// The fully qualified name for the directory, such as `corp.example.com`.
    name: []const u8,

    /// The network type for your directory. Simple AD supports IPv4 and Dual-stack
    /// only.
    network_type: ?NetworkType = null,

    /// The password for the directory administrator. The directory creation process
    /// creates a
    /// directory administrator account with the user name `Administrator` and this
    /// password.
    ///
    /// If you need to change the password for the administrator account, you can
    /// use the ResetUserPassword API call.
    ///
    /// The regex pattern for this string is made up of the following conditions:
    ///
    /// * Length (?=^.{8,64}$) – Must be between 8 and 64 characters
    ///
    /// AND any 3 of the following password complexity rules required by Active
    /// Directory:
    ///
    /// * Numbers and upper case and lowercase (?=.*\d)(?=.*[A-Z])(?=.*[a-z])
    ///
    /// * Numbers and special characters and lower case
    /// (?=.*\d)(?=.*[^A-Za-z0-9\s])(?=.*[a-z])
    ///
    /// * Special characters and upper case and lower case
    /// (?=.*[^A-Za-z0-9\s])(?=.*[A-Z])(?=.*[a-z])
    ///
    /// * Numbers and upper case and special characters
    /// (?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9\s])
    ///
    /// For additional information about how Active Directory passwords are
    /// enforced, see [Password must meet complexity
    /// requirements](https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements) on the Microsoft website.
    password: []const u8,

    /// The NetBIOS name of the directory, such as `CORP`.
    short_name: ?[]const u8 = null,

    /// The size of the directory.
    size: DirectorySize,

    /// The tags to be assigned to the Simple AD directory.
    tags: ?[]const Tag = null,

    /// A DirectoryVpcSettings object that contains additional information for
    /// the operation.
    vpc_settings: ?DirectoryVpcSettings = null,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .network_type = "NetworkType",
        .password = "Password",
        .short_name = "ShortName",
        .size = "Size",
        .tags = "Tags",
        .vpc_settings = "VpcSettings",
    };
};

pub const CreateDirectoryOutput = struct {
    /// The identifier of the directory that was created.
    directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDirectoryInput, options: Options) !CreateDirectoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "directoryservice");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDirectoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directoryservice", "Directory Service", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "DirectoryService_20150416.CreateDirectory");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDirectoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDirectoryOutput, body, alloc);
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
