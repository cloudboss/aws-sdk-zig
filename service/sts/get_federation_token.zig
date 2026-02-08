const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const Tag = @import("tag.zig").Tag;
const Credentials = @import("credentials.zig").Credentials;
const FederatedUser = @import("federated_user.zig").FederatedUser;

/// Returns a set of temporary security credentials (consisting of an access key
/// ID, a
/// secret access key, and a security token) for a user. A typical use is in a
/// proxy
/// application that gets temporary security credentials on behalf of
/// distributed applications
/// inside a corporate network.
///
/// You must call the `GetFederationToken` operation using the long-term
/// security
/// credentials of an IAM user. As a result, this call is appropriate in
/// contexts where those credentials can be safeguarded, usually in a
/// server-based application.
/// For a comparison of `GetFederationToken` with the other API operations that
/// produce temporary credentials, see [Requesting Temporary Security
/// Credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html) and [Compare STS
/// credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_sts-comparison.html) in the *IAM User Guide*.
///
/// Although it is possible to call `GetFederationToken` using the security
/// credentials of an Amazon Web Services account root user rather than an IAM
/// user that you
/// create for the purpose of a proxy application, we do not recommend it. For
/// more
/// information, see [Safeguard your root user credentials and don't use them
/// for everyday
/// tasks](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#lock-away-credentials) in the
/// *IAM User Guide*.
///
/// **Note:**
///
/// You can create a mobile-based or browser-based app that can authenticate
/// users using
/// a web identity provider like Login with Amazon, Facebook, Google, or an
/// OpenID
/// Connect-compatible identity provider. In this case, we recommend that you
/// use [Amazon Cognito](http://aws.amazon.com/cognito/) or
/// `AssumeRoleWithWebIdentity`. For more information, see [Federation Through a
/// Web-based Identity
/// Provider](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity) in the
/// *IAM User Guide*.
///
/// **Session duration**
///
/// The temporary credentials are valid for the specified duration, from 900
/// seconds (15
/// minutes) up to a maximum of 129,600 seconds (36 hours). The default session
/// duration is
/// 43,200 seconds (12 hours). Temporary credentials obtained by using the root
/// user
/// credentials have a maximum duration of 3,600 seconds (1 hour).
///
/// **Permissions**
///
/// You can use the temporary credentials created by `GetFederationToken` in any
/// Amazon Web Services service with the following exceptions:
///
/// * You cannot call any IAM operations using the CLI or the Amazon Web
///   Services API. This
/// limitation does not apply to console sessions.
///
/// * You cannot call any STS operations except `GetCallerIdentity`.
///
/// You can use temporary credentials for single sign-on (SSO) to the console.
///
/// You must pass an inline or managed [session
/// policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) to
/// this operation. You can pass a single JSON policy document to use as an
/// inline session
/// policy. You can also specify up to 10 managed policy Amazon Resource Names
/// (ARNs) to use as
/// managed session policies. The plaintext that you use for both inline and
/// managed session
/// policies can't exceed 2,048 characters.
///
/// Though the session policy parameters are optional, if you do not pass a
/// policy, then the
/// resulting federated user session has no permissions. When you pass session
/// policies, the
/// session permissions are the intersection of the IAM user policies and the
/// session policies that you pass. This gives you a way to further restrict the
/// permissions
/// for a federated user. You cannot use session policies to grant more
/// permissions than those
/// that are defined in the permissions policy of the IAM user. For more
/// information, see [Session
/// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) in
/// the *IAM User Guide*. For information about using
/// `GetFederationToken` to create temporary security credentials, see
/// [GetFederationToken—Federation Through a Custom Identity
/// Broker](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_getfederationtoken).
///
/// You can use the credentials to access a resource that has a resource-based
/// policy. If
/// that policy specifically references the federated user session in the
/// `Principal` element of the policy, the session has the permissions allowed
/// by
/// the policy. These permissions are granted in addition to the permissions
/// granted by the
/// session policies.
///
/// **Tags**
///
/// (Optional) You can pass tag key-value pairs to your session. These are
/// called session
/// tags. For more information about session tags, see [Passing Session Tags in
/// STS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html)
/// in the
/// *IAM User Guide*.
///
/// **Note:**
///
/// You can create a mobile-based or browser-based app that can authenticate
/// users using
/// a web identity provider like Login with Amazon, Facebook, Google, or an
/// OpenID
/// Connect-compatible identity provider. In this case, we recommend that you
/// use [Amazon Cognito](http://aws.amazon.com/cognito/) or
/// `AssumeRoleWithWebIdentity`. For more information, see [Federation Through a
/// Web-based Identity
/// Provider](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity) in the
/// *IAM User Guide*.
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
/// Tag key–value pairs are not case sensitive, but case is preserved. This
/// means that you
/// cannot have separate `Department` and `department` tag keys. Assume
/// that the user that you are federating has the
/// `Department`=`Marketing` tag and you pass the
/// `department`=`engineering` session tag. `Department`
/// and `department` are not saved as separate tags, and the session tag passed
/// in
/// the request takes precedence over the user tag.
pub const GetFederationTokenInput = struct {
    /// The duration, in seconds, that the session should last. Acceptable durations
    /// for
    /// federation sessions range from 900 seconds (15 minutes) to 129,600 seconds
    /// (36 hours), with
    /// 43,200 seconds (12 hours) as the default. Sessions obtained using root user
    /// credentials are restricted to a maximum of 3,600 seconds (one hour). If the
    /// specified
    /// duration is longer than one hour, the session obtained by using root user
    /// credentials defaults to one hour.
    duration_seconds: ?i32 = null,

    /// The name of the federated user. The name is used as an identifier for the
    /// temporary
    /// security credentials (such as `Bob`). For example, you can reference the
    /// federated user name in a resource-based policy, such as in an Amazon S3
    /// bucket policy.
    ///
    /// The regex used to validate this parameter is a string of characters
    /// consisting of upper- and lower-case alphanumeric characters with no spaces.
    /// You can
    /// also include underscores or any of the following characters: =,.@-
    name: []const u8,

    /// An IAM policy in JSON format that you want to use as an inline session
    /// policy.
    ///
    /// You must pass an inline or managed [session
    /// policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) to
    /// this operation. You can pass a single JSON policy document to use as an
    /// inline session
    /// policy. You can also specify up to 10 managed policy Amazon Resource Names
    /// (ARNs) to use as
    /// managed session policies.
    ///
    /// This parameter is optional. However, if you do not pass any session
    /// policies, then the
    /// resulting federated user session has no permissions.
    ///
    /// When you pass session policies, the session permissions are the intersection
    /// of the
    /// IAM user policies and the session policies that you pass. This gives you
    /// a way to further restrict the permissions for a federated user. You cannot
    /// use session
    /// policies to grant more permissions than those that are defined in the
    /// permissions policy of
    /// the IAM user. For more information, see [Session
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) in
    /// the *IAM User Guide*.
    ///
    /// The resulting credentials can be used to access a resource that has a
    /// resource-based
    /// policy. If that policy specifically references the federated user session in
    /// the
    /// `Principal` element of the policy, the session has the permissions allowed
    /// by
    /// the policy. These permissions are granted in addition to the permissions
    /// that are granted
    /// by the session policies.
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
    /// to use as a
    /// managed session policy. The policies must exist in the same account as the
    /// IAM user that is requesting federated access.
    ///
    /// You must pass an inline or managed [session
    /// policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) to
    /// this operation. You can pass a single JSON policy document to use as an
    /// inline session
    /// policy. You can also specify up to 10 managed policy Amazon Resource Names
    /// (ARNs) to use as
    /// managed session policies. The plaintext that you use for both inline and
    /// managed session
    /// policies can't exceed 2,048 characters. You can provide up to 10 managed
    /// policy ARNs. For
    /// more information about ARNs, see [Amazon Resource Names (ARNs) and Amazon
    /// Web Services
    /// Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the Amazon Web Services General Reference.
    ///
    /// This parameter is optional. However, if you do not pass any session
    /// policies, then the
    /// resulting federated user session has no permissions.
    ///
    /// When you pass session policies, the session permissions are the intersection
    /// of the
    /// IAM user policies and the session policies that you pass. This gives you
    /// a way to further restrict the permissions for a federated user. You cannot
    /// use session
    /// policies to grant more permissions than those that are defined in the
    /// permissions policy of
    /// the IAM user. For more information, see [Session
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session) in
    /// the *IAM User Guide*.
    ///
    /// The resulting credentials can be used to access a resource that has a
    /// resource-based
    /// policy. If that policy specifically references the federated user session in
    /// the
    /// `Principal` element of the policy, the session has the permissions allowed
    /// by
    /// the policy. These permissions are granted in addition to the permissions
    /// that are granted
    /// by the session policies.
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
    policy_arns: ?[]const PolicyDescriptorType = null,

    /// A list of session tags. Each session tag consists of a key name and an
    /// associated value.
    /// For more information about session tags, see [Passing Session Tags in
    /// STS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html)
    /// in the
    /// *IAM User Guide*.
    ///
    /// This parameter is optional. You can pass up to 50 session tags. The
    /// plaintext session
    /// tag keys can’t exceed 128 characters and the values can’t exceed 256
    /// characters. For these
    /// and additional limits, see [IAM
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
    /// You can pass a session tag with the same key as a tag that is already
    /// attached to the
    /// user you are federating. When you do, session tags override a user tag with
    /// the same key.
    ///
    /// Tag key–value pairs are not case sensitive, but case is preserved. This
    /// means that you
    /// cannot have separate `Department` and `department` tag keys. Assume
    /// that the role has the `Department`=`Marketing` tag and you pass the
    /// `department`=`engineering` session tag. `Department`
    /// and `department` are not saved as separate tags, and the session tag passed
    /// in
    /// the request takes precedence over the role tag.
    tags: ?[]const Tag = null,
};

