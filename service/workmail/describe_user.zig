const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EntityState = @import("entity_state.zig").EntityState;
const UserRole = @import("user_role.zig").UserRole;

pub const DescribeUserInput = struct {
    /// The identifier for the organization under which the user exists.
    organization_id: []const u8,

    /// The identifier for the user to be described.
    ///
    /// The identifier can be the *UserId*, *Username*, or *email*. The following
    /// identity formats are available:
    ///
    /// * User ID: 12345678-1234-1234-1234-123456789012 or
    ///   S-1-1-12-1234567890-123456789-123456789-1234
    ///
    /// * Email address: user@domain.tld
    ///
    /// * User name: user
    user_id: []const u8,

    pub const json_field_names = .{
        .organization_id = "OrganizationId",
        .user_id = "UserId",
    };
};

pub const DescribeUserOutput = struct {
    /// City where the user is located.
    city: ?[]const u8 = null,

    /// Company of the user.
    company: ?[]const u8 = null,

    /// Country where the user is located.
    country: ?[]const u8 = null,

    /// Department of the user.
    department: ?[]const u8 = null,

    /// The date and time at which the user was disabled for WorkMail usage, in UNIX
    /// epoch
    /// time format.
    disabled_date: ?i64 = null,

    /// The display name of the user.
    display_name: ?[]const u8 = null,

    /// The email of the user.
    email: ?[]const u8 = null,

    /// The date and time at which the user was enabled for WorkMailusage, in UNIX
    /// epoch
    /// time format.
    enabled_date: ?i64 = null,

    /// First name of the user.
    first_name: ?[]const u8 = null,

    /// If enabled, the user is hidden from the global address list.
    hidden_from_global_address_list: ?bool = null,

    /// Identity Store ID from the IAM Identity Center. If this parameter is empty
    /// it will be updated automatically when the user logs in for the first time to
    /// the mailbox associated with WorkMail.
    identity_provider_identity_store_id: ?[]const u8 = null,

    /// User ID from the IAM Identity Center. If this parameter is empty it will be
    /// updated automatically when the user logs in for the first time to the
    /// mailbox associated with WorkMail.
    identity_provider_user_id: ?[]const u8 = null,

    /// Initials of the user.
    initials: ?[]const u8 = null,

    /// Job title of the user.
    job_title: ?[]const u8 = null,

    /// Last name of the user.
    last_name: ?[]const u8 = null,

    /// The date when the mailbox was removed for the user.
    mailbox_deprovisioned_date: ?i64 = null,

    /// The date when the mailbox was created for the user.
    mailbox_provisioned_date: ?i64 = null,

    /// The name for the user.
    name: ?[]const u8 = null,

    /// Office where the user is located.
    office: ?[]const u8 = null,

    /// The state of a user: enabled (registered to WorkMail) or disabled
    /// (deregistered or
    /// never registered to WorkMail).
    state: ?EntityState = null,

    /// Street where the user is located.
    street: ?[]const u8 = null,

    /// User's contact number.
    telephone: ?[]const u8 = null,

    /// The identifier for the described user.
    user_id: ?[]const u8 = null,

    /// In certain cases, other entities are modeled as users. If interoperability
    /// is
    /// enabled, resources are imported into WorkMail as users. Because different
    /// WorkMail
    /// organizations rely on different directory types, administrators can
    /// distinguish between an
    /// unregistered user (account is disabled and has a user role) and the
    /// directory
    /// administrators. The values are USER, RESOURCE, SYSTEM_USER, and REMOTE_USER.
    user_role: ?UserRole = null,

    /// Zip code of the user.
    zip_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .city = "City",
        .company = "Company",
        .country = "Country",
        .department = "Department",
        .disabled_date = "DisabledDate",
        .display_name = "DisplayName",
        .email = "Email",
        .enabled_date = "EnabledDate",
        .first_name = "FirstName",
        .hidden_from_global_address_list = "HiddenFromGlobalAddressList",
        .identity_provider_identity_store_id = "IdentityProviderIdentityStoreId",
        .identity_provider_user_id = "IdentityProviderUserId",
        .initials = "Initials",
        .job_title = "JobTitle",
        .last_name = "LastName",
        .mailbox_deprovisioned_date = "MailboxDeprovisionedDate",
        .mailbox_provisioned_date = "MailboxProvisionedDate",
        .name = "Name",
        .office = "Office",
        .state = "State",
        .street = "Street",
        .telephone = "Telephone",
        .user_id = "UserId",
        .user_role = "UserRole",
        .zip_code = "ZipCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeUserInput, options: CallOptions) !DescribeUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeUserInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkMailService.DescribeUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeUserOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeUserOutput, body, allocator);
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
