const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DkimAttributes = @import("dkim_attributes.zig").DkimAttributes;
const IdentityType = @import("identity_type.zig").IdentityType;
const MailFromAttributes = @import("mail_from_attributes.zig").MailFromAttributes;
const Tag = @import("tag.zig").Tag;
const VerificationInfo = @import("verification_info.zig").VerificationInfo;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;

pub const GetEmailIdentityInput = struct {
    /// The email identity.
    email_identity: []const u8,

    pub const json_field_names = .{
        .email_identity = "EmailIdentity",
    };
};

pub const GetEmailIdentityOutput = struct {
    /// The configuration set used by default when sending from this identity.
    configuration_set_name: ?[]const u8 = null,

    /// An object that contains information about the DKIM attributes for the
    /// identity.
    dkim_attributes: ?DkimAttributes = null,

    /// The feedback forwarding configuration for the identity.
    ///
    /// If the value is `true`, you receive email notifications when bounce or
    /// complaint events occur. These notifications are sent to the address that you
    /// specified
    /// in the `Return-Path` header of the original email.
    ///
    /// You're required to have a method of tracking bounces and complaints. If you
    /// haven't
    /// set up another mechanism for receiving bounce or complaint notifications
    /// (for example,
    /// by setting up an event destination), you receive an email notification when
    /// these events
    /// occur (even if this setting is disabled).
    feedback_forwarding_status: ?bool = null,

    /// The email identity type. Note: the `MANAGED_DOMAIN` identity type is not
    /// supported.
    identity_type: ?IdentityType = null,

    /// An object that contains information about the Mail-From attributes for the
    /// email
    /// identity.
    mail_from_attributes: ?MailFromAttributes = null,

    /// A map of policy names to policies.
    policies: ?[]const aws.map.StringMapEntry = null,

    /// An array of objects that define the tags (keys and values) that are
    /// associated with
    /// the email identity.
    tags: ?[]const Tag = null,

    /// An object that contains additional information about the verification status
    /// for the
    /// identity.
    verification_info: ?VerificationInfo = null,

    /// The verification status of the identity. The status can be one of the
    /// following:
    ///
    /// * `PENDING` – The verification process was initiated, but Amazon SES
    /// hasn't yet been able to verify the identity.
    ///
    /// * `SUCCESS` – The verification process completed
    /// successfully.
    ///
    /// * `FAILED` – The verification process failed.
    ///
    /// * `TEMPORARY_FAILURE` – A temporary issue is preventing Amazon SES
    /// from determining the verification status of the identity.
    ///
    /// * `NOT_STARTED` – The verification process hasn't been
    /// initiated for the identity.
    verification_status: ?VerificationStatus = null,

    /// Specifies whether or not the identity is verified. You can only send email
    /// from
    /// verified email addresses or domains. For more information about verifying
    /// identities,
    /// see the [Amazon Pinpoint User
    /// Guide](https://docs.aws.amazon.com/pinpoint/latest/userguide/channels-email-manage-verify.html).
    verified_for_sending_status: ?bool = null,

    pub const json_field_names = .{
        .configuration_set_name = "ConfigurationSetName",
        .dkim_attributes = "DkimAttributes",
        .feedback_forwarding_status = "FeedbackForwardingStatus",
        .identity_type = "IdentityType",
        .mail_from_attributes = "MailFromAttributes",
        .policies = "Policies",
        .tags = "Tags",
        .verification_info = "VerificationInfo",
        .verification_status = "VerificationStatus",
        .verified_for_sending_status = "VerifiedForSendingStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEmailIdentityInput, options: Options) !GetEmailIdentityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sesv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetEmailIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sesv2", "SESv2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/v2/email/identities/");
    try path_buf.appendSlice(alloc, input.email_identity);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetEmailIdentityOutput {
    var result: GetEmailIdentityOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEmailIdentityOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccountSuspendedException")) {
        return .{ .arena = arena, .kind = .{ .account_suspended_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MailFromDomainNotVerifiedException")) {
        return .{ .arena = arena, .kind = .{ .mail_from_domain_not_verified_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MessageRejected")) {
        return .{ .arena = arena, .kind = .{ .message_rejected = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SendingPausedException")) {
        return .{ .arena = arena, .kind = .{ .sending_paused_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
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
