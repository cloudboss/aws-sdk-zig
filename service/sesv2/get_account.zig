const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountDetails = @import("account_details.zig").AccountDetails;
const PricingAttributes = @import("pricing_attributes.zig").PricingAttributes;
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

    /// The pricing attributes that apply to your Amazon SES account, including the
    /// currently active
    /// pricing plan and any scheduled change.
    pricing_attributes: ?PricingAttributes = null,

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
        .pricing_attributes = "PricingAttributes",
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/account";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountOutput {
    const result: GetAccountOutput = try aws.json.parseJsonObject(
        GetAccountOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
