const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const ProvidedContext = @import("provided_context.zig").ProvidedContext;
const Tag = @import("tag.zig").Tag;
const AssumedRoleUser = @import("assumed_role_user.zig").AssumedRoleUser;
const Credentials = @import("credentials.zig").Credentials;

/// Returns a set of temporary security credentials that you can use to access
/// Amazon Web Services
/// resources. These temporary credentials consist of an access key ID, a secret
/// access key,
/// and a security token. Typically, you use `AssumeRole` within your account or
/// for
/// cross-account access. For a comparison of `AssumeRole` with other API
/// operations
/// that produce temporary credentials, see [Requesting Temporary Security
/// Credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html) and [Compare STS
/// credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_sts-comparison.html) in the *IAM User Guide*.
///
/// **Permissions**
///
/// The temporary security credentials created by `AssumeRole` can be used to
/// make API calls to any Amazon Web Services service with the following
/// exception: You cannot call the
/// Amazon Web Services STS `GetFederationToken` or `GetSessionToken` API
/// operations.
///
/// (Optional) You can pass inline or managed session policies to this
/// operation. You can
/// pass a single JSON policy document to use as an inline session policy. You
/// can also specify
/// up to 10 managed policy Amazon Resource Names (ARNs) to use as managed
/// session policies.
/// The plaintext that you use for both inline and managed session policies
/// can't exceed 2,048
/// characters. Passing policies to this operation returns new
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
/// When you create a role, you create two policies: a role trust policy that
/// specifies
/// *who* can assume the role, and a permissions policy that specifies
/// *what* can be done with the role. You specify the trusted principal
/// that is allowed to assume the role in the role trust policy.
///
/// To assume a role from a different account, your Amazon Web Services account
/// must be trusted by the
/// role. The trust relationship is defined in the role's trust policy when the
/// role is
/// created. That trust policy states which accounts are allowed to delegate
/// that access to
/// users in the account.
///
/// A user who wants to access a role in a different account must also have
/// permissions that
/// are delegated from the account administrator. The administrator must attach
/// a policy that
/// allows the user to call `AssumeRole` for the ARN of the role in the other
/// account.
///
/// To allow a user to assume a role in the same account, you can do either of
/// the
/// following:
///
/// * Attach a policy to the user that allows the user to call `AssumeRole`
/// (as long as the role's trust policy trusts the account).
///
/// * Add the user as a principal directly in the role's trust policy.
///
/// You can do either because the role’s trust policy acts as an IAM
/// resource-based
/// policy. When a resource-based policy grants access to a principal in the
/// same account, no
/// additional identity-based policy is required. For more information about
/// trust policies and
/// resource-based policies, see [IAM
/// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html) in the
/// *IAM User Guide*.
///
/// **Tags**
///
/// (Optional) You can pass tag key-value pairs to your session. These tags are
/// called
/// session tags. For more information about session tags, see [Passing Session
/// Tags in
/// STS](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html)
/// in the
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
/// You can set the session tags as transitive. Transitive tags persist during
/// role
/// chaining. For more information, see [Chaining Roles
/// with Session
/// Tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining) in the *IAM User Guide*.
///
/// **Using MFA with AssumeRole**
///
/// (Optional) You can include multi-factor authentication (MFA) information
/// when you call
/// `AssumeRole`. This is useful for cross-account scenarios to ensure that the
/// user that assumes the role has been authenticated with an Amazon Web
/// Services MFA device. In that
/// scenario, the trust policy of the role being assumed includes a condition
/// that tests for
/// MFA authentication. If the caller does not include valid MFA information,
/// the request to
/// assume the role is denied. The condition in a trust policy that tests for
/// MFA
/// authentication might look like the following example.
///
/// `"Condition": {"Bool": {"aws:MultiFactorAuthPresent": true}}`
///
/// For more information, see [Configuring MFA-Protected API
/// Access](https://docs.aws.amazon.com/IAM/latest/UserGuide/MFAProtectedAPI.html)
/// in the *IAM User Guide* guide.
///
/// To use MFA with `AssumeRole`, you pass values for the
/// `SerialNumber` and `TokenCode` parameters. The
/// `SerialNumber` value identifies the user's hardware or virtual MFA device.
/// The `TokenCode` is the time-based one-time password (TOTP) that the MFA
/// device
/// produces.
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
    /// **Note:**
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const AssumeRoleOutput) void {
        if (self.source_identity) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AssumeRoleInput, options: Options) !AssumeRoleOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: AssumeRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("sts", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssumeRole&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(alloc, "&DurationSeconds=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.external_id) |v| {
        try body_buf.appendSlice(alloc, "&ExternalId=");
        try appendUrlEncoded(alloc, &body_buf, v);
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
    if (input.provided_contexts) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProvidedContexts.member.{d}.ContextAssertion=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.context_assertion) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ProvidedContexts.member.{d}.ProviderArn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.provider_arn) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&RoleArn=");
    try appendUrlEncoded(alloc, &body_buf, input.role_arn);
    try body_buf.appendSlice(alloc, "&RoleSessionName=");
    try appendUrlEncoded(alloc, &body_buf, input.role_session_name);
    if (input.serial_number) |v| {
        try body_buf.appendSlice(alloc, "&SerialNumber=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_identity) |v| {
        try body_buf.appendSlice(alloc, "&SourceIdentity=");
        try appendUrlEncoded(alloc, &body_buf, v);
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
    if (input.token_code) |v| {
        try body_buf.appendSlice(alloc, "&TokenCode=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.transitive_tag_keys) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TransitiveTagKeys.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !AssumeRoleOutput {
    _ = status;
    var result: AssumeRoleOutput = .{ .allocator = alloc };
    if (findElement(body, "PackedPolicySize")) |content| {
        result.packed_policy_size = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findElement(body, "SourceIdentity")) |content| {
        result.source_identity = try alloc.dupe(u8, content);
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
