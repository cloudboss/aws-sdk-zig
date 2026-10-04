const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityType = @import("identity_type.zig").IdentityType;
const Tag = @import("tag.zig").Tag;
const UserRole = @import("user_role.zig").UserRole;
const User = @import("user.zig").User;

pub const RegisterUserInput = struct {
    /// The ID for the Amazon Web Services account that the user is in. Currently,
    /// you use the ID for the
    /// Amazon Web Services account that contains your Amazon Quick Sight account.
    aws_account_id: []const u8,

    /// The URL of the custom OpenID Connect (OIDC) provider that provides identity
    /// to let a user federate
    /// into Quick Sight with an associated Identity and Access Management(IAM)
    /// role. This parameter should
    /// only be used when `ExternalLoginFederationProviderType` parameter is set to
    /// `CUSTOM_OIDC`.
    custom_federation_provider_url: ?[]const u8 = null,

    /// (Enterprise edition only) The name of the custom permissions profile that
    /// you want to
    /// assign to this user. Customized permissions allows you to control a user's
    /// access by
    /// restricting access the following operations:
    ///
    /// * Create and update data sources
    ///
    /// * Create and update datasets
    ///
    /// * Create and update email reports
    ///
    /// * Subscribe to email reports
    ///
    /// To add custom permissions to an existing user, use `
    /// [UpdateUser](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_UpdateUser.html)
    /// ` instead.
    ///
    /// A set of custom permissions includes any combination of these restrictions.
    /// Currently,
    /// you need to create the profile names for custom permission sets by using the
    /// Quick Sight
    /// console. Then, you use the `RegisterUser` API operation to assign the named
    /// set of
    /// permissions to a Quick Sight user.
    ///
    /// Quick Sight custom permissions are applied through IAM policies. Therefore,
    /// they
    /// override the permissions typically granted by assigning Quick Sight users to
    /// one of the
    /// default security cohorts in Quick Sight (admin, author, reader, admin pro,
    /// author pro, reader pro).
    ///
    /// This feature is available only to Quick Sight Enterprise edition
    /// subscriptions.
    custom_permissions_name: ?[]const u8 = null,

    /// The email address of the user that you want to register.
    email: []const u8,

    /// The type of supported external login provider that provides identity to let
    /// a user federate into Amazon Quick Sight with an associated Identity and
    /// Access Management(IAM) role. The type of supported external login provider
    /// can be one of the following.
    ///
    /// * `COGNITO`: Amazon Cognito. The provider URL is
    ///   cognito-identity.amazonaws.com. When choosing the `COGNITO` provider type,
    ///   don’t use the "CustomFederationProviderUrl" parameter which is only needed
    ///   when the external provider is custom.
    ///
    /// * `CUSTOM_OIDC`: Custom OpenID Connect (OIDC) provider. When choosing
    ///   `CUSTOM_OIDC` type, use the `CustomFederationProviderUrl` parameter to
    ///   provide the custom OIDC provider URL.
    external_login_federation_provider_type: ?[]const u8 = null,

    /// The identity ID for a user in the external login provider.
    external_login_id: ?[]const u8 = null,

    /// The ARN of the IAM user or role that you are registering with Amazon Quick
    /// Sight.
    iam_arn: ?[]const u8 = null,

    /// The identity type that your Quick Sight account uses to manage the identity
    /// of users.
    identity_type: IdentityType,

    /// The namespace. Currently, you should set this to `default`.
    namespace: []const u8,

    /// You need to use this parameter only when you register one or more users
    /// using an assumed
    /// IAM role. You don't need to provide the session name for other scenarios,
    /// for example when
    /// you are registering an IAM user or an Amazon Quick Sight user. You can
    /// register multiple
    /// users using the same IAM role if each user has a different session name. For
    /// more
    /// information on assuming IAM roles, see [
    /// `assume-role`
    /// ](https://docs.aws.amazon.com/cli/latest/reference/sts/assume-role.html) in
    /// the *CLI Reference.*
    session_name: ?[]const u8 = null,

    /// The tags to associate with the user.
    tags: ?[]const Tag = null,

    /// The Amazon Quick Sight user name that you want to create for the user you
    /// are
    /// registering.
    user_name: ?[]const u8 = null,

    /// The Amazon Quick Sight role for the user. The user role can be one of the
    /// following:
    ///
    /// * `READER`: A user who has read-only access to dashboards.
    ///
    /// * `AUTHOR`: A user who can create data sources, datasets, analyses, and
    /// dashboards.
    ///
    /// * `ADMIN`: A user who is an author, who can also manage Amazon Quick Sight
    /// settings.
    ///
    /// * `READER_PRO`: Reader Pro adds Generative BI capabilities to the Reader
    ///   role. Reader Pros have access to Amazon Q in Quick Sight, can build
    ///   stories with Amazon Q, and can generate executive summaries from
    ///   dashboards.
    ///
    /// * `AUTHOR_PRO`: Author Pro adds Generative BI capabilities to the Author
    ///   role. Author Pros can author dashboards with natural language with Amazon
    ///   Q, build stories with Amazon Q, create Topics for Q&A, and generate
    ///   executive summaries from dashboards.
    ///
    /// * `ADMIN_PRO`: Admin Pros are Author Pros who can also manage Amazon Quick
    ///   Sight administrative settings. Admin Pro users are billed at Author Pro
    ///   pricing.
    ///
    /// * `RESTRICTED_READER`: This role isn't currently available for
    /// use.
    ///
    /// * `RESTRICTED_AUTHOR`: This role isn't currently available for
    /// use.
    user_role: UserRole,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .custom_federation_provider_url = "CustomFederationProviderUrl",
        .custom_permissions_name = "CustomPermissionsName",
        .email = "Email",
        .external_login_federation_provider_type = "ExternalLoginFederationProviderType",
        .external_login_id = "ExternalLoginId",
        .iam_arn = "IamArn",
        .identity_type = "IdentityType",
        .namespace = "Namespace",
        .session_name = "SessionName",
        .tags = "Tags",
        .user_name = "UserName",
        .user_role = "UserRole",
    };
};

pub const RegisterUserOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The user's user name.
    user: ?User = null,

    /// The URL the user visits to complete registration and provide a password.
    /// This is
    /// returned only for users with an identity type of `QUICKSIGHT`.
    user_invitation_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .status = "Status",
        .user = "User",
        .user_invitation_url = "UserInvitationUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterUserInput, options: CallOptions) !RegisterUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/namespaces/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/users");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.custom_federation_provider_url) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomFederationProviderUrl\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_permissions_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomPermissionsName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Email\":");
    try aws.json.writeValue(@TypeOf(input.email), input.email, allocator, &body_buf);
    has_prev = true;
    if (input.external_login_federation_provider_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExternalLoginFederationProviderType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.external_login_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExternalLoginId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.iam_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IamArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IdentityType\":");
    try aws.json.writeValue(@TypeOf(input.identity_type), input.identity_type, allocator, &body_buf);
    has_prev = true;
    if (input.session_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SessionName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UserName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UserRole\":");
    try aws.json.writeValue(@TypeOf(input.user_role), input.user_role, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterUserOutput {
    var result: RegisterUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterUserOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
