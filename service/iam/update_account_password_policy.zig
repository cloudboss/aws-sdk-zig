const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateAccountPasswordPolicyInput = struct {
    /// Allows all IAM users in your account to use the Amazon Web Services
    /// Management Console to change their own
    /// passwords. For more information, see [Permitting
    /// IAM users to change their own
    /// passwords](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_passwords_enable-user-change.html) in the
    /// *IAM User Guide*.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that IAM users in the account do not
    /// automatically have permissions to change their own password.
    allow_users_to_change_password: ?bool = null,

    /// Prevents IAM users who are accessing the account via the Amazon Web Services
    /// Management Console from setting a
    /// new console password after their password has expired. The IAM user cannot
    /// access the
    /// console until an administrator resets the password.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that IAM users can change their passwords
    /// after they expire and continue to sign in as the user.
    ///
    /// In the Amazon Web Services Management Console, the custom password policy
    /// option **Allow
    /// users to change their own password** gives IAM users permissions to
    /// `iam:ChangePassword` for only their user and to the
    /// `iam:GetAccountPasswordPolicy` action. This option does not attach a
    /// permissions policy to each user, rather the permissions are applied at the
    /// account-level for all users by IAM. IAM users with
    /// `iam:ChangePassword` permission and active access keys can reset
    /// their own expired console password using the CLI or API.
    hard_expiry: ?bool = null,

    /// The number of days that an IAM user password is valid.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `0`. The result is that IAM user passwords never expire.
    max_password_age: ?i32 = null,

    /// The minimum number of characters allowed in an IAM user password.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `6`.
    minimum_password_length: ?i32 = null,

    /// Specifies the number of previous passwords that IAM users are prevented from
    /// reusing.
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `0`. The result is that IAM users are not prevented from reusing
    /// previous passwords.
    password_reuse_prevention: ?i32 = null,

    /// Specifies whether IAM user passwords must contain at least one lowercase
    /// character
    /// from the ISO basic Latin alphabet (a to z).
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that passwords do not require at least one
    /// lowercase character.
    require_lowercase_characters: ?bool = null,

    /// Specifies whether IAM user passwords must contain at least one numeric
    /// character (0
    /// to 9).
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that passwords do not require at least one
    /// numeric character.
    require_numbers: ?bool = null,

    /// Specifies whether IAM user passwords must contain at least one of the
    /// following
    /// non-alphanumeric characters:
    ///
    /// ! @ # $ % ^ & * ( ) _ + - = [ ] { } | '
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that passwords do not require at least one
    /// symbol character.
    require_symbols: ?bool = null,

    /// Specifies whether IAM user passwords must contain at least one uppercase
    /// character
    /// from the ISO basic Latin alphabet (A to Z).
    ///
    /// If you do not specify a value for this parameter, then the operation uses
    /// the default
    /// value of `false`. The result is that passwords do not require at least one
    /// uppercase character.
    require_uppercase_characters: ?bool = null,
};

pub const UpdateAccountPasswordPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountPasswordPolicyInput, options: CallOptions) !UpdateAccountPasswordPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountPasswordPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateAccountPasswordPolicy&Version=2010-05-08");
    if (input.allow_users_to_change_password) |v| {
        try body_buf.appendSlice(allocator, "&AllowUsersToChangePassword=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.hard_expiry) |v| {
        try body_buf.appendSlice(allocator, "&HardExpiry=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.max_password_age) |v| {
        try body_buf.appendSlice(allocator, "&MaxPasswordAge=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.minimum_password_length) |v| {
        try body_buf.appendSlice(allocator, "&MinimumPasswordLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.password_reuse_prevention) |v| {
        try body_buf.appendSlice(allocator, "&PasswordReusePrevention=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.require_lowercase_characters) |v| {
        try body_buf.appendSlice(allocator, "&RequireLowercaseCharacters=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.require_numbers) |v| {
        try body_buf.appendSlice(allocator, "&RequireNumbers=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.require_symbols) |v| {
        try body_buf.appendSlice(allocator, "&RequireSymbols=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.require_uppercase_characters) |v| {
        try body_buf.appendSlice(allocator, "&RequireUppercaseCharacters=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountPasswordPolicyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: UpdateAccountPasswordPolicyOutput = .{};

    return result;
}
