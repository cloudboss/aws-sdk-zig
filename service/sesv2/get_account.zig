const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AccountDetails = @import("account_details.zig").AccountDetails;
const SendQuota = @import("send_quota.zig").SendQuota;
const SuppressionAttributes = @import("suppression_attributes.zig").SuppressionAttributes;
const VdmAttributes = @import("vdm_attributes.zig").VdmAttributes;

pub const GetAccountInput = struct {
};

pub const GetAccountOutput = struct {
    /// Indicates whether or not the automatic warm-up feature is enabled for
    /// dedicated IP
    /// addresses that are associated with your account.
    dedicated_ip_auto_warmup_enabled: ?bool = null,

    /// An object that defines your account details.
    details: ?AccountDetails = null,

    /// The reputation status of your Amazon SES account. The status can be one of
    /// the
    /// following:
    ///
    /// * `HEALTHY` – There are no reputation-related issues that
    /// currently impact your account.
    ///
    /// * `PROBATION` – We've identified potential issues with your
    /// Amazon SES account. We're placing your account under review while you work
    /// on
    /// correcting these issues.
    ///
    /// * `SHUTDOWN` – Your account's ability to send email is
    /// currently paused because of an issue with the email sent from your account.
    /// When
    /// you correct the issue, you can contact us and request that your account's
    /// ability to send email is resumed.
    enforcement_status: ?[]const u8 = null,

    /// Indicates whether or not your account has production access in the current
    /// Amazon Web Services
    /// Region.
    ///
    /// If the value is `false`, then your account is in the
    /// *sandbox*. When your account is in the sandbox, you can only send
    /// email to verified identities.
    ///
    /// If the value is `true`, then your account has production access. When your
    /// account has production access, you can send email to any address. The
    /// sending quota and
    /// maximum sending rate for your account vary based on your specific use case.
    production_access_enabled: ?bool = null,

    /// Indicates whether or not email sending is enabled for your Amazon SES
    /// account in the
    /// current Amazon Web Services Region.
    sending_enabled: ?bool = null,

    /// An object that contains information about the per-day and per-second sending
    /// limits
    /// for your Amazon SES account in the current Amazon Web Services Region.
    send_quota: ?SendQuota = null,

    /// An object that contains information about the email address suppression
    /// preferences
    /// for your account in the current Amazon Web Services Region.
    suppression_attributes: ?SuppressionAttributes = null,

    /// The VDM attributes that apply to your Amazon SES account.
    vdm_attributes: ?VdmAttributes = null,

    pub const json_field_names = .{
        .dedicated_ip_auto_warmup_enabled = "DedicatedIpAutoWarmupEnabled",
        .details = "Details",
        .enforcement_status = "EnforcementStatus",
        .production_access_enabled = "ProductionAccessEnabled",
        .sending_enabled = "SendingEnabled",
        .send_quota = "SendQuota",
        .suppression_attributes = "SuppressionAttributes",
        .vdm_attributes = "VdmAttributes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountInput, options: CallOptions) !GetAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ses");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v2/email/account";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountOutput {
    var result: GetAccountOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAccountOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
