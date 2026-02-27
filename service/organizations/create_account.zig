const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IAMUserAccessToBilling = @import("iam_user_access_to_billing.zig").IAMUserAccessToBilling;
const Tag = @import("tag.zig").Tag;
const CreateAccountStatus = @import("create_account_status.zig").CreateAccountStatus;

pub const CreateAccountInput = struct {
    /// The friendly name of the member account.
    account_name: []const u8,

    /// The email address of the owner to assign to the new member account. This
    /// email address
    /// must not already be associated with another Amazon Web Services account. You
    /// must use a valid email
    /// address to complete account creation.
    ///
    /// The rules for a valid email address:
    ///
    /// * The address must be a minimum of 6 and a maximum of 64 characters long.
    ///
    /// * All characters must be 7-bit ASCII characters.
    ///
    /// * There must be one and only one @ symbol, which separates the local name
    ///   from
    /// the domain name.
    ///
    /// * The local name can't contain any of the following characters:
    ///
    /// whitespace, " ' ( ) [ ] : ; , \ | % &
    ///
    /// * The local name can't begin with a dot (.)
    ///
    /// * The domain name can consist of only the characters [a-z],[A-Z],[0-9],
    ///   hyphen
    /// (-), or dot (.)
    ///
    /// * The domain name can't begin or end with a hyphen (-) or dot (.)
    ///
    /// * The domain name must contain at least one dot
    ///
    /// You can't access the root user of the account or remove an account that was
    /// created
    /// with an invalid email address.
    email: []const u8,

    /// If set to `ALLOW`, the new account enables IAM users to access account
    /// billing information *if* they have the required permissions. If set
    /// to `DENY`, only the root user of the new account can access account billing
    /// information. For more information, see [About IAM
    /// access to the Billing and Cost Management
    /// console](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/grantaccess.html#ControllingAccessWebsite-Activate) in the
    /// *Amazon Web Services Billing and Cost Management User Guide*.
    ///
    /// If you don't specify this parameter, the value defaults to `ALLOW`, and
    /// IAM users and roles with the required permissions can access billing
    /// information for
    /// the new account.
    iam_user_access_to_billing: ?IAMUserAccessToBilling = null,

    /// The name of an IAM role that Organizations automatically preconfigures in
    /// the new member
    /// account. This role trusts the management account, allowing users in the
    /// management
    /// account to assume the role, as permitted by the management account
    /// administrator. The
    /// role has administrator permissions in the new member account.
    ///
    /// If you don't specify this parameter, the role name defaults to
    /// `OrganizationAccountAccessRole`.
    ///
    /// For more information about how to use this role to access the member
    /// account, see the
    /// following links:
    ///
    /// * [Creating the OrganizationAccountAccessRole in an invited member
    /// account](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_access.html#orgs_manage_accounts_create-cross-account-role) in the *Organizations User Guide*
    ///
    /// * Steps 2 and 3 in [IAM Tutorial:
    /// Delegate access across Amazon Web Services accounts using IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html) in the
    /// *IAM User Guide*
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) that
    /// is used to validate this parameter. The pattern can include uppercase
    /// letters, lowercase letters, digits with no spaces, and any of the following
    /// characters: =,.@-
    role_name: ?[]const u8 = null,

    /// A list of tags that you want to attach to the newly created account. For
    /// each tag in
    /// the list, you must specify both a tag key and a value. You can set the value
    /// to an empty
    /// string, but you can't set it to `null`. For more information about tagging,
    /// see [Tagging Organizations
    /// resources](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tagging.html) in the Organizations User Guide.
    ///
    /// If any one of the tags is not valid or if you exceed the maximum allowed
    /// number of
    /// tags for an account, then the entire request fails and the account is not
    /// created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .account_name = "AccountName",
        .email = "Email",
        .iam_user_access_to_billing = "IamUserAccessToBilling",
        .role_name = "RoleName",
        .tags = "Tags",
    };
};

