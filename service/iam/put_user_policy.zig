const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const PutUserPolicyInput = struct {
    /// The policy document.
    ///
    /// You must provide policies in JSON format in IAM. However, for CloudFormation
    /// templates formatted in YAML, you can provide the policy in JSON or YAML
    /// format. CloudFormation always converts a YAML policy to JSON format before
    /// submitting it to
    /// IAM.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// used to validate this parameter is a string of characters consisting of the
    /// following:
    ///
    /// * Any printable ASCII
    /// character ranging from the space character (`\u0020`) through the end of the
    /// ASCII character range
    ///
    /// * The printable characters in the Basic Latin and Latin-1 Supplement
    ///   character set
    /// (through `\u00FF`)
    ///
    /// * The special characters tab (`\u0009`), line feed (`\u000A`), and
    /// carriage return (`\u000D`)
    policy_document: []const u8,

    /// The name of the policy document.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    policy_name: []const u8,

    /// The name of the user to associate the policy with.
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    user_name: []const u8,
};

pub const PutUserPolicyOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *PutUserPolicyOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PutUserPolicyInput, options: Options) !PutUserPolicyOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PutUserPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("iam", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=PutUserPolicy&Version=2010-05-08");
    try body_buf.appendSlice(alloc, "&PolicyDocument=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.policy_document);
    try body_buf.appendSlice(alloc, "&PolicyName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.policy_name);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutUserPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: PutUserPolicyOutput = .{};

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
