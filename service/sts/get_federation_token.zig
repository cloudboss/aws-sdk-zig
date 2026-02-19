const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const Tag = @import("tag.zig").Tag;
const Credentials = @import("credentials.zig").Credentials;
const FederatedUser = @import("federated_user.zig").FederatedUser;
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetFederationTokenOutput) void {
        self._arena.deinit();
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetFederationTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sts", "STS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetFederationToken&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(alloc, "&DurationSeconds=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&Name=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.name);
    if (input.policy) |v| {
        try body_buf.appendSlice(alloc, "&Policy=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.policy_arns) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PolicyArns.member.{d}.arn=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.arn) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
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
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.value);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetFederationTokenOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetFederationTokenResult")) break;
            },
            else => {},
        }
    }

    var result: GetFederationTokenOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "FederatedUser")) {
                    result.federated_user = try serde.deserializeFederatedUser(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PackedPolicySize")) {
                    result.packed_policy_size = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";

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
