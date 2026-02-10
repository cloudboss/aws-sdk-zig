const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContextEntry = @import("context_entry.zig").ContextEntry;
const EvaluationResult = @import("evaluation_result.zig").EvaluationResult;

/// Simulate how a set of IAM policies attached to an IAM entity works with a
/// list of
/// API operations and Amazon Web Services resources to determine the policies'
/// effective permissions. The
/// entity can be an IAM user, group, or role. If you specify a user, then the
/// simulation
/// also includes all of the policies that are attached to groups that the user
/// belongs to.
/// You can simulate resources that don't exist in your account.
///
/// You can optionally include a list of one or more additional policies
/// specified as
/// strings to include in the simulation. If you want to simulate only policies
/// specified as
/// strings, use
/// [SimulateCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulateCustomPolicy.html) instead.
///
/// You can also optionally include one resource-based policy to be evaluated
/// with each of
/// the resources included in the simulation for IAM users only.
///
/// The simulation does not perform the API operations; it only checks the
/// authorization
/// to determine if the simulated policies allow or deny the operations.
///
/// **Note:** This operation discloses information about the
/// permissions granted to other users. If you do not want users to see other
/// user's
/// permissions, then consider allowing them to use
/// [SimulateCustomPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SimulateCustomPolicy.html) instead.
///
/// Context keys are variables maintained by Amazon Web Services and its
/// services that provide details
/// about the context of an API query request. You can use the `Condition`
/// element of an IAM policy to evaluate context keys. To get the list of
/// context keys
/// that the policies require for correct simulation, use
/// [GetContextKeysForPrincipalPolicy](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetContextKeysForPrincipalPolicy.html).
///
/// If the output is long, you can use the `MaxItems` and `Marker`
/// parameters to paginate the results.
///
/// **Note:**
///
/// The IAM policy simulator evaluates statements in the identity-based policy
/// and
/// the inputs that you provide during simulation. The policy simulator results
/// can
/// differ from your live Amazon Web Services environment. We recommend that you
/// check your policies
/// against your live Amazon Web Services environment after testing using the
/// policy simulator to
/// confirm that you have the desired results. For more information about using
/// the
/// policy simulator, see [Testing IAM
/// policies with the IAM policy simulator
/// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_testing-policies.html)in the
/// *IAM User Guide*.
pub const SimulatePrincipalPolicyInput = struct {
    /// A list of names of API operations to evaluate in the simulation. Each
    /// operation is
    /// evaluated for each resource. Each operation must include the service
    /// identifier, such as
    /// `iam:CreateUser`.
    action_names: []const []const u8,

    /// The ARN of the IAM user that you want to specify as the simulated caller of
    /// the API
    /// operations. If you do not specify a `CallerArn`, it defaults to the ARN of
    /// the user that you specify in `PolicySourceArn`, if you specified a user. If
    /// you include both a `PolicySourceArn` (for example,
    /// `arn:aws:iam::123456789012:user/David`) and a `CallerArn` (for
    /// example, `arn:aws:iam::123456789012:user/Bob`), the result is that you
    /// simulate calling the API operations as Bob, as if Bob had David's policies.
    ///
    /// You can specify only the ARN of an IAM user. You cannot specify the ARN of
    /// an
    /// assumed role, federated user, or a service principal.
    ///
    /// `CallerArn` is required if you include a `ResourcePolicy` and
    /// the `PolicySourceArn` is not the ARN for an IAM user. This is required so
    /// that the resource-based policy's `Principal` element has a value to use in
    /// evaluating the policy.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    caller_arn: ?[]const u8 = null,

    /// A list of context keys and corresponding values for the simulation to use.
    /// Whenever a
    /// context key is evaluated in one of the simulated IAM permissions policies,
    /// the
    /// corresponding value is supplied.
    context_entries: ?[]const ContextEntry = null,

    /// Use this parameter only when paginating results and only after
    /// you receive a response indicating that the results are truncated. Set it to
    /// the value of the
    /// `Marker` element in the response that you received to indicate where the
    /// next call
    /// should start.
    marker: ?[]const u8 = null,

    /// Use this only when paginating results to indicate the
    /// maximum number of items you want in the response. If additional items exist
    /// beyond the maximum
    /// you specify, the `IsTruncated` response element is `true`.
    ///
    /// If you do not include this parameter, the number of items defaults to 100.
    /// Note that
    /// IAM might return fewer results, even when there are more results available.
    /// In that case, the
    /// `IsTruncated` response element returns `true`, and `Marker`
    /// contains a value to include in the subsequent call that tells the service
    /// where to continue
    /// from.
    max_items: ?i32 = null,

    /// The IAM permissions boundary policy to simulate. The permissions boundary
    /// sets the
    /// maximum permissions that the entity can have. You can input only one
    /// permissions
    /// boundary when you pass a policy to this operation. An IAM entity can only
    /// have one
    /// permissions boundary in effect at a time. For example, if a permissions
    /// boundary is
    /// attached to an entity and you pass in a different permissions boundary
    /// policy using this
    /// parameter, then the new permissions boundary policy is used for the
    /// simulation. For more
    /// information about permissions boundaries, see [Permissions boundaries for
    /// IAM
    /// entities](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*. The policy input is
    /// specified as a string containing the complete, valid JSON text of a
    /// permissions boundary
    /// policy.
    ///
    /// The maximum length of the policy document that you can pass in this
    /// operation,
    /// including whitespace, is listed below. To view the maximum character counts
    /// of a managed policy with no whitespaces, see [IAM and STS character
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html#reference_iam-quotas-entity-length).
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
    permissions_boundary_policy_input_list: ?[]const []const u8 = null,

    /// An optional list of additional policy documents to include in the
    /// simulation. Each
    /// document is specified as a string containing the complete, valid JSON text
    /// of an IAM
    /// policy.
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
    policy_input_list: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of a user, group, or role whose policies you
    /// want to
    /// include in the simulation. If you specify a user, group, or role, the
    /// simulation
    /// includes all policies that are associated with that entity. If you specify a
    /// user, the
    /// simulation also includes all policies that are attached to any groups the
    /// user belongs
    /// to.
    ///
    /// The maximum length of the policy document that you can pass in this
    /// operation,
    /// including whitespace, is listed below. To view the maximum character counts
    /// of a managed policy with no whitespaces, see [IAM and STS character
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html#reference_iam-quotas-entity-length).
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    policy_source_arn: []const u8,

    /// A list of ARNs of Amazon Web Services resources to include in the
    /// simulation. If this parameter is
    /// not provided, then the value defaults to `*` (all resources). Each API in
    /// the
    /// `ActionNames` parameter is evaluated for each resource in this list. The
    /// simulation determines the access result (allowed or denied) of each
    /// combination and
    /// reports it in the response. You can simulate resources that don't exist in
    /// your
    /// account.
    ///
    /// The simulation does not automatically retrieve policies for the specified
    /// resources.
    /// If you want to include a resource policy in the simulation, then you must
    /// include the
    /// policy as a string in the `ResourcePolicy` parameter.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    ///
    /// **Note:**
    ///
    /// Simulation of resource-based policies isn't supported for IAM roles.
    resource_arns: ?[]const []const u8 = null,

    /// Specifies the type of simulation to run. Different API operations that
    /// support
    /// resource-based policies require different combinations of resources. By
    /// specifying the
    /// type of simulation to run, you enable the policy simulator to enforce the
    /// presence of
    /// the required resources to ensure reliable simulation results. If your
    /// simulation does
    /// not match one of the following scenarios, then you can omit this parameter.
    /// The
    /// following list shows each of the supported scenario values and the resources
    /// that you
    /// must define to run the simulation.
    ///
    /// Each of the Amazon EC2 scenarios requires that you specify instance, image,
    /// and security
    /// group resources. If your scenario includes an EBS volume, then you must
    /// specify that
    /// volume as a resource. If the Amazon EC2 scenario includes VPC, then you must
    /// supply the
    /// network interface resource. If it includes an IP subnet, then you must
    /// specify the
    /// subnet resource. For more information on the Amazon EC2 scenario options,
    /// see [Supported
    /// platforms](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-supported-platforms.html) in the *Amazon EC2 User Guide*.
    ///
    /// * **EC2-VPC-InstanceStore**
    ///
    /// instance, image, security group, network interface
    ///
    /// * **EC2-VPC-InstanceStore-Subnet**
    ///
    /// instance, image, security group, network interface, subnet
    ///
    /// * **EC2-VPC-EBS**
    ///
    /// instance, image, security group, network interface, volume
    ///
    /// * **EC2-VPC-EBS-Subnet**
    ///
    /// instance, image, security group, network interface, subnet, volume
    resource_handling_option: ?[]const u8 = null,

    /// An Amazon Web Services account ID that specifies the owner of any simulated
    /// resource that does not
    /// identify its owner in the resource ARN. Examples of resource ARNs include an
    /// S3 bucket
    /// or object. If `ResourceOwner` is specified, it is also used as the account
    /// owner of any `ResourcePolicy` included in the simulation. If the
    /// `ResourceOwner` parameter is not specified, then the owner of the
    /// resources and the resource policy defaults to the account of the identity
    /// provided in
    /// `CallerArn`. This parameter is required only if you specify a
    /// resource-based policy and account that owns the resource is different from
    /// the account
    /// that owns the simulated calling user `CallerArn`.
    resource_owner: ?[]const u8 = null,

    /// A resource-based policy to include in the simulation provided as a string.
    /// Each
    /// resource in the simulation is treated as if it had this policy attached. You
    /// can include
    /// only one resource-based policy in a simulation.
    ///
    /// The maximum length of the policy document that you can pass in this
    /// operation,
    /// including whitespace, is listed below. To view the maximum character counts
    /// of a managed policy with no whitespaces, see [IAM and STS character
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html#reference_iam-quotas-entity-length).
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
    ///
    /// **Note:**
    ///
    /// Simulation of resource-based policies isn't supported for IAM roles.
    resource_policy: ?[]const u8 = null,
};

