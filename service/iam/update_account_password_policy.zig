const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Updates the password policy settings for the Amazon Web Services account.
///
/// **Note:**
///
/// This operation does not support partial updates. No parameters are required,
/// but
/// if you do not specify a parameter, that parameter's value reverts to its
/// default
/// value. See the **Request Parameters** section for each
/// parameter's default value. Also note that some parameters do not allow the
/// default
/// parameter to be explicitly set. Instead, to invoke the default value, do not
/// include
/// that parameter when you invoke the operation.
///
/// For more information about using a password policy, see [Managing an IAM
/// password
/// policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the *IAM User Guide*.
pub const UpdateAccountPasswordPolicyInput = struct {
    /// Allows all IAM users in your account to use the Amazon Web Services
    /// Management Console to change their own
    /// passwords. For more information, see [Permitting
    /// IAM users to change their own
    /// passwords](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_enable-user-change.html) in the
    /// *IAM User Guide*.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that IAM users in the account do not
    /// automatically have permissions to change their own password.
    allow_users_to_change_password: ?bool = null,

    /// Prevents IAM users who are accessing the account via the Amazon Web Services
    /// Management Console from setting a
    /// new console password after their password has expired. The IAM user cannot
    /// access the
    /// console until an administrator resets the password.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that IAM users can change their passwords
    /// after they expire and continue to sign in as the user.
    ///
    /// **Note:**
    ///
    /// In the Amazon Web Services Management Console, the custom password policy
    /// option **Allow
    /// users to change their own password** gives IAM users permissions to
    /// `iam:ChangePassword` for only their user and to the
    /// `iam:GetAccountPasswordPolicy` action. This option does not attach a
    /// permissions policy to each user, rather the permissions are applied at the
    /// account-level for all users by IAM. IAM users with
    /// `iam:ChangePassword` permission and active access keys can reset
    /// their own expired console password using the CLI or API.
    hard_expiry: ?bool = null,

    /// The number of days that an IAM user password is valid.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `0`. The result is that IAM user passwords never expire.
    max_password_age: ?i32 = null,

    /// The minimum number of characters allowed in an IAM user password.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `6`.
    minimum_password_length: ?i32 = null,

    /// Specifies the number of previous passwords that IAM users are prevented from
    /// reusing.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `0`. The result is that IAM users are not prevented from reusing
    /// previous passwords.
    password_reuse_prevention: ?i32 = null,

    /// Specifies whether IAM user passwords must contain at least one lowercase
    /// character
    /// from the ISO basic Latin alphabet (a to z).
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that passwords do not require at least one
    /// lowercase character.
    require_lowercase_characters: ?bool = null,

    /// Specifies whether IAM user passwords must contain at least one numeric
    /// character (0
    /// to 9).
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that passwords do not require at least one
    /// numeric character.
    require_numbers: ?bool = null,

    /// Specifies whether IAM user passwords must contain at least one of the
    /// following
    /// non-alphanumeric characters:
    ///
    /// ! @ # $ % ^ & * ( ) _ + - = [ ] { } | '
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that passwords do not require at least one
    /// symbol character.
    require_symbols: ?bool = null,

    /// Specifies whether IAM user passwords must contain at least one uppercase
    /// character
    /// from the ISO basic Latin alphabet (A to Z).
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that passwords do not require at least one
    /// uppercase character.
    require_uppercase_characters: ?bool = null,
};

pub const UpdateAccountPasswordPolicyOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *UpdateAccountPasswordPolicyOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: UpdateAccountPasswordPolicyInput, options: Options) !UpdateAccountPasswordPolicyOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateAccountPasswordPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("iam", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=UpdateAccountPasswordPolicy&Version=2010-05-08");
    if (input.allow_users_to_change_password) |v| {
        try body_buf.appendSlice(alloc, "&AllowUsersToChangePassword=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.hard_expiry) |v| {
        try body_buf.appendSlice(alloc, "&HardExpiry=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.max_password_age) |v| {
        try body_buf.appendSlice(alloc, "&MaxPasswordAge=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.minimum_password_length) |v| {
        try body_buf.appendSlice(alloc, "&MinimumPasswordLength=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.password_reuse_prevention) |v| {
        try body_buf.appendSlice(alloc, "&PasswordReusePrevention=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.require_lowercase_characters) |v| {
        try body_buf.appendSlice(alloc, "&RequireLowercaseCharacters=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.require_numbers) |v| {
        try body_buf.appendSlice(alloc, "&RequireNumbers=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.require_symbols) |v| {
        try body_buf.appendSlice(alloc, "&RequireSymbols=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.require_uppercase_characters) |v| {
        try body_buf.appendSlice(alloc, "&RequireUppercaseCharacters=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateAccountPasswordPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: UpdateAccountPasswordPolicyOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestId") orelse "";

    if (std.mem.eql(u8, error_code, "AccountNotManagementOrDelegatedAdministratorException")) {
        return .{ .account_not_management_or_delegated_administrator_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "CallerIsNotManagementAccountException")) {
        return .{ .caller_is_not_management_account_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .concurrent_modification_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "CredentialReportExpiredException")) {
        return .{ .credential_report_expired_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "CredentialReportNotPresentException")) {
        return .{ .credential_report_not_present_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "CredentialReportNotReadyException")) {
        return .{ .credential_report_not_ready_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "DeleteConflictException")) {
        return .{ .delete_conflict_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateCertificateException")) {
        return .{ .duplicate_certificate_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateSSHPublicKeyException")) {
        return .{ .duplicate_ssh_public_key_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EntityAlreadyExistsException")) {
        return .{ .entity_already_exists_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EntityTemporarilyUnmodifiableException")) {
        return .{ .entity_temporarily_unmodifiable_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "FeatureDisabledException")) {
        return .{ .feature_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "FeatureEnabledException")) {
        return .{ .feature_enabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthenticationCodeException")) {
        return .{ .invalid_authentication_code_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateException")) {
        return .{ .invalid_certificate_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .invalid_input_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPublicKeyException")) {
        return .{ .invalid_public_key_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidUserTypeException")) {
        return .{ .invalid_user_type_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "KeyPairMismatchException")) {
        return .{ .key_pair_mismatch_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "MalformedCertificateException")) {
        return .{ .malformed_certificate_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .malformed_policy_document_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchEntityException")) {
        return .{ .no_such_entity_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "OpenIdIdpCommunicationErrorException")) {
        return .{ .open_id_idp_communication_error_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotFoundException")) {
        return .{ .organization_not_found_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "OrganizationNotInAllFeaturesModeException")) {
        return .{ .organization_not_in_all_features_mode_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "PasswordPolicyViolationException")) {
        return .{ .password_policy_violation_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyEvaluationException")) {
        return .{ .policy_evaluation_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotAttachableException")) {
        return .{ .policy_not_attachable_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ReportGenerationLimitExceededException")) {
        return .{ .report_generation_limit_exceeded_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceAccessNotEnabledException")) {
        return .{ .service_access_not_enabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .service_failure_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotSupportedException")) {
        return .{ .service_not_supported_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "UnmodifiableEntityException")) {
        return .{ .unmodifiable_entity_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "UnrecognizedPublicKeyEncodingException")) {
        return .{ .unrecognized_public_key_encoding_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
