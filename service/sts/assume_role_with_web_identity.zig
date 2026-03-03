const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const AssumedRoleUser = @import("assumed_role_user.zig").AssumedRoleUser;
const Credentials = @import("credentials.zig").Credentials;
const serde = @import("serde.zig");

pub const AssumeRoleWithWebIdentityInput = struct {
    /// The duration, in seconds, of the role session. The value can range from 900
    /// seconds (15
    /// minutes) up to the maximum session duration setting for the role. This
    /// setting can have a
    /// value from 1 hour to 12 hours. If you specify a value higher than this
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

    /// The fully qualified host component of the domain name of the OAuth 2.0
    /// identity
    /// provider. Do not specify this value for an OpenID Connect identity provider.
    ///
    /// Currently `www.amazon.com` and `graph.facebook.com` are the only
    /// supported identity providers for OAuth 2.0 access tokens. Do not include URL
    /// schemes and
    /// port numbers.
    ///
    /// Do not specify this value for OpenID Connect ID tokens.
    provider_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role that the caller is assuming.
    ///
    /// Additional considerations apply to Amazon Cognito identity pools that assume
    /// [cross-account IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-cross-account-resource-access.html). The trust policies of these roles must accept the
    /// `cognito-identity.amazonaws.com` service principal and must contain the
    /// `cognito-identity.amazonaws.com:aud` condition key to restrict role
    /// assumption to users from your intended identity pools. A policy that trusts
    /// Amazon Cognito
    /// identity pools without this condition creates a risk that a user from an
    /// unintended
    /// identity pool can assume the role. For more information, see [ Trust
    /// policies for
    /// IAM roles in Basic (Classic) authentication
    /// ](https://docs.aws.amazon.com/cognito/latest/developerguide/iam-roles.html#trust-policies) in the *Amazon Cognito
    /// Developer Guide*.
    role_arn: []const u8,

    /// An identifier for the assumed role session. Typically, you pass the name or
    /// identifier
    /// that is associated with the user who is using your application. That way,
    /// the temporary
    /// security credentials that your application will use are associated with that
    /// user. This
    /// session name is included as part of the ARN and assumed role ID in the
    /// `AssumedRoleUser` response element.
    ///
    /// For security purposes, administrators can view this field in [CloudTrail
    /// logs](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html#cloudtrail-integration_signin-tempcreds) to help identify who performed an action in Amazon Web Services. Your
    /// administrator might require that you specify your user name as the session
    /// name when you
    /// assume the role. For more information, see [
    /// `sts:RoleSessionName`
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_iam-condition-keys.html#ck_rolesessionname).
    ///
    /// The regex used to validate this parameter is a string of characters
    /// consisting of upper- and lower-case alphanumeric characters with no spaces.
    /// You can
    /// also include underscores or any of the following characters: =,.@-
    role_session_name: []const u8,

    /// The OAuth 2.0 access token or OpenID Connect ID token that is provided by
    /// the identity
    /// provider. Your application must get this token by authenticating the user
    /// who is using your
    /// application with a web identity provider before the application makes an
    /// `AssumeRoleWithWebIdentity` call. Timestamps in the token must be formatted
    /// as either an integer or a long integer. Tokens must be signed using either
    /// RSA keys (RS256,
    /// RS384, or RS512) or ECDSA keys (ES256, ES384, or ES512).
    web_identity_token: []const u8,
};

pub const AssumeRoleWithWebIdentityOutput = struct {
    /// The Amazon Resource Name (ARN) and the assumed role ID, which are
    /// identifiers that you
    /// can use to refer to the resulting temporary security credentials. For
    /// example, you can
    /// reference these credentials as a principal in a resource-based policy by
    /// using the ARN or
    /// assumed role ID. The ARN and ID include the `RoleSessionName` that you
    /// specified
    /// when you called `AssumeRole`.
    assumed_role_user: ?AssumedRoleUser = null,

    /// The intended audience (also known as client ID) of the web identity token.
    /// This is
    /// traditionally the client identifier issued to the application that requested
    /// the web
    /// identity token.
    audience: ?[]const u8 = null,

    /// The temporary security credentials, which include an access key ID, a secret
    /// access key,
    /// and a security token.
    ///
    /// The size of the security token that STS API operations return is not fixed.
    /// We
    /// strongly recommend that you make no assumptions about the maximum size.
    credentials: ?Credentials = null,

    /// A percentage value that indicates the packed size of the session policies
    /// and session
    /// tags combined passed in the request. The request fails if the packed size is
    /// greater than 100 percent,
    /// which means the policies and tags exceeded the allowed space.
    packed_policy_size: ?i32 = null,

    /// The issuing authority of the web identity token presented. For OpenID
    /// Connect ID
    /// tokens, this contains the value of the `iss` field. For OAuth 2.0 access
    /// tokens,
    /// this contains the value of the `ProviderId` parameter that was passed in the
    /// `AssumeRoleWithWebIdentity` request.
    provider: ?[]const u8 = null,

    /// The value of the source identity that is returned in the JSON web token
    /// (JWT) from the
    /// identity provider.
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
    /// sessions. You can configure your identity provider to use an attribute
    /// associated with your
    /// users, like user name or email, as the source identity when calling
    /// `AssumeRoleWithWebIdentity`. You do this by adding a claim to the JSON web
    /// token. To learn more about OIDC tokens and claims, see [Using Tokens with
    /// User
    /// Pools](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-tokens-with-identity-providers.html) in the *Amazon Cognito Developer Guide*.
    /// For more information about using source identity, see [Monitor and control
    /// actions taken with assumed
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html) in the
    /// *IAM User Guide*.
    ///
    /// The regex used to validate this parameter is a string of characters
    /// consisting of upper- and lower-case alphanumeric characters with no spaces.
    /// You can
    /// also include underscores or any of the following characters: =,.@-
    source_identity: ?[]const u8 = null,

    /// The unique user identifier that is returned by the identity provider. This
    /// identifier is
    /// associated with the `WebIdentityToken` that was submitted with the
    /// `AssumeRoleWithWebIdentity` call. The identifier is typically unique to the
    /// user and the application that acquired the `WebIdentityToken` (pairwise
    /// identifier). For OpenID Connect ID tokens, this field contains the value
    /// returned by the
    /// identity provider as the token's `sub` (Subject) claim.
    subject_from_web_identity_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssumeRoleWithWebIdentityInput, options: CallOptions) !AssumeRoleWithWebIdentityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssumeRoleWithWebIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sts", "STS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AssumeRoleWithWebIdentity&Version=2011-06-15");
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
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyArns.member.{d}.arn=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.arn) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.provider_id) |v| {
        try body_buf.appendSlice(allocator, "&ProviderId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&RoleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_arn);
    try body_buf.appendSlice(allocator, "&RoleSessionName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_session_name);
    try body_buf.appendSlice(allocator, "&WebIdentityToken=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.web_identity_token);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssumeRoleWithWebIdentityOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssumeRoleWithWebIdentityResult")) break;
            },
            else => {},
        }
    }

    var result: AssumeRoleWithWebIdentityOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssumedRoleUser")) {
                    result.assumed_role_user = try serde.deserializeAssumedRoleUser(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Audience")) {
                    result.audience = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "PackedPolicySize")) {
                    result.packed_policy_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Provider")) {
                    result.provider = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourceIdentity")) {
                    result.source_identity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SubjectFromWebIdentityToken")) {
                    result.subject_from_web_identity_token = try allocator.dupe(u8, try reader.readElementText());
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
