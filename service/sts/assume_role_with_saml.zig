const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const AssumedRoleUser = @import("assumed_role_user.zig").AssumedRoleUser;
const Credentials = @import("credentials.zig").Credentials;
const serde = @import("serde.zig");

pub const AssumeRoleWithSAMLInput = struct {
    /// The duration, in seconds, of the role session. Your role session lasts for
    /// the duration
    /// that you specify for the `DurationSeconds` parameter, or until the time
    /// specified in the SAML authentication response's `SessionNotOnOrAfter` value,
    /// whichever is shorter. You can provide a `DurationSeconds` value from 900
    /// seconds
    /// (15 minutes) up to the maximum session duration setting for the role. This
    /// setting can have
    /// a value from 1 hour to 12 hours. If you specify a value higher than this
    /// setting, the
    /// operation fails. For example, if you specify a session duration of 12 hours,
    /// but your
    /// administrator set the maximum session duration to 6 hours, your operation
    /// fails. To learn
    /// how to view the maximum value for your role, see [View the
    /// Maximum Session Duration Setting for a
    /// Role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session) in the
    /// *IAM User Guide*.
    ///
    /// By default, the value is set to `3600` seconds.
    ///
    /// The `DurationSeconds` parameter is separate from the duration of a console
    /// session that you might request using the returned credentials. The request
    /// to the
    /// federation endpoint for a console sign-in token takes a `SessionDuration`
    /// parameter that specifies the maximum length of the console session. For more
    /// information, see [Creating a URL
    /// that Enables Federated Users to Access the Amazon Web Services Management
    /// Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html) in the
    /// *IAM User Guide*.
    duration_seconds: ?i32 = null,

    /// An IAM policy in JSON format that you want to use as an inline session
    /// policy.
    ///
    /// This parameter is optional. Passing policies to this operation returns new
    /// temporary credentials. The resulting session's permissions are the
    /// intersection of the
    /// role's identity-based policy and the session policies. You can use the
    /// role's temporary
    /// credentials in subsequent Amazon Web Services API calls to access resources
    /// in the account that owns
    /// the role. You cannot use session policies to grant more permissions than
    /// those allowed
    /// by the identity-based policy of the role that is being assumed. For more
    /// information, see
    /// [Session
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) in the *IAM User Guide*.
    ///
    /// The plaintext that you use for both inline and managed session policies
    /// can't exceed
    /// 2,048 characters. The JSON policy characters can be any ASCII character from
    /// the space
    /// character to the end of the valid character list (\u0020 through \u00FF). It
    /// can also
    /// include the tab (\u0009), linefeed (\u000A), and carriage return (\u000D)
    /// characters.
    ///
    /// For more information about role session permissions, see [Session
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session).
    ///
    /// An Amazon Web Services conversion compresses the passed inline session
    /// policy, managed policy ARNs,
    /// and session tags into a packed binary format that has a separate limit. Your
    /// request can
    /// fail for this limit even if your plaintext meets the other requirements. The
    /// `PackedPolicySize` response element indicates by percentage how close the
    /// policies and tags for your request are to the upper size limit.
    policy: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of the IAM managed policies that you want
    /// to use as
    /// managed session policies. The policies must exist in the same account as the
    /// role.
    ///
    /// This parameter is optional. You can provide up to 10 managed policy ARNs.
    /// However, the
    /// plaintext that you use for both inline and managed session policies can't
    /// exceed 2,048
    /// characters. For more information about ARNs, see [Amazon Resource Names
    /// (ARNs) and Amazon Web Services
    /// Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the Amazon Web Services General Reference.
    ///
    /// An Amazon Web Services conversion compresses the passed inline session
    /// policy, managed policy ARNs,
    /// and session tags into a packed binary format that has a separate limit. Your
    /// request can
    /// fail for this limit even if your plaintext meets the other requirements. The
    /// `PackedPolicySize` response element indicates by percentage how close the
    /// policies and tags for your request are to the upper size limit.
    ///
    /// Passing policies to this operation returns new
    /// temporary credentials. The resulting session's permissions are the
    /// intersection of the
    /// role's identity-based policy and the session policies. You can use the
    /// role's temporary
    /// credentials in subsequent Amazon Web Services API calls to access resources
    /// in the account that owns
    /// the role. You cannot use session policies to grant more permissions than
    /// those allowed
    /// by the identity-based policy of the role that is being assumed. For more
    /// information, see
    /// [Session
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) in the *IAM User Guide*.
    policy_arns: ?[]const PolicyDescriptorType = null,

    /// The Amazon Resource Name (ARN) of the SAML provider in IAM that describes
    /// the
    /// IdP.
    principal_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the role that the caller is assuming.
    role_arn: []const u8,

    /// The base64 encoded SAML authentication response provided by the IdP.
    ///
    /// For more information, see [Configuring a Relying Party and
    /// Adding
    /// Claims](https://docs.aws.amazon.com/IAM/latest/UserGuide/create-role-saml-IdP-tasks.html) in the *IAM User Guide*.
    saml_assertion: []const u8,
};

