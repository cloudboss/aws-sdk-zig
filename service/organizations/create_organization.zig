const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const OrganizationFeatureSet = @import("organization_feature_set.zig").OrganizationFeatureSet;
const Organization = @import("organization.zig").Organization;

pub const CreateOrganizationInput = struct {
    /// Specifies the feature set supported by the new organization. Each feature
    /// set supports
    /// different levels of functionality.
    ///
    /// * `CONSOLIDATED_BILLING`: All member accounts have their bills
    /// consolidated to and paid by the management account. For more information,
    /// see
    /// [Consolidated
    /// billing](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#feature-set-cb-only) in the
    /// *Organizations User Guide*.
    ///
    /// The consolidated billing feature subset isn't available for organizations in
    /// the Amazon Web Services GovCloud (US) Region.
    ///
    /// * `ALL`: In addition to all the features supported by the
    /// consolidated billing feature set, the management account can also apply any
    /// policy type to any member account in the organization. For more information,
    /// see
    /// [All
    /// features](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#feature-set-all) in the *Organizations User Guide*.
    feature_set: ?OrganizationFeatureSet = null,

    pub const json_field_names = .{
        .feature_set = "FeatureSet",
    };
};

pub const CreateOrganizationOutput = struct {
    /// A structure that contains details about the newly created organization.
    organization: ?Organization = null,

    pub const json_field_names = .{
        .organization = "Organization",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOrganizationInput, options: CallOptions) !CreateOrganizationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "organizations", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOrganizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("organizations", "Organizations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSOrganizationsV20161128.CreateOrganization");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOrganizationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateOrganizationOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccessDeniedForDependencyException")) {
        const parsed_error: ?errors.AccessDeniedForDependencyException = aws.json.parseJsonObject(errors.AccessDeniedForDependencyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_for_dependency_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountAlreadyClosedException")) {
        const parsed_error: ?errors.AccountAlreadyClosedException = aws.json.parseJsonObject(errors.AccountAlreadyClosedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_already_closed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountAlreadyRegisteredException")) {
        const parsed_error: ?errors.AccountAlreadyRegisteredException = aws.json.parseJsonObject(errors.AccountAlreadyRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_already_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountNotFoundException")) {
        const parsed_error: ?errors.AccountNotFoundException = aws.json.parseJsonObject(errors.AccountNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountNotRegisteredException")) {
        const parsed_error: ?errors.AccountNotRegisteredException = aws.json.parseJsonObject(errors.AccountNotRegisteredException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_not_registered_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountOwnerNotVerifiedException")) {
        const parsed_error: ?errors.AccountOwnerNotVerifiedException = aws.json.parseJsonObject(errors.AccountOwnerNotVerifiedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_owner_not_verified_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AlreadyInOrganizationException")) {
        const parsed_error: ?errors.AlreadyInOrganizationException = aws.json.parseJsonObject(errors.AlreadyInOrganizationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .already_in_organization_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AWSOrganizationsNotInUseException")) {
        const parsed_error: ?errors.AWSOrganizationsNotInUseException = aws.json.parseJsonObject(errors.AWSOrganizationsNotInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .aws_organizations_not_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ChildNotFoundException")) {
        const parsed_error: ?errors.ChildNotFoundException = aws.json.parseJsonObject(errors.ChildNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .child_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?errors.ConcurrentModificationException = aws.json.parseJsonObject(errors.ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConstraintViolationException")) {
        const parsed_error: ?errors.ConstraintViolationException = aws.json.parseJsonObject(errors.ConstraintViolationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .constraint_violation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "CreateAccountStatusNotFoundException")) {
        const parsed_error: ?errors.CreateAccountStatusNotFoundException = aws.json.parseJsonObject(errors.CreateAccountStatusNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .create_account_status_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DestinationParentNotFoundException")) {
        const parsed_error: ?errors.DestinationParentNotFoundException = aws.json.parseJsonObject(errors.DestinationParentNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .destination_parent_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateAccountException")) {
        const parsed_error: ?errors.DuplicateAccountException = aws.json.parseJsonObject(errors.DuplicateAccountException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_account_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateHandshakeException")) {
        const parsed_error: ?errors.DuplicateHandshakeException = aws.json.parseJsonObject(errors.DuplicateHandshakeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_handshake_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateOrganizationalUnitException")) {
        const parsed_error: ?errors.DuplicateOrganizationalUnitException = aws.json.parseJsonObject(errors.DuplicateOrganizationalUnitException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_organizational_unit_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicatePolicyAttachmentException")) {
        const parsed_error: ?errors.DuplicatePolicyAttachmentException = aws.json.parseJsonObject(errors.DuplicatePolicyAttachmentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_policy_attachment_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicatePolicyException")) {
        const parsed_error: ?errors.DuplicatePolicyException = aws.json.parseJsonObject(errors.DuplicatePolicyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_policy_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "EffectivePolicyNotFoundException")) {
        const parsed_error: ?errors.EffectivePolicyNotFoundException = aws.json.parseJsonObject(errors.EffectivePolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .effective_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FinalizingOrganizationException")) {
        const parsed_error: ?errors.FinalizingOrganizationException = aws.json.parseJsonObject(errors.FinalizingOrganizationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .finalizing_organization_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HandshakeAlreadyInStateException")) {
        const parsed_error: ?errors.HandshakeAlreadyInStateException = aws.json.parseJsonObject(errors.HandshakeAlreadyInStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .handshake_already_in_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HandshakeConstraintViolationException")) {
        const parsed_error: ?errors.HandshakeConstraintViolationException = aws.json.parseJsonObject(errors.HandshakeConstraintViolationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .handshake_constraint_violation_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "HandshakeNotFoundException")) {
        const parsed_error: ?errors.HandshakeNotFoundException = aws.json.parseJsonObject(errors.HandshakeNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .handshake_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidHandshakeTransitionException")) {
        const parsed_error: ?errors.InvalidHandshakeTransitionException = aws.json.parseJsonObject(errors.InvalidHandshakeTransitionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_handshake_transition_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?errors.InvalidInputException = aws.json.parseJsonObject(errors.InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResponsibilityTransferTransitionException")) {
        const parsed_error: ?errors.InvalidResponsibilityTransferTransitionException = aws.json.parseJsonObject(errors.InvalidResponsibilityTransferTransitionException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_responsibility_transfer_transition_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        const parsed_error: ?errors.MalformedPolicyDocumentException = aws.json.parseJsonObject(errors.MalformedPolicyDocumentException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MasterCannotLeaveOrganizationException")) {
        const parsed_error: ?errors.MasterCannotLeaveOrganizationException = aws.json.parseJsonObject(errors.MasterCannotLeaveOrganizationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .master_cannot_leave_organization_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotEmptyException")) {
        const parsed_error: ?errors.OrganizationNotEmptyException = aws.json.parseJsonObject(errors.OrganizationNotEmptyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organization_not_empty_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationalUnitNotEmptyException")) {
        const parsed_error: ?errors.OrganizationalUnitNotEmptyException = aws.json.parseJsonObject(errors.OrganizationalUnitNotEmptyException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organizational_unit_not_empty_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OrganizationalUnitNotFoundException")) {
        const parsed_error: ?errors.OrganizationalUnitNotFoundException = aws.json.parseJsonObject(errors.OrganizationalUnitNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .organizational_unit_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParentNotFoundException")) {
        const parsed_error: ?errors.ParentNotFoundException = aws.json.parseJsonObject(errors.ParentNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parent_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyChangesInProgressException")) {
        const parsed_error: ?errors.PolicyChangesInProgressException = aws.json.parseJsonObject(errors.PolicyChangesInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_changes_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyInUseException")) {
        const parsed_error: ?errors.PolicyInUseException = aws.json.parseJsonObject(errors.PolicyInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyNotAttachedException")) {
        const parsed_error: ?errors.PolicyNotAttachedException = aws.json.parseJsonObject(errors.PolicyNotAttachedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_not_attached_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        const parsed_error: ?errors.PolicyNotFoundException = aws.json.parseJsonObject(errors.PolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyTypeAlreadyEnabledException")) {
        const parsed_error: ?errors.PolicyTypeAlreadyEnabledException = aws.json.parseJsonObject(errors.PolicyTypeAlreadyEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_type_already_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyTypeNotAvailableForOrganizationException")) {
        const parsed_error: ?errors.PolicyTypeNotAvailableForOrganizationException = aws.json.parseJsonObject(errors.PolicyTypeNotAvailableForOrganizationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_type_not_available_for_organization_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "PolicyTypeNotEnabledException")) {
        const parsed_error: ?errors.PolicyTypeNotEnabledException = aws.json.parseJsonObject(errors.PolicyTypeNotEnabledException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .policy_type_not_enabled_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourcePolicyNotFoundException")) {
        const parsed_error: ?errors.ResourcePolicyNotFoundException = aws.json.parseJsonObject(errors.ResourcePolicyNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_policy_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResponsibilityTransferAlreadyInStatusException")) {
        const parsed_error: ?errors.ResponsibilityTransferAlreadyInStatusException = aws.json.parseJsonObject(errors.ResponsibilityTransferAlreadyInStatusException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .responsibility_transfer_already_in_status_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResponsibilityTransferNotFoundException")) {
        const parsed_error: ?errors.ResponsibilityTransferNotFoundException = aws.json.parseJsonObject(errors.ResponsibilityTransferNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .responsibility_transfer_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RootNotFoundException")) {
        const parsed_error: ?errors.RootNotFoundException = aws.json.parseJsonObject(errors.RootNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .root_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        const parsed_error: ?errors.ServiceException = aws.json.parseJsonObject(errors.ServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SourceParentNotFoundException")) {
        const parsed_error: ?errors.SourceParentNotFoundException = aws.json.parseJsonObject(errors.SourceParentNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .source_parent_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TargetNotFoundException")) {
        const parsed_error: ?errors.TargetNotFoundException = aws.json.parseJsonObject(errors.TargetNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .target_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        const parsed_error: ?errors.TooManyRequestsException = aws.json.parseJsonObject(errors.TooManyRequestsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_requests_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAPIEndpointException")) {
        const parsed_error: ?errors.UnsupportedAPIEndpointException = aws.json.parseJsonObject(errors.UnsupportedAPIEndpointException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_api_endpoint_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
