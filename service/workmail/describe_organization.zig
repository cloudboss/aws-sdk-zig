const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const DescribeOrganizationInput = struct {
    /// The identifier for the organization to be described.
    organization_id: []const u8,

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
    };
};

pub const DescribeOrganizationOutput = struct {
    /// The alias for an organization.
    alias: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the organization.
    arn: ?[]const u8 = null,

    /// The date at which the organization became usable in the WorkMail context, in
    /// UNIX epoch
    /// time format.
    completed_date: ?i64 = null,

    /// The default mail domain associated with the organization.
    default_mail_domain: ?[]const u8 = null,

    /// The identifier for the directory associated with an WorkMail organization.
    directory_id: ?[]const u8 = null,

    /// The type of directory associated with the WorkMail organization.
    directory_type: ?[]const u8 = null,

    /// (Optional) The error message indicating if unexpected behavior was
    /// encountered with
    /// regards to the organization.
    error_message: ?[]const u8 = null,

    /// Indicates if interoperability is enabled for this organization.
    interoperability_enabled: ?bool = null,

    /// The user ID of the migration admin if migration is enabled for the
    /// organization.
    migration_admin: ?[]const u8 = null,

    /// The identifier of an organization.
    organization_id: ?[]const u8 = null,

    /// The state of an organization.
    state: ?[]const u8 = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .arn = "ARN",
        .completed_date = "CompletedDate",
        .default_mail_domain = "DefaultMailDomain",
        .directory_id = "DirectoryId",
        .directory_type = "DirectoryType",
        .error_message = "ErrorMessage",
        .interoperability_enabled = "InteroperabilityEnabled",
        .migration_admin = "MigrationAdmin",
        .organization_id = "OrganizationId",
        .state = "State",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOrganizationInput, options: Options) !DescribeOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "workmail");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workmail", "WorkMail", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.DescribeOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeOrganizationOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "DirectoryInUseException")) {
        return .{ .arena = arena, .kind = .{ .directory_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DirectoryServiceAuthenticationFailedException")) {
        return .{ .arena = arena, .kind = .{ .directory_service_authentication_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "EmailAddressInUseException")) {
        return .{ .arena = arena, .kind = .{ .email_address_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityAlreadyRegisteredException")) {
        return .{ .arena = arena, .kind = .{ .entity_already_registered_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .entity_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntityStateException")) {
        return .{ .arena = arena, .kind = .{ .entity_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCustomSesConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_custom_ses_configuration_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MailDomainInUseException")) {
        return .{ .arena = arena, .kind = .{ .mail_domain_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MailDomainNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .mail_domain_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MailDomainStateException")) {
        return .{ .arena = arena, .kind = .{ .mail_domain_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NameAvailabilityException")) {
        return .{ .arena = arena, .kind = .{ .name_availability_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .organization_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationStateException")) {
        return .{ .arena = arena, .kind = .{ .organization_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReservedNameException")) {
        return .{ .arena = arena, .kind = .{ .reserved_name_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
