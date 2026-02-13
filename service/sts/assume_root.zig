const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PolicyDescriptorType = @import("policy_descriptor_type.zig").PolicyDescriptorType;
const Credentials = @import("credentials.zig").Credentials;
const serde = @import("serde.zig");

/// Returns a set of short term credentials you can use to perform privileged
/// tasks on a
/// member account in your organization. You must use credentials from an
/// Organizations management
/// account or a delegated administrator account for IAM to call `AssumeRoot`.
/// You
/// cannot use root user credentials to make this call.
///
/// Before you can launch a privileged session, you must have centralized root
/// access in
/// your organization. For steps to enable this feature, see [Centralize root
/// access for
/// member
/// accounts](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-enable-root-access.html) in the *IAM User Guide*.
///
/// **Note:**
///
/// The STS global endpoint is not supported for AssumeRoot. You must send this
/// request
/// to a Regional STS endpoint. For more information, see
/// [Endpoints](https://docs.aws.amazon.com/STS/latest/APIReference/welcome.html#sts-endpoints).
///
/// You can track AssumeRoot in CloudTrail logs to determine what actions were
/// performed in a
/// session. For more information, see [Track privileged tasks
/// in
/// CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/cloudtrail-track-privileged-tasks.html) in the *IAM User Guide*.
///
/// When granting access to privileged tasks you should only grant the necessary
/// permissions
/// required to perform that task. For more information, see [Security best
/// practices in
/// IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html).
/// In addition, you can use [service control
/// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html) (SCPs) to manage and limit permissions in your organization. See [General examples](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_examples_general.html) in the *Organizations User
/// Guide* for more information on SCPs.
pub const AssumeRootInput = struct {
    /// The duration, in seconds, of the privileged session. The value can range
    /// from 0 seconds
    /// up to the maximum session duration of 900 seconds (15 minutes). If you
    /// specify a value
    /// higher than this setting, the operation fails.
    ///
    /// By default, the value is set to `900` seconds.
    duration_seconds: ?i32 = null,

    /// The member account principal ARN or account ID.
    target_principal: []const u8,

    /// The identity based policy that scopes the session to the privileged tasks
    /// that can be
    /// performed. You must
    ///
    /// use one of following Amazon Web Services managed policies to scope root
    /// session
    /// actions:
    ///
    /// *
    ///   [IAMAuditRootUserCredentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/security-iam-awsmanpol.html#security-iam-awsmanpol-IAMAuditRootUserCredentials)
    ///
    /// *
    ///   [IAMCreateRootUserPassword](https://docs.aws.amazon.com/IAM/latest/UserGuide/security-iam-awsmanpol.html#security-iam-awsmanpol-IAMCreateRootUserPassword)
    ///
    /// *
    ///   [IAMDeleteRootUserCredentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/security-iam-awsmanpol.html#security-iam-awsmanpol-IAMDeleteRootUserCredentials)
    ///
    /// *
    ///   [S3UnlockBucketPolicy](https://docs.aws.amazon.com/IAM/latest/UserGuide/security-iam-awsmanpol.html#security-iam-awsmanpol-S3UnlockBucketPolicy)
    ///
    /// *
    ///   [SQSUnlockQueuePolicy](https://docs.aws.amazon.com/IAM/latest/UserGuide/security-iam-awsmanpol.html#security-iam-awsmanpol-SQSUnlockQueuePolicy)
    task_policy_arn: PolicyDescriptorType,
};

pub const AssumeRootOutput = struct {
    /// The temporary security credentials, which include an access key ID, a secret
    /// access key,
    /// and a security token.
    ///
    /// **Note:**
    ///
    /// The size of the security token that STS API operations return is not fixed.
    /// We
    /// strongly recommend that you make no assumptions about the maximum size.
    credentials: ?Credentials = null,

    /// The source identity specified by the principal that is calling the
    /// `AssumeRoot` operation.
    ///
    /// You can use the `aws:SourceIdentity` condition key to control access based
    /// on
    /// the value of source identity. For more information about using source
    /// identity, see [Monitor and control
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *AssumeRootOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AssumeRootInput, options: Options) !AssumeRootOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AssumeRootInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("sts", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssumeRoot&Version=2011-06-15");
    if (input.duration_seconds) |v| {
        try body_buf.appendSlice(alloc, "&DurationSeconds=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    try body_buf.appendSlice(alloc, "&TargetPrincipal=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.target_principal);
    if (input.task_policy_arn.arn) |sv| {
        try body_buf.appendSlice(alloc, "&TaskPolicyArn.arn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AssumeRootOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AssumeRootResult")) break;
            },
            else => {},
        }
    }

    var result: AssumeRootOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Credentials")) {
                    result.credentials = try serde.deserializeCredentials(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SourceIdentity")) {
                    result.source_identity = try alloc.dupe(u8, try reader.readElementText());
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
