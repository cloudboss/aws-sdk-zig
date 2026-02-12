const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const AssumedRoleUser = @import("assumed_role_user.zig").AssumedRoleUser;
const Credentials = @import("credentials.zig").Credentials;
const serde = @import("serde.zig");

/// Returns a set of temporary security credentials for users who have been
/// authenticated
/// via a SAML authentication response. This operation provides a mechanism for
/// tying an
/// enterprise identity store or directory to role-based Amazon Web Services
/// access without user-specific
/// credentials or configuration. For a comparison of `AssumeRoleWithSAML` with
/// the
/// other API operations that produce temporary credentials, see [Requesting
/// Temporary Security
/// Credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html) and [Compare STS
/// credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_sts-comparison.html) in the *IAM User Guide*.
///
/// The temporary security credentials returned by this operation consist of an
/// access key
/// ID, a secret access key, and a security token. Applications can use these
/// temporary
/// security credentials to sign calls to Amazon Web Services services.
///
/// **Note:**
///
/// AssumeRoleWithSAML will not work on IAM Identity Center managed roles. These
/// roles' names start
/// with `AWSReservedSSO_`.
///
/// **Session Duration**
///
/// By default, the temporary security credentials created by
/// `AssumeRoleWithSAML` last for one hour. However, you can use the optional
/// `DurationSeconds` parameter to specify the duration of your session. Your
/// role session lasts for the duration that you specify, or until the time
/// specified in the
/// SAML authentication response's `SessionNotOnOrAfter` value, whichever is
/// shorter. You can provide a `DurationSeconds` value from 900 seconds (15
/// minutes)
/// up to the maximum session duration setting for the role. This setting can
/// have a value from
/// 1 hour to 12 hours. To learn how to view the maximum value for your role,
/// see [View the
/// Maximum Session Duration Setting for a
/// Role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session) in the
/// *IAM User Guide*. The maximum session duration limit applies when
/// you use the `AssumeRole*` API operations or the `assume-role*` CLI
/// commands. However the limit does not apply when you use those operations to
/// create a
/// console URL. For more information, see [Using IAM
/// Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html)
/// in the
/// *IAM User Guide*.
///
/// **Note:**
///
/// [Role
/// chaining](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html#iam-term-role-chaining) limits your CLI or Amazon Web Services API role
/// session to a maximum of one hour. When you use the `AssumeRole` API
/// operation
/// to assume a role, you can specify the duration of your role session with the
/// `DurationSeconds` parameter. You can specify a parameter value of up to
/// 43200 seconds (12 hours), depending on the maximum session duration setting
/// for your
/// role. However, if you assume a role using role chaining and provide a
/// `DurationSeconds` parameter value greater than one hour, the operation
/// fails.
///
/// **Permissions**
///
/// The temporary security credentials created by `AssumeRoleWithSAML` can be
/// used to make API calls to any Amazon Web Services service with the following
/// exception: you cannot call
/// the STS `GetFederationToken` or `GetSessionToken` API
/// operations.
///
/// (Optional) You can pass inline or managed [session
/// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) to
/// this operation. You can pass a single JSON policy document to use as an
/// inline session
/// policy. You can also specify up to 10 managed policy Amazon Resource Names
/// (ARNs) to use as
/// managed session policies. The plaintext that you use for both inline and
/// managed session
/// policies can't exceed 2,048 characters. Passing policies to this operation
/// returns new
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
/// Calling `AssumeRoleWithSAML` does not require the use of Amazon Web Services
/// security
/// credentials. The identity of the caller is validated by using keys in the
/// metadata document
/// that is uploaded for the SAML provider entity for your identity provider.
///
/// **Important:**
///
/// Calling `AssumeRoleWithSAML` can result in an entry in your CloudTrail logs.
/// The entry includes the value in the `NameID` element of the SAML assertion.
/// We recommend that you use a `NameIDType` that is not associated with any
/// personally identifiable information (PII). For example, you could instead
/// use the
/// persistent identifier
/// (`urn:oasis:names:tc:SAML:2.0:nameid-format:persistent`).
///
/// **Tags**
///
/// (Optional) You can configure your IdP to pass attributes into your SAML
/// assertion as
/// session tags. Each session tag consists of a key name and an associated
/// value. For more
/// information about session tags, see [Passing Session Tags in
/// STS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html)
/// in the
/// *IAM User Guide*.
///
/// You can pass up to 50 session tags. The plaintext session tag keys can’t
/// exceed 128
/// characters and the values can’t exceed 256 characters. For these and
/// additional limits, see
/// [IAM
/// and STS Character
/// Limits](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length) in the *IAM User Guide*.
///
/// **Note:**
///
/// An Amazon Web Services conversion compresses the passed inline session
/// policy, managed policy ARNs,
/// and session tags into a packed binary format that has a separate limit. Your
/// request can
/// fail for this limit even if your plaintext meets the other requirements. The
/// `PackedPolicySize` response element indicates by percentage how close the
/// policies and tags for your request are to the upper size limit.
///
/// You can pass a session tag with the same key as a tag that is attached to
/// the role. When
/// you do, session tags override the role's tags with the same key.
///
/// An administrator must grant you the permissions necessary to pass session
/// tags. The
/// administrator can also create granular permissions to allow you to pass only
/// specific
/// session tags. For more information, see [Tutorial: Using Tags
/// for Attribute-Based Access
/// Control](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_attribute-based-access-control.html) in the
/// *IAM User Guide*.
///
/// You can set the session tags as transitive. Transitive tags persist during
/// role
/// chaining. For more information, see [Chaining Roles
/// with Session
/// Tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining) in the *IAM User Guide*.
///
/// **SAML Configuration**
///
/// Before your application can call `AssumeRoleWithSAML`, you must configure
/// your SAML identity provider (IdP) to issue the claims required by Amazon Web
/// Services. Additionally, you
/// must use Identity and Access Management (IAM) to create a SAML provider
/// entity in your Amazon Web Services account that
/// represents your identity provider. You must also create an IAM role that
/// specifies this
/// SAML provider in its trust policy.
///
/// For more information, see the following resources:
///
/// * [About
/// SAML 2.0-based
/// Federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml.html) in the *IAM User Guide*.
///
/// * [Creating SAML Identity
///   Providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml.html) in the
/// *IAM User Guide*.
///
/// * [Configuring
/// a Relying Party and
/// Claims](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml_relying-party.html) in the *IAM User Guide*.
///
/// * [Creating a Role for SAML 2.0
///   Federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_saml.html) in the
/// *IAM User Guide*.
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *AssumeRoleWithSAMLOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AssumeRoleWithSAMLInput, options: Options) !AssumeRoleWithSAMLOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AssumeRoleWithSAMLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("sts", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssumeRoleWithSAML&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(alloc, "&DurationSeconds=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.policy) |v| {
        try body_buf.appendSlice(alloc, "&Policy=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.policy_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyArns.member.{d}.arn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.arn) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&PrincipalArn=");
    try appendUrlEncoded(alloc, &body_buf, input.principal_arn);
    try body_buf.appendSlice(alloc, "&RoleArn=");
    try appendUrlEncoded(alloc, &body_buf, input.role_arn);
    try body_buf.appendSlice(alloc, "&SAMLAssertion=");
    try appendUrlEncoded(alloc, &body_buf, input.saml_assertion);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AssumeRoleWithSAMLOutput {
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
                    result.assumed_role_user = try serde.deserializeAssumedRoleUser(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Audience")) {
                    result.audience = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Issuer")) {
                    result.issuer = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NameQualifier")) {
                    result.name_qualifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PackedPolicySize")) {
                    result.packed_policy_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceIdentity")) {
                    result.source_identity = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Subject")) {
                    result.subject = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubjectType")) {
                    result.subject_type = try alloc.dupe(u8, try reader.readElementText());
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
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestId") orelse "";

    if (std.mem.eql(u8, error_code, "ExpiredTokenException")) {
        return .{ .expired_token_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ExpiredTradeInTokenException")) {
        return .{ .expired_trade_in_token_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "IDPCommunicationErrorException")) {
        return .{ .idp_communication_error_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "IDPRejectedClaimException")) {
        return .{ .idp_rejected_claim_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAuthorizationMessageException")) {
        return .{ .invalid_authorization_message_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIdentityTokenException")) {
        return .{ .invalid_identity_token_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "JWTPayloadSizeExceededException")) {
        return .{ .jwt_payload_size_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "OutboundWebIdentityFederationDisabledException")) {
        return .{ .outbound_web_identity_federation_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "PackedPolicyTooLargeException")) {
        return .{ .packed_policy_too_large_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "RegionDisabledException")) {
        return .{ .region_disabled_exception = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "SessionDurationEscalationException")) {
        return .{ .session_duration_escalation_exception = .{
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
