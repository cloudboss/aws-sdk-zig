const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliverabilityDashboardAccountStatus = @import("deliverability_dashboard_account_status.zig").DeliverabilityDashboardAccountStatus;
const DomainDeliverabilityTrackingOption = @import("domain_deliverability_tracking_option.zig").DomainDeliverabilityTrackingOption;

pub const GetDeliverabilityDashboardOptionsInput = struct {
};

pub const GetDeliverabilityDashboardOptionsOutput = struct {
    /// The current status of your Deliverability dashboard subscription. If this
    /// value is
    /// `PENDING_EXPIRATION`, your subscription is scheduled to expire at the end
    /// of the current calendar month.
    account_status: ?DeliverabilityDashboardAccountStatus = null,

    /// An array of objects, one for each verified domain that you use to send email
    /// and
    /// currently has an active Deliverability dashboard subscription that isn’t
    /// scheduled to expire at
    /// the end of the current calendar month.
    active_subscribed_domains: ?[]const DomainDeliverabilityTrackingOption = null,

    /// Specifies whether the Deliverability dashboard is enabled. If this value is
    /// `true`,
    /// the dashboard is enabled.
    dashboard_enabled: ?bool = null,

    /// An array of objects, one for each verified domain that you use to send email
    /// and
    /// currently has an active Deliverability dashboard subscription that's
    /// scheduled to expire at the
    /// end of the current calendar month.
    pending_expiration_subscribed_domains: ?[]const DomainDeliverabilityTrackingOption = null,

    /// The date when your current subscription to the Deliverability dashboard
    /// is scheduled to expire, if your subscription is scheduled to expire at the
    /// end of the
    /// current calendar month. This value is null if you have an active
    /// subscription that isn’t
    /// due to expire at the end of the month.
    subscription_expiry_date: ?i64 = null,

    pub const json_field_names = .{
        .account_status = "AccountStatus",
        .active_subscribed_domains = "ActiveSubscribedDomains",
        .dashboard_enabled = "DashboardEnabled",
        .pending_expiration_subscribed_domains = "PendingExpirationSubscribedDomains",
        .subscription_expiry_date = "SubscriptionExpiryDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeliverabilityDashboardOptionsInput, options: CallOptions) !GetDeliverabilityDashboardOptionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeliverabilityDashboardOptionsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/deliverability-dashboard";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeliverabilityDashboardOptionsOutput {
    const result: GetDeliverabilityDashboardOptionsOutput = try aws.json.parseJsonObject(
        GetDeliverabilityDashboardOptionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
