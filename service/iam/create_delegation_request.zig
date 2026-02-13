const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DelegationPermission = @import("delegation_permission.zig").DelegationPermission;
const serde = @import("serde.zig");

/// Creates an IAM delegation request for temporary access delegation.
///
/// This API is not available for general use. In order to use this API, a
/// caller first need to
/// go through an onboarding process described in the
/// [partner onboarding
/// documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation-partner-guide.html).
pub const CreateDelegationRequestInput = struct {
    /// A description of the delegation request.
    description: []const u8,

    /// The notification channel for updates about the delegation request.
    ///
    /// At this time,only SNS topic ARNs are accepted for notification. This topic
    /// ARN must have a resource policy granting
    /// `SNS:Publish` permission to the IAM service principal (`iam.amazonaws.com`).
    /// See
    /// [partner onboarding
    /// documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation-partner-guide.html) for more details.
    notification_channel: []const u8,

    /// Specifies whether the delegation token should only be sent by the owner.
    ///
    /// This flag prevents any party other than the owner from calling
    /// `SendDelegationToken` API for this delegation request.
    /// This behavior becomes useful when the delegation request owner needs to be
    /// present for subsequent partner interactions, but the delegation request was
    /// sent
    /// to a more privileged user for approval due to the owner lacking sufficient
    /// delegation permissions.
    only_send_by_owner: ?bool = null,

    /// The Amazon Web Services account ID this delegation request is targeted to.
    ///
    /// If the account ID is not known, this parameter can be omitted, resulting in
    /// a request that can be associated by
    /// any account. If the account ID passed, then the created delegation request
    /// can only be associated with an
    /// identity of that target account.
    owner_account_id: ?[]const u8 = null,

    /// The permissions to be delegated in this delegation request.
    permissions: DelegationPermission,

    /// The URL to redirect to after the delegation request is processed.
    ///
    /// This URL is used by the IAM console to show a link to the customer to
    /// re-load the partner workflow.
    redirect_url: ?[]const u8 = null,

    /// A message explaining the reason for the delegation request.
    ///
    /// Requesters can utilize this field to add a custom note to the delegation
    /// request. This field is different from the
    /// description such that this is to be utilized for a custom messaging on a
    /// case-by-case basis.
    ///
    /// For example, if the current delegation request is in response to a previous
    /// request being rejected, this explanation
    /// can be added to the request via this field.
    request_message: ?[]const u8 = null,

    /// The workflow ID associated with the requestor.
    ///
    /// This is the unique identifier on the partner side that can be used to track
    /// the progress of the request.
    ///
    /// IAM maintains a uniqueness check on this workflow id for each request - if a
    /// workflow id for an existing request
    /// is passed, this API call will fail.
    requestor_workflow_id: []const u8,

    /// The duration for which the delegated session should remain active, in
    /// seconds.
    ///
    /// The active time window for the session starts when the customer calls the
    /// [SendDelegationToken](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SendDelegationToken.html) API.
    session_duration: i32,
};

pub const CreateDelegationRequestOutput = struct {
    /// A deep link URL to the Amazon Web Services Management Console for managing
    /// the delegation request.
    ///
    /// For a console based workflow, partners should redirect the customer to this
    /// URL.
    /// If the customer is not logged in to any Amazon Web Services account, the
    /// Amazon Web Services workflow will
    /// automatically direct the customer to log in and then display the delegation
    /// request approval page.
    console_deep_link: ?[]const u8 = null,

    /// The unique identifier for the created delegation request.
    delegation_request_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateDelegationRequestOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateDelegationRequestInput, options: Options) !CreateDelegationRequestOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDelegationRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("iam", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateDelegationRequest&Version=2010-05-08");
    try body_buf.appendSlice(alloc, "&Description=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.description);
    try body_buf.appendSlice(alloc, "&NotificationChannel=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.notification_channel);
    if (input.only_send_by_owner) |v| {
        try body_buf.appendSlice(alloc, "&OnlySendByOwner=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.owner_account_id) |v| {
        try body_buf.appendSlice(alloc, "&OwnerAccountId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.permissions.parameters) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Permissions.Parameters.member.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Permissions.Parameters.member.{d}.Type=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.@"type") |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Permissions.Parameters.member.{d}.Values.member.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.permissions.policy_template_arn) |sv| {
        try body_buf.appendSlice(alloc, "&Permissions.PolicyTemplateArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
    }
    if (input.redirect_url) |v| {
        try body_buf.appendSlice(alloc, "&RedirectUrl=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.request_message) |v| {
        try body_buf.appendSlice(alloc, "&RequestMessage=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&RequestorWorkflowId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.requestor_workflow_id);
    try body_buf.appendSlice(alloc, "&SessionDuration=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.session_duration}) catch "");

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDelegationRequestOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDelegationRequestResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDelegationRequestOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConsoleDeepLink")) {
                    result.console_deep_link = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DelegationRequestId")) {
                    result.delegation_request_id = try alloc.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";

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
