const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainDeliverabilityTrackingOption = @import("domain_deliverability_tracking_option.zig").DomainDeliverabilityTrackingOption;

pub const PutDeliverabilityDashboardOptionInput = struct {
    /// Specifies whether to enable the Deliverability dashboard. To enable the
    /// dashboard, set this
    /// value to `true`.
    dashboard_enabled: ?bool = null,

    /// An array of objects, one for each verified domain that you use to send email
    /// and
    /// enabled the Deliverability dashboard for.
    subscribed_domains: ?[]const DomainDeliverabilityTrackingOption = null,

    pub const json_field_names = .{
        .dashboard_enabled = "DashboardEnabled",
        .subscribed_domains = "SubscribedDomains",
    };
};

pub const PutDeliverabilityDashboardOptionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutDeliverabilityDashboardOptionInput, options: CallOptions) !PutDeliverabilityDashboardOptionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutDeliverabilityDashboardOptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/deliverability-dashboard";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DashboardEnabled\":");
    try aws.json.writeValue(@TypeOf(input.dashboard_enabled), input.dashboard_enabled, allocator, &body_buf);
    has_prev = true;
    if (input.subscribed_domains) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SubscribedDomains\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutDeliverabilityDashboardOptionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutDeliverabilityDashboardOptionOutput = .{};

    return result;
}