pub const SimulatePrincipalPolicyOutput = struct {
    /// The results of the simulation.
    evaluation_results: ?[]const EvaluationResult = null,

    /// A flag that indicates whether there are more items to return. If your
    /// results were truncated, you can make a subsequent pagination request using
    /// the `Marker`
    /// request parameter to retrieve more items. Note that IAM might return fewer
    /// than the
    /// `MaxItems` number of results even when there are more results available. We
    /// recommend
    /// that you check `IsTruncated` after every call to ensure that you receive all
    /// your
    /// results.
    is_truncated: ?bool = null,

    /// When `IsTruncated` is `true`, this element
    /// is present and contains the value to use for the `Marker` parameter in a
    /// subsequent
    /// pagination request.
    marker: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const SimulatePrincipalPolicyOutput) void {
        if (self.marker) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: SimulatePrincipalPolicyInput, options: Options) !SimulatePrincipalPolicyOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: SimulatePrincipalPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("iam", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=SimulatePrincipalPolicy&Version=2010-05-08");
    for (input.action_names, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ActionNames.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.caller_arn) |v| {
        try body_buf.appendSlice(alloc, "&CallerArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.context_entries) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ContextEntries.member.{d}.ContextKeyName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.context_key_name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ContextEntries.member.{d}.ContextKeyType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.context_key_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(alloc, "&Marker=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.max_items) |v| {
        try body_buf.appendSlice(alloc, "&MaxItems=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.permissions_boundary_policy_input_list) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PermissionsBoundaryPolicyInputList.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.policy_input_list) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyInputList.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&PolicySourceArn=");
    try appendUrlEncoded(alloc, &body_buf, input.policy_source_arn);
    if (input.resource_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceArns.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.resource_handling_option) |v| {
        try body_buf.appendSlice(alloc, "&ResourceHandlingOption=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.resource_owner) |v| {
        try body_buf.appendSlice(alloc, "&ResourceOwner=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.resource_policy) |v| {
        try body_buf.appendSlice(alloc, "&ResourcePolicy=");
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !SimulatePrincipalPolicyOutput {
    _ = status;
    var result: SimulatePrincipalPolicyOutput = .{ .allocator = alloc };
    if (findElement(body, "IsTruncated")) |content| {
        result.is_truncated = std.mem.eql(u8, content, "true");
    }
    if (findElement(body, "Marker")) |content| {
        result.marker = try alloc.dupe(u8, content);
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