pub const AssumeRoleWithSAMLOutput = struct {
    /// The identifiers for the temporary security credentials that the operation
    /// returns.
    assumed_role_user: ?AssumedRoleUser = null,

    /// The value of the `Recipient` attribute of the
    /// `SubjectConfirmationData` element of the SAML assertion.
    audience: ?[]const u8 = null,

    /// The temporary security credentials, which include an access key ID, a secret
    /// access key,
    /// and a security (or session) token.
    ///
    /// The size of the security token that STS API operations return is not fixed.
    /// We
    /// strongly recommend that you make no assumptions about the maximum size.
    credentials: ?Credentials = null,

    /// The value of the `Issuer` element of the SAML assertion.
    issuer: ?[]const u8 = null,

    /// A hash value based on the concatenation of the following:
    ///
    /// * The `Issuer` response value.
    ///
    /// * The Amazon Web Services account ID.
    ///
    /// * The friendly name (the last part of the ARN) of the SAML provider in IAM.
    ///
    /// The combination of `NameQualifier` and `Subject` can be used to
    /// uniquely identify a user.
    ///
    /// The following pseudocode shows how the hash value is calculated:
    ///
    /// `BASE64 ( SHA1 ( "https://example.com/saml" + "123456789012" + "/MySAMLIdP"
    /// ) )`
    name_qualifier: ?[]const u8 = null,

    /// A percentage value that indicates the packed size of the session policies
    /// and session
    /// tags combined passed in the request. The request fails if the packed size is
    /// greater than 100 percent,
    /// which means the policies and tags exceeded the allowed space.
    packed_policy_size: ?i32 = null,

    /// The value in the `SourceIdentity` attribute in the SAML assertion. The
    /// source
    /// identity value persists across [chained
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html#iam-term-role-chaining)
    /// sessions.
    ///
    /// You can require users to set a source identity value when they assume a
    /// role. You do
    /// this by using the `sts:SourceIdentity` condition key in a role trust policy.
    /// That way, actions that are taken with the role are associated with that
    /// user. After the
    /// source identity is set, the value cannot be changed. It is present in the
    /// request for all
    /// actions that are taken by the role and persists across [chained
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html#id_roles_terms-and-concepts)
    /// sessions. You can configure your SAML identity provider to use an attribute
    /// associated with
    /// your users, like user name or email, as the source identity when calling
    /// `AssumeRoleWithSAML`. You do this by adding an attribute to the SAML
    /// assertion. For more information about using source identity, see [Monitor
    /// and control
    /// actions taken with assumed
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html) in the
    /// *IAM User Guide*.
    ///
    /// The regex used to validate this parameter is a string of characters
    /// consisting of upper- and lower-case alphanumeric characters with no spaces.
    /// You can
    /// also include underscores or any of the following characters: =,.@-
    source_identity: ?[]const u8 = null,

    /// The value of the `NameID` element in the `Subject` element of the
    /// SAML assertion.
    subject: ?[]const u8 = null,

    /// The format of the name ID, as defined by the `Format` attribute in the
    /// `NameID` element of the SAML assertion. Typical examples of the format are
    /// `transient` or `persistent`.
    ///
    /// If the format includes the prefix
    /// `urn:oasis:names:tc:SAML:2.0:nameid-format`, that prefix is removed. For
    /// example, `urn:oasis:names:tc:SAML:2.0:nameid-format:transient` is returned
    /// as
    /// `transient`. If the format includes any other prefix, the format is returned
    /// with no modifications.
    subject_type: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssumeRoleWithSAMLInput, options: CallOptions) !AssumeRoleWithSAMLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sts");

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssumeRoleWithSAMLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sts", "STS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AssumeRoleWithSAML&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(allocator, "&DurationSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.policy) |v| {
        try body_buf.appendSlice(allocator, "&Policy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.policy_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.arn) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyArns.member.{d}.arn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&PrincipalArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.principal_arn);
    try body_buf.appendSlice(allocator, "&RoleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_arn);
    try body_buf.appendSlice(allocator, "&SAMLAssertion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.saml_assertion);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssumeRoleWithSAMLOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssumeRoleWithSAMLResult")) break;
            },
            else => {},
        }
    }

    var result: AssumeRoleWithSAMLOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssumedRoleUser")) {
                    result.assumed_role_user = try serde.deserializeAssumedRoleUser(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Audience")) {
                    result.audience = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Issuer")) {
                    result.issuer = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NameQualifier")) {
                    result.name_qualifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PackedPolicySize")) {
                    result.packed_policy_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceIdentity")) {
                    result.source_identity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Subject")) {
                    result.subject = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubjectType")) {
                    result.subject_type = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ExpiredTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredTradeInTokenException")) {
        return .{ .arena = arena, .kind = .{ .expired_trade_in_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IDPCommunicationErrorException")) {
        return .{ .arena = arena, .kind = .{ .idp_communication_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IDPRejectedClaimException")) {
        return .{ .arena = arena, .kind = .{ .idp_rejected_claim_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthorizationMessageException")) {
        return .{ .arena = arena, .kind = .{ .invalid_authorization_message_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIdentityTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_identity_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "JWTPayloadSizeExceededException")) {
        return .{ .arena = arena, .kind = .{ .jwt_payload_size_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "OutboundWebIdentityFederationDisabledException")) {
        return .{ .arena = arena, .kind = .{ .outbound_web_identity_federation_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PackedPolicyTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .packed_policy_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionDisabledException")) {
        return .{ .arena = arena, .kind = .{ .region_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SessionDurationEscalationException")) {
        return .{ .arena = arena, .kind = .{ .session_duration_escalation_exception = .{
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
