const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Credentials = @import("credentials.zig").Credentials;
const serde = @import("serde.zig");

/// Returns a set of temporary credentials for an Amazon Web Services account or
/// IAM user.
/// The credentials consist of an access key ID, a secret access key, and a
/// security token.
/// Typically, you use `GetSessionToken` if you want to use MFA to protect
/// programmatic calls to specific Amazon Web Services API operations like
/// Amazon EC2
/// `StopInstances`.
///
/// MFA-enabled IAM users must call `GetSessionToken` and submit
/// an MFA code that is associated with their MFA device. Using the temporary
/// security
/// credentials that the call returns, IAM users can then make programmatic
/// calls to API operations that require MFA authentication. An incorrect MFA
/// code causes the
/// API to return an access denied error. For a comparison of `GetSessionToken`
/// with
/// the other API operations that produce temporary credentials, see [Requesting
/// Temporary Security
/// Credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html) and [Compare STS
/// credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_sts-comparison.html) in the *IAM User Guide*.
///
/// **Note:**
///
/// No permissions are required for users to perform this operation. The purpose
/// of the
/// `sts:GetSessionToken` operation is to authenticate the user using MFA. You
/// cannot use policies to control authentication operations. For more
/// information, see
/// [Permissions for
/// GetSessionToken](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_getsessiontoken.html) in the
/// *IAM User Guide*.
///
/// **Session Duration**
///
/// The `GetSessionToken` operation must be called by using the long-term Amazon
/// Web Services
/// security credentials of an IAM user. Credentials that are created by IAM
/// users are valid for the duration that you specify. This duration can range
/// from 900 seconds (15 minutes) up to a maximum of 129,600 seconds (36 hours),
/// with a default
/// of 43,200 seconds (12 hours). Credentials based on account credentials can
/// range from 900
/// seconds (15 minutes) up to 3,600 seconds (1 hour), with a default of 1 hour.
///
/// **Permissions**
///
/// The temporary security credentials created by `GetSessionToken` can be used
/// to make API calls to any Amazon Web Services service with the following
/// exceptions:
///
/// * You cannot call any IAM API operations unless MFA authentication
///   information is
/// included in the request.
///
/// * You cannot call any STS API *except*
/// `AssumeRole` or `GetCallerIdentity`.
///
/// The credentials that `GetSessionToken` returns are based on permissions
/// associated with the IAM user whose credentials were used to call the
/// operation. The temporary credentials have the same permissions as the IAM
/// user.
///
/// **Note:**
///
/// Although it is possible to call `GetSessionToken` using the security
/// credentials of an Amazon Web Services account root user rather than an IAM
/// user, we do
/// not recommend it. If `GetSessionToken` is called using root user
/// credentials, the temporary credentials have root user permissions. For more
/// information, see [Safeguard your root user credentials and don't use them
/// for everyday
/// tasks](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#lock-away-credentials) in the
/// *IAM User Guide*
///
/// For more information about using `GetSessionToken` to create temporary
/// credentials, see [Temporary
/// Credentials for Users in Untrusted
/// Environments](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_getsessiontoken) in the
/// *IAM User Guide*.
pub const GetSessionTokenInput = struct {
    /// The duration, in seconds, that the credentials should remain valid.
    /// Acceptable durations
    /// for IAM user sessions range from 900 seconds (15 minutes) to 129,600 seconds
    /// (36 hours), with 43,200 seconds (12 hours) as the default. Sessions for
    /// Amazon Web Services account
    /// owners are restricted to a maximum of 3,600 seconds (one hour). If the
    /// duration is longer
    /// than one hour, the session for Amazon Web Services account owners defaults
    /// to one hour.
    duration_seconds: ?i32 = null,

    /// The identification number of the MFA device that is associated with the IAM
    /// user who is making the `GetSessionToken` call. Specify this value
    /// if the IAM user has a policy that requires MFA authentication. The value is
    /// either the serial number for a hardware device (such as `GAHT12345678`) or
    /// an
    /// Amazon Resource Name (ARN) for a virtual device (such as
    /// `arn:aws:iam::123456789012:mfa/user`). You can find the device for an IAM
    /// user by going to the Amazon Web Services Management Console and viewing the
    /// user's security credentials.
    ///
    /// The regex used to validate this parameter is a string of
    /// characters consisting of upper- and lower-case alphanumeric characters with
    /// no spaces.
    /// You can also include underscores or any of the following characters: =,.@:/-
    serial_number: ?[]const u8 = null,

    /// The value provided by the MFA device, if MFA is required. If any policy
    /// requires the
    /// IAM user to submit an MFA code, specify this value. If MFA authentication
    /// is required, the user must provide a code when requesting a set of temporary
    /// security
    /// credentials. A user who fails to provide the code receives an "access
    /// denied" response when
    /// requesting resources that require MFA authentication.
    ///
    /// The format for this parameter, as described by its regex pattern, is a
    /// sequence of six
    /// numeric digits.
    token_code: ?[]const u8 = null,
};

pub const GetSessionTokenOutput = struct {
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetSessionTokenOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetSessionTokenInput, options: Options) !GetSessionTokenOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: GetSessionTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("sts", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetSessionToken&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(alloc, "&DurationSeconds=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.serial_number) |v| {
        try body_buf.appendSlice(alloc, "&SerialNumber=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.token_code) |v| {
        try body_buf.appendSlice(alloc, "&TokenCode=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetSessionTokenOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetSessionTokenResult")) break;
            },
            else => {},
        }
    }

    var result: GetSessionTokenOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(&reader, alloc);
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
