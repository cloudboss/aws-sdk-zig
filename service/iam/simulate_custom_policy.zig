const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContextEntry = @import("context_entry.zig").ContextEntry;
const EvaluationResult = @import("evaluation_result.zig").EvaluationResult;
const serde = @import("serde.zig");

pub const SimulateCustomPolicyInput = struct {
    /// A list of names of API operations to evaluate in the simulation. Each
    /// operation is
    /// evaluated against each resource. Each operation must include the service
    /// identifier,
    /// such as `iam:CreateUser`. This operation does not support using wildcards
    /// (*)
    /// in an action name.
    action_names: []const []const u8,

    /// The ARN of the IAM user that you want to use as the simulated caller of the
    /// API
    /// operations. `CallerArn` is required if you include a
    /// `ResourcePolicy` so that the policy's `Principal` element has
    /// a value to use in evaluating the policy.
    ///
    /// You can specify only the ARN of an IAM user. You cannot specify the ARN of
    /// an
    /// assumed role, federated user, or a service principal.
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
    /// maximum permissions that an IAM entity can have. You can input only one
    /// permissions
    /// boundary when you pass a policy to this operation. For more information
    /// about
    /// permissions boundaries, see [Permissions boundaries for IAM
    /// entities](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*. The policy input is
    /// specified as a string that contains the complete, valid JSON text of a
    /// permissions
    /// boundary policy.
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

    /// A list of policy documents to include in the simulation. Each document is
    /// specified as
    /// a string containing the complete, valid JSON text of an IAM policy. Do not
    /// include any
    /// resource-based policies in this parameter. Any resource-based policy must be
    /// submitted
    /// with the `ResourcePolicy` parameter. The policies cannot be "scope-down"
    /// policies, such as you could include in a call to
    /// [GetFederationToken](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetFederationToken.html) or one of
    /// the
    /// [AssumeRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_AssumeRole.html) API operations. In other words, do not use policies designed to
    /// restrict what a user can do while using the temporary credentials.
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
    policy_input_list: []const []const u8,

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
    /// If you include a `ResourcePolicy`, then it must be applicable to all of the
    /// resources included in the simulation or you receive an invalid input error.
    ///
    /// For more information about ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
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

    /// An ARN representing the Amazon Web Services account ID that specifies the
    /// owner of any simulated
    /// resource that does not identify its owner in the resource ARN. Examples of
    /// resource ARNs
    /// include an S3 bucket or object. If `ResourceOwner` is specified, it is also
    /// used as the account owner of any `ResourcePolicy` included in the
    /// simulation.
    /// If the `ResourceOwner` parameter is not specified, then the owner of the
    /// resources and the resource policy defaults to the account of the identity
    /// provided in
    /// `CallerArn`. This parameter is required only if you specify a
    /// resource-based policy and account that owns the resource is different from
    /// the account
    /// that owns the simulated calling user `CallerArn`.
    ///
    /// The ARN for an account uses the following syntax:
    /// `arn:aws:iam::*AWS-account-ID*:root`. For example,
    /// to represent the account with the 112233445566 ID, use the following ARN:
    /// `arn:aws:iam::112233445566-ID:root`.
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
    /// Simulation of resource-based policies isn't supported for IAM roles.
    resource_policy: ?[]const u8 = null,
};

pub const SimulateCustomPolicyOutput = struct {
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
    is_truncated: bool = false,

    /// When `IsTruncated` is `true`, this element
    /// is present and contains the value to use for the `Marker` parameter in a
    /// subsequent
    /// pagination request.
    marker: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SimulateCustomPolicyInput, options: Options) !SimulateCustomPolicyOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: SimulateCustomPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=SimulateCustomPolicy&Version=2010-05-08");
    for (input.action_names, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ActionNames.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.caller_arn) |v| {
        try body_buf.appendSlice(alloc, "&CallerArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.context_entries) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ContextEntries.member.{d}.ContextKeyName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.context_key_name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ContextEntries.member.{d}.ContextKeyType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.context_key_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.context_key_values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ContextEntries.member.{d}.ContextKeyValues.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(alloc, "&Marker=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.max_items) |v| {
        try body_buf.appendSlice(alloc, "&MaxItems=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.permissions_boundary_policy_input_list) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PermissionsBoundaryPolicyInputList.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    for (input.policy_input_list, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyInputList.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try aws.url.appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.resource_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceArns.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.resource_handling_option) |v| {
        try body_buf.appendSlice(alloc, "&ResourceHandlingOption=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.resource_owner) |v| {
        try body_buf.appendSlice(alloc, "&ResourceOwner=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.resource_policy) |v| {
        try body_buf.appendSlice(alloc, "&ResourcePolicy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !SimulateCustomPolicyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SimulateCustomPolicyResult")) break;
            },
            else => {},
        }
    }

    var result: SimulateCustomPolicyOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EvaluationResults")) {
                    result.evaluation_results = try serde.deserializeEvaluationResultsListType(&reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try alloc.dupe(u8, try reader.readElementText());
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