pub const GetFederationTokenOutput = struct {
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

    /// Identifiers for the federated user associated with the credentials (such as
    /// `arn:aws:sts::123456789012:federated-user/Bob` or
    /// `123456789012:Bob`). You can use the federated user's ARN in your
    /// resource-based policies, such as an Amazon S3 bucket policy.
    federated_user: ?FederatedUser = null,

    /// A percentage value that indicates the packed size of the session policies
    /// and session
    /// tags combined passed in the request. The request fails if the packed size is
    /// greater than 100 percent,
    /// which means the policies and tags exceeded the allowed space.
    packed_policy_size: ?i32 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const GetFederationTokenOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetFederationTokenInput, options: Options) !GetFederationTokenOutput {
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

    return try deserializeResponse(response.body, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetFederationTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("sts", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetFederationToken&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(alloc, "&DurationSeconds=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&Name=");
    try appendUrlEncoded(alloc, &body_buf, input.name);
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
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try appendUrlEncoded(alloc, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try appendUrlEncoded(alloc, &body_buf, item.value);
            }
        }
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

fn deserializeResponse(body: []const u8, alloc: std.mem.Allocator) !GetFederationTokenOutput {
    var result: GetFederationTokenOutput = .{ .allocator = alloc };
    if (findElement(body, "PackedPolicySize")) |content| {
        result.packed_policy_size = std.fmt.parseInt(i32, content, 10) catch null;
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