pub const CreateAccountOutput = struct {
    /// A structure that contains details about the request to create an account.
    /// This
    /// response structure might not be fully populated when you first receive it
    /// because
    /// account creation is an asynchronous process. You can pass the returned
    /// `CreateAccountStatus` ID as a parameter to DescribeCreateAccountStatus to
    /// get status about the progress of the
    /// request at later times. You can also check the CloudTrail log for the
    /// `CreateAccountResult` event. For more information, see [Logging and
    /// monitoring in
    /// Organizations](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_security_incident-response.html) in the
    /// *Organizations User Guide*.
    create_account_status: ?CreateAccountStatus = null,

    pub const json_field_names = .{
        .create_account_status = "CreateAccountStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccountInput, options: Options) !CreateAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "organizations");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSOrganizationsV20161128.CreateAccount");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAccountOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "AccessDeniedForDependencyException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_for_dependency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountAlreadyClosedException")) {
        return .{ .arena = arena, .kind = .{ .account_already_closed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountAlreadyRegisteredException")) {
        return .{ .arena = arena, .kind = .{ .account_already_registered_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .account_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountNotRegisteredException")) {
        return .{ .arena = arena, .kind = .{ .account_not_registered_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountOwnerNotVerifiedException")) {
        return .{ .arena = arena, .kind = .{ .account_owner_not_verified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyInOrganizationException")) {
        return .{ .arena = arena, .kind = .{ .already_in_organization_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AWSOrganizationsNotInUseException")) {
        return .{ .arena = arena, .kind = .{ .aws_organizations_not_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ChildNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .child_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
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
    if (std.mem.eql(u8, error_code, "ConstraintViolationException")) {
        return .{ .arena = arena, .kind = .{ .constraint_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CreateAccountStatusNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .create_account_status_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DestinationParentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .destination_parent_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateAccountException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateHandshakeException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_handshake_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateOrganizationalUnitException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_organizational_unit_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicatePolicyAttachmentException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_policy_attachment_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicatePolicyException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EffectivePolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .effective_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FinalizingOrganizationException")) {
        return .{ .arena = arena, .kind = .{ .finalizing_organization_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HandshakeAlreadyInStateException")) {
        return .{ .arena = arena, .kind = .{ .handshake_already_in_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HandshakeConstraintViolationException")) {
        return .{ .arena = arena, .kind = .{ .handshake_constraint_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HandshakeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .handshake_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidHandshakeTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_handshake_transition_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResponsibilityTransferTransitionException")) {
        return .{ .arena = arena, .kind = .{ .invalid_responsibility_transfer_transition_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MasterCannotLeaveOrganizationException")) {
        return .{ .arena = arena, .kind = .{ .master_cannot_leave_organization_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotEmptyException")) {
        return .{ .arena = arena, .kind = .{ .organization_not_empty_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationalUnitNotEmptyException")) {
        return .{ .arena = arena, .kind = .{ .organizational_unit_not_empty_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationalUnitNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .organizational_unit_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ParentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .parent_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyChangesInProgressException")) {
        return .{ .arena = arena, .kind = .{ .policy_changes_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyInUseException")) {
        return .{ .arena = arena, .kind = .{ .policy_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotAttachedException")) {
        return .{ .arena = arena, .kind = .{ .policy_not_attached_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyTypeAlreadyEnabledException")) {
        return .{ .arena = arena, .kind = .{ .policy_type_already_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyTypeNotAvailableForOrganizationException")) {
        return .{ .arena = arena, .kind = .{ .policy_type_not_available_for_organization_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyTypeNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .policy_type_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResponsibilityTransferAlreadyInStatusException")) {
        return .{ .arena = arena, .kind = .{ .responsibility_transfer_already_in_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResponsibilityTransferNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .responsibility_transfer_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RootNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .root_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "SourceParentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .source_parent_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .target_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAPIEndpointException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_api_endpoint_exception = .{
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
