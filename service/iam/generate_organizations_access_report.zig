const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Generates a report for service last accessed data for Organizations. You can
/// generate a
/// report for any entities (organization root, organizational unit, or account)
/// or policies
/// in your organization.
///
/// To call this operation, you must be signed in using your Organizations
/// management account
/// credentials. You can use your long-term IAM user or root user credentials,
/// or temporary
/// credentials from assuming an IAM role. SCPs must be enabled for your
/// organization
/// root. You must have the required IAM and Organizations permissions. For more
/// information, see
/// [Refining permissions using service last accessed
/// data](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the
/// *IAM User Guide*.
///
/// You can generate a service last accessed data report for entities by
/// specifying only
/// the entity's path. This data includes a list of services that are allowed by
/// any service
/// control policies (SCPs) that apply to the entity.
///
/// You can generate a service last accessed data report for a policy by
/// specifying an
/// entity's path and an optional Organizations policy ID. This data includes a
/// list of services that
/// are allowed by the specified SCP.
///
/// For each service in both report types, the data includes the most recent
/// account
/// activity that the policy allows to account principals in the entity or the
/// entity's
/// children. For important information about the data, reporting period,
/// permissions
/// required, troubleshooting, and supported Regions see [Reducing permissions
/// using
/// service last accessed
/// data](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the
/// *IAM User Guide*.
///
/// **Important:**
///
/// The data includes all attempts to access Amazon Web Services, not just the
/// successful ones. This
/// includes all attempts that were made using the Amazon Web Services
/// Management Console, the Amazon Web Services API through any
/// of the SDKs, or any of the command line tools. An unexpected entry in the
/// service
/// last accessed data does not mean that an account has been compromised,
/// because the
/// request might have been denied. Refer to your CloudTrail logs as the
/// authoritative
/// source for information about all API calls and whether they were successful
/// or
/// denied access. For more information, see [Logging IAM events with
/// CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html) in the *IAM User Guide*.
///
/// This operation returns a `JobId`. Use this parameter in the `
/// [GetOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOrganizationsAccessReport.html)
/// ` operation to check the status of
/// the report generation. To check the status of this request, use the `JobId`
/// parameter in the `
/// [GetOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOrganizationsAccessReport.html)
/// ` operation and test the
/// `JobStatus` response parameter. When the job is complete, you can
/// retrieve the report.
///
/// To generate a service last accessed data report for entities, specify an
/// entity path
/// without specifying the optional Organizations policy ID. The type of entity
/// that you specify
/// determines the data returned in the report.
///
/// * **Root** – When you specify the
/// organizations root as the entity, the resulting report lists all of the
/// services
/// allowed by SCPs that are attached to your root. For each service, the report
/// includes data for all accounts in your organization except the
/// management account, because the management account is not limited by SCPs.
///
/// * **OU** – When you specify an
/// organizational unit (OU) as the entity, the resulting report lists all of
/// the
/// services allowed by SCPs that are attached to the OU and its parents. For
/// each
/// service, the report includes data for all accounts in the OU or its
/// children.
/// This data excludes the management account, because the management account is
/// not
/// limited by SCPs.
///
/// * **management account** – When you specify the
/// management account, the resulting report lists all Amazon Web Services
/// services, because the
/// management account is not limited by SCPs. For each service, the report
/// includes
/// data for only the management account.
///
/// * **Account** – When you specify another
/// account as the entity, the resulting report lists all of the services
/// allowed by
/// SCPs that are attached to the account and its parents. For each service, the
/// report includes data for only the specified account.
///
/// To generate a service last accessed data report for policies, specify an
/// entity path
/// and the optional Organizations policy ID. The type of entity that you
/// specify determines the data
/// returned for each service.
///
/// * **Root** – When you specify the root
/// entity and a policy ID, the resulting report lists all of the services that
/// are
/// allowed by the specified SCP. For each service, the report includes data for
/// all
/// accounts in your organization to which the SCP applies. This data excludes
/// the
/// management account, because the management account is not limited by SCPs.
/// If the
/// SCP is not attached to any entities in the organization, then the report
/// will
/// return a list of services with no data.
///
/// * **OU** – When you specify an OU entity and
/// a policy ID, the resulting report lists all of the services that are allowed
/// by
/// the specified SCP. For each service, the report includes data for all
/// accounts
/// in the OU or its children to which the SCP applies. This means that other
/// accounts outside the OU that are affected by the SCP might not be included
/// in
/// the data. This data excludes the management account, because the
/// management account is not limited by SCPs. If the SCP is not attached to the
/// OU
/// or one of its children, the report will return a list of services with no
/// data.
///
/// * **management account** – When you specify the
/// management account, the resulting report lists all Amazon Web Services
/// services, because the
/// management account is not limited by SCPs. If you specify a policy ID in the
/// CLI
/// or API, the policy is ignored. For each service, the report includes data
/// for
/// only the management account.
///
/// * **Account** – When you specify another
/// account entity and a policy ID, the resulting report lists all of the
/// services
/// that are allowed by the specified SCP. For each service, the report includes
/// data for only the specified account. This means that other accounts in the
/// organization that are affected by the SCP might not be included in the data.
/// If
/// the SCP is not attached to the account, the report will return a list of
/// services with no data.
///
/// **Note:**
///
/// Service last accessed data does not use other policy types when determining
/// whether a principal could access a service. These other policy types include
/// identity-based policies, resource-based policies, access control lists, IAM
/// permissions boundaries, and STS assume role policies. It only applies SCP
/// logic.
/// For more about the evaluation of policy types, see [Evaluating
/// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-basics) in the
/// *IAM User Guide*.
///
/// For more information about service last accessed data, see [Reducing policy
/// scope by
/// viewing user
/// activity](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html) in the *IAM User Guide*.
pub const GenerateOrganizationsAccessReportInput = struct {
    /// The path of the Organizations entity (root, OU, or account). You can build
    /// an entity path
    /// using the known structure of your organization. For example, assume that
    /// your account ID
    /// is `123456789012` and its parent OU ID is `ou-rge0-awsabcde`. The
    /// organization root ID is `r-f6g7h8i9j0example` and your organization ID is
    /// `o-a1b2c3d4e5`. Your entity path is
    /// `o-a1b2c3d4e5/r-f6g7h8i9j0example/ou-rge0-awsabcde/123456789012`.
    entity_path: []const u8,

    /// The identifier of the Organizations service control policy (SCP). This
    /// parameter is
    /// optional.
    ///
    /// This ID is used to generate information about when an account principal that
    /// is
    /// limited by the SCP attempted to access an Amazon Web Services service.
    organizations_policy_id: ?[]const u8 = null,
};

pub const GenerateOrganizationsAccessReportOutput = struct {
    /// The job identifier that you can use in the
    /// [GetOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOrganizationsAccessReport.html) operation.
    job_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const GenerateOrganizationsAccessReportOutput) void {
        if (self.job_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GenerateOrganizationsAccessReportInput, options: Options) !GenerateOrganizationsAccessReportOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: GenerateOrganizationsAccessReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("iam", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GenerateOrganizationsAccessReport&Version=2010-05-08");
    try body_buf.appendSlice(alloc, "&EntityPath=");
    try appendUrlEncoded(alloc, &body_buf, input.entity_path);
    if (input.organizations_policy_id) |v| {
        try body_buf.appendSlice(alloc, "&OrganizationsPolicyId=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !GenerateOrganizationsAccessReportOutput {
    _ = status;
    var result: GenerateOrganizationsAccessReportOutput = .{ .allocator = alloc };
    if (findElement(body, "JobId")) |content| {
        result.job_id = try alloc.dupe(u8, content);
    }

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
