const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const ProvidedContext = @import("provided_context.zig").ProvidedContext;
const Tag = @import("tag.zig").Tag;
const AssumedRoleUser = @import("assumed_role_user.zig").AssumedRoleUser;
const Credentials = @import("credentials.zig").Credentials;
const serde = @import("serde.zig");

pub const AssumeRoleInput = struct {
    /// The duration, in seconds, of the role session. The value specified can range
    /// from 900
    /// seconds (15 minutes) up to the maximum session duration set for the role.
    /// The maximum
    /// session duration setting can have a value from 1 hour to 12 hours. If you
    /// specify a value
    /// higher than this setting or the administrator setting (whichever is lower),
    /// the operation
    /// fails. For example, if you specify a session duration of 12 hours, but your
    /// administrator
    /// set the maximum session duration to 6 hours, your operation fails.
    ///
    /// Role chaining limits your Amazon Web Services CLI or Amazon Web Services API
    /// role session to a maximum of one hour.
    /// When you use the `AssumeRole` API operation to assume a role, you can
    /// specify
    /// the duration of your role session with the `DurationSeconds` parameter. You
    /// can
    /// specify a parameter value of up to 43200 seconds (12 hours), depending on
    /// the maximum
    /// session duration setting for your role. However, if you assume a role using
    /// role chaining
    /// and provide a `DurationSeconds` parameter value greater than one hour, the
    /// operation fails. To learn how to view the maximum value for your role, see
    /// [Update the maximum session duration for a
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_update-role-settings.html#id_roles_update-session-duration).
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

    /// A unique identifier that might be required when you assume a role in another
    /// account. If
    /// the administrator of the account to which the role belongs provided you with
    /// an external
    /// ID, then provide that value in the `ExternalId` parameter. This value can be
    /// any
    /// string, such as a passphrase or account number. A cross-account role is
    /// usually set up to
    /// trust everyone in an account. Therefore, the administrator of the trusting
    /// account might
    /// send an external ID to the administrator of the trusted account. That way,
    /// only someone
    /// with the ID can assume the role, rather than everyone in the account. For
    /// more information
    /// about the external ID, see [How to Use an External ID
    /// When Granting Access to Your Amazon Web Services Resources to a Third
    /// Party](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html) in the
    /// *IAM User Guide*.
    ///
    /// The regex used to validate this parameter is a string of
    /// characters consisting of upper- and lower-case alphanumeric characters with
    /// no spaces.
    /// You can also include underscores or any of the following characters:
    /// +=,.@:\/-
    external_id: ?[]const u8 = null,

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
    /// An Amazon Web Services conversion compresses the passed inline session
    /// policy, managed policy ARNs,
    /// and session tags into a packed binary format that has a separate limit. Your
    /// request can
    /// fail for this limit even if your plaintext meets the other requirements. The
    /// `PackedPolicySize` response element indicates by percentage how close the
    /// policies and tags for your request are to the upper size limit.
    ///
    /// For more information about role session permissions, see [Session
    /// policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session).
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

    /// A list of previously acquired trusted context assertions in the format of a
    /// JSON array.
    /// The trusted context assertion is signed and encrypted by Amazon Web Services
    /// STS.
    ///
    /// The following is an example of a `ProvidedContext` value that includes a
    /// single trusted context assertion and the ARN of the context provider from
    /// which the trusted
    /// context assertion was generated.
    ///
    /// `[{"ProviderArn":"arn:aws:iam::aws:contextProvider/IdentityCenter","ContextAssertion":"trusted-context-assertion"}]`
    provided_contexts: ?[]const ProvidedContext = null,

    /// The Amazon Resource Name (ARN) of the role to assume.
    role_arn: []const u8,

    /// An identifier for the assumed role session.
    ///
    /// Use the role session name to uniquely identify a session when the same role
    /// is assumed
    /// by different principals or for different reasons. In cross-account
    /// scenarios, the role
    /// session name is visible to, and can be logged by the account that owns the
    /// role. The role
    /// session name is also used in the ARN of the assumed role principal. This
    /// means that
    /// subsequent cross-account API requests that use the temporary security
    /// credentials will
    /// expose the role session name to the external account in their CloudTrail
    /// logs.
    ///
    /// For security purposes, administrators can view this field in [CloudTrail
    /// logs](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-integration.html#cloudtrail-integration_signin-tempcreds) to help identify who performed an action in Amazon Web Services. Your
    /// administrator might require that you specify your user name as the session
    /// name when you
    /// assume the role. For more information, see [
    /// `sts:RoleSessionName`
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_iam-condition-keys.html#ck_rolesessionname).
    ///
    /// The regex used to validate this parameter is a string of
    /// characters consisting of upper- and lower-case alphanumeric characters with
    /// no spaces.
    /// You can also include underscores or any of the following characters: +=,.@-
    role_session_name: []const u8,

    /// The identification number of the MFA device that is associated with the user
    /// who is
    /// making the `AssumeRole` call. Specify this value if the trust policy of the
    /// role
    /// being assumed includes a condition that requires MFA authentication. The
    /// value is either
    /// the serial number for a hardware device (such as `GAHT12345678`) or an
    /// Amazon
    /// Resource Name (ARN) for a virtual device (such as
    /// `arn:aws:iam::123456789012:mfa/user`).
    ///
    /// The regex used to validate this parameter is a string of
    /// characters consisting of upper- and lower-case alphanumeric characters with
    /// no spaces.
    /// You can also include underscores or any of the following characters:
    /// +=/:,.@-
    serial_number: ?[]const u8 = null,

    /// The source identity specified by the principal that is calling the
    /// `AssumeRole` operation. The source identity value persists across [chained
    /// role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html#iam-term-role-chaining) sessions.
    ///
    /// You can require users to specify a source identity when they assume a role.
    /// You do this
    /// by using the [
    /// `sts:SourceIdentity`
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html#condition-keys-sourceidentity) condition key in a role trust policy. You
    /// can use source identity information in CloudTrail logs to determine who took
    /// actions with a
    /// role. You can use the `aws:SourceIdentity` condition key to further control
    /// access to Amazon Web Services resources based on the value of source
    /// identity. For more information about
    /// using source identity, see [Monitor and control
    /// actions taken with assumed
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html) in the
    /// *IAM User Guide*.
    ///
    /// The regex used to validate this parameter is a string of characters
    /// consisting of upper-
    /// and lower-case alphanumeric characters with no spaces. You can also include
    /// underscores or
    /// any of the following characters: +=,.@-. You cannot use a value that begins
    /// with the text
    /// `aws:`. This prefix is reserved for Amazon Web Services internal use.
    source_identity: ?[]const u8 = null,

    /// A list of session tags that you want to pass. Each session tag consists of a
    /// key name
    /// and an associated value. For more information about session tags, see
    /// [Tagging Amazon Web Services STS
    /// Sessions](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html) in the *IAM User Guide*.
    ///
    /// This parameter is optional. You can pass up to 50 session tags. The
    /// plaintext session
    /// tag keys can’t exceed 128 characters, and the values can’t exceed 256
    /// characters. For these
    /// and additional limits, see [IAM
    /// and STS Character
    /// Limits](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length) in the *IAM User Guide*.
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
    /// role. When you do, session tags override a role tag with the same key.
    ///
    /// Tag key–value pairs are not case sensitive, but case is preserved. This
    /// means that you
    /// cannot have separate `Department` and `department` tag keys. Assume
    /// that the role has the `Department`=`Marketing` tag and you pass the
    /// `department`=`engineering` session tag. `Department`
    /// and `department` are not saved as separate tags, and the session tag passed
    /// in
    /// the request takes precedence over the role tag.
    ///
    /// Additionally, if you used temporary credentials to perform this operation,
    /// the new
    /// session inherits any transitive session tags from the calling session. If
    /// you pass a
    /// session tag with the same key as an inherited tag, the operation fails. To
    /// view the
    /// inherited tags for a session, see the CloudTrail logs. For more information,
    /// see [Viewing Session Tags in
    /// CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_ctlogs) in the
    /// *IAM User Guide*.
    tags: ?[]const Tag = null,

    /// The value provided by the MFA device, if the trust policy of the role being
    /// assumed
    /// requires MFA. (In other words, if the policy includes a condition that tests
    /// for MFA). If
    /// the role being assumed requires MFA and if the `TokenCode` value is missing
    /// or
    /// expired, the `AssumeRole` call returns an "access denied" error.
    ///
    /// The format for this parameter, as described by its regex pattern, is a
    /// sequence of six
    /// numeric digits.
    token_code: ?[]const u8 = null,

    /// A list of keys for session tags that you want to set as transitive. If you
    /// set a tag key
    /// as transitive, the corresponding key and value passes to subsequent sessions
    /// in a role
    /// chain. For more information, see [Chaining Roles
    /// with Session
    /// Tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining) in the *IAM User Guide*.
    ///
    /// This parameter is optional. The transitive status of a session tag does not
    /// impact its
    /// packed binary size.
    ///
    /// If you choose not to specify a transitive tag key, then no tags are passed
    /// from this
    /// session to any subsequent sessions.
    transitive_tag_keys: ?[]const []const u8 = null,
};

