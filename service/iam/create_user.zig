const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const User = @import("user.zig").User;
const serde = @import("serde.zig");

pub const CreateUserInput = struct {
    /// The path for the user name. For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    ///
    /// This parameter is optional. If it is not included, it defaults to a slash
    /// (/).
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of either a forward slash (/) by itself or a string that must begin and end
    /// with forward slashes.
    /// In addition, it can contain any ASCII character from the ! (`\u0021`)
    /// through the DEL character (`\u007F`), including
    /// most punctuation characters, digits, and upper and lowercased letters.
    path: ?[]const u8 = null,

    /// The ARN of the managed policy that is used to set the permissions boundary
    /// for the
    /// user.
    ///
    /// A permissions boundary policy defines the maximum permissions that
    /// identity-based
    /// policies can grant to an entity, but does not grant permissions. Permissions
    /// boundaries
    /// do not define the maximum permissions that a resource-based policy can grant
    /// to an
    /// entity. To learn more, see [Permissions boundaries
    /// for IAM
    /// entities](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
    ///
    /// For more information about policy types, see [Policy types
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#access_policy-types) in the *IAM User Guide*.
    permissions_boundary: ?[]const u8 = null,

    /// A list of tags that you want to attach to the new user. Each tag consists of
    /// a key name and an associated value.
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// If any one of the tags is invalid or if you exceed the allowed maximum
    /// number of tags, then the entire request
    /// fails and the resource is not created.
    tags: ?[]const Tag = null,

    /// The name of the user to create.
    ///
    /// IAM user, group, role, and policy names must be unique within the account.
    /// Names are
    /// not distinguished by case. For example, you cannot create resources named
    /// both
    /// "MyResource" and "myresource".
    user_name: []const u8,
};

pub const CreateUserOutput = struct {
    /// A structure with details about the new IAM user.
    user: ?User = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateUserInput, options: Options) !CreateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iam");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateUser&Version=2010-05-08");
    if (input.path) |v| {
        try body_buf.appendSlice(alloc, "&Path=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.permissions_boundary) |v| {
        try body_buf.appendSlice(alloc, "&PermissionsBoundary=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.value);
            }
        }
    }
    try body_buf.appendSlice(alloc, "&UserName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.user_name);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateUserOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateUserResult")) break;
            },
            else => {},
        }
    }

    var result: CreateUserOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "User")) {
                    result.user = try serde.deserializeUser(&reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccountNotManagementOrDelegatedAdministratorException")) {
        return .{ .arena = arena, .kind = .{ .account_not_management_or_delegated_administrator_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CallerIsNotManagementAccountException")) {
        return .{ .arena = arena, .kind = .{ .caller_is_not_management_account_exception = .{
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
    if (std.mem.eql(u8, error_code, "CredentialReportExpiredException")) {
        return .{ .arena = arena, .kind = .{ .credential_report_expired_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CredentialReportNotPresentException")) {
        return .{ .arena = arena, .kind = .{ .credential_report_not_present_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CredentialReportNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .credential_report_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeleteConflictException")) {
        return .{ .arena = arena, .kind = .{ .delete_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateCertificateException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_certificate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateSSHPublicKeyException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_ssh_public_key_exception = .{
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
    if (std.mem.eql(u8, error_code, "EntityTemporarilyUnmodifiableException")) {
        return .{ .arena = arena, .kind = .{ .entity_temporarily_unmodifiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeatureDisabledException")) {
        return .{ .arena = arena, .kind = .{ .feature_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FeatureEnabledException")) {
        return .{ .arena = arena, .kind = .{ .feature_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthenticationCodeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_authentication_code_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPublicKeyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_public_key_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUserTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_user_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KeyPairMismatchException")) {
        return .{ .arena = arena, .kind = .{ .key_pair_mismatch_exception = .{
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
    if (std.mem.eql(u8, error_code, "MalformedCertificateException")) {
        return .{ .arena = arena, .kind = .{ .malformed_certificate_exception = .{
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
    if (std.mem.eql(u8, error_code, "NoSuchEntityException")) {
        return .{ .arena = arena, .kind = .{ .no_such_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OpenIdIdpCommunicationErrorException")) {
        return .{ .arena = arena, .kind = .{ .open_id_idp_communication_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "OrganizationNotInAllFeaturesModeException")) {
        return .{ .arena = arena, .kind = .{ .organization_not_in_all_features_mode_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PasswordPolicyViolationException")) {
        return .{ .arena = arena, .kind = .{ .password_policy_violation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyEvaluationException")) {
        return .{ .arena = arena, .kind = .{ .policy_evaluation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotAttachableException")) {
        return .{ .arena = arena, .kind = .{ .policy_not_attachable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReportGenerationLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .report_generation_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceAccessNotEnabledException")) {
        return .{ .arena = arena, .kind = .{ .service_access_not_enabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .service_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnmodifiableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unmodifiable_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnrecognizedPublicKeyEncodingException")) {
        return .{ .arena = arena, .kind = .{ .unrecognized_public_key_encoding_exception = .{
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