pub const AssumeRoleOutput = struct {
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

    /// The temporary security credentials, which include an access key ID, a secret
    /// access key,
    /// and a security (or session) token.
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

    /// The source identity specified by the principal that is calling the
    /// `AssumeRole` operation.
    ///
    /// You can require users to specify a source identity when they assume a role.
    /// You do this
    /// by using the `sts:SourceIdentity` condition key in a role trust policy. You
    /// can
    /// use source identity information in CloudTrail logs to determine who took
    /// actions with a role.
    /// You can use the `aws:SourceIdentity` condition key to further control access
    /// to
    /// Amazon Web Services resources based on the value of source identity. For
    /// more information about using
    /// source identity, see [Monitor and control
    /// actions taken with assumed
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_monitor.html) in the
    /// *IAM User Guide*.
    ///
    /// The regex used to validate this parameter is a string of characters
    /// consisting of upper-
    /// and lower-case alphanumeric characters with no spaces. You can also include
    /// underscores or
    /// any of the following characters: =,.@-
    source_identity: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssumeRoleInput, options: CallOptions) !AssumeRoleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssumeRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sts", "STS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AssumeRole&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(allocator, "&DurationSeconds=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.external_id) |v| {
        try body_buf.appendSlice(allocator, "&ExternalId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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
    if (input.provided_contexts) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.context_assertion) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProvidedContexts.member.{d}.ContextAssertion=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.provider_arn) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProvidedContexts.member.{d}.ProviderArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&RoleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_arn);
    try body_buf.appendSlice(allocator, "&RoleSessionName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_session_name);
    if (input.serial_number) |v| {
        try body_buf.appendSlice(allocator, "&SerialNumber=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_identity) |v| {
        try body_buf.appendSlice(allocator, "&SourceIdentity=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }
    if (input.token_code) |v| {
        try body_buf.appendSlice(allocator, "&TokenCode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.transitive_tag_keys) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TransitiveTagKeys.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssumeRoleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssumeRoleResult")) break;
            },
            else => {},
        }
    }

    var result: AssumeRoleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssumedRoleUser")) {
                    result.assumed_role_user = try serde.deserializeAssumedRoleUser(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "PackedPolicySize")) {
                    result.packed_policy_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SourceIdentity")) {
                    result.source_identity = try allocator.dupe(u8, try reader.readElementText());
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
