const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const ProductUserSummary = @import("product_user_summary.zig").ProductUserSummary;

pub const StartProductSubscriptionInput = struct {
    /// The domain name of the Active Directory that contains the user for whom to
    /// start the product subscription.
    domain: ?[]const u8 = null,

    /// An object that specifies details for the identity provider.
    identity_provider: IdentityProvider,

    /// The name of the user-based subscription product.
    ///
    /// Valid values: `VISUAL_STUDIO_ENTERPRISE` | `VISUAL_STUDIO_PROFESSIONAL` |
    /// `OFFICE_PROFESSIONAL_PLUS` | `OFFICE_STANDARD` | `REMOTE_DESKTOP_SERVICES`
    product: []const u8,

    /// The tags that apply to the product subscription.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The user name from the identity provider of the user.
    username: []const u8,

    pub const json_field_names = .{
        .domain = "Domain",
        .identity_provider = "IdentityProvider",
        .product = "Product",
        .tags = "Tags",
        .username = "Username",
    };
};

pub const StartProductSubscriptionOutput = struct {
    /// Metadata that describes the start product subscription operation.
    product_user_summary: ?ProductUserSummary = null,

    pub const json_field_names = .{
        .product_user_summary = "ProductUserSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartProductSubscriptionInput, options: CallOptions) !StartProductSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager-user-subscriptions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartProductSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-user-subscriptions", "License Manager User Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/user/StartProductSubscription";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.domain) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Domain\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IdentityProvider\":");
    try aws.json.writeValue(@TypeOf(input.identity_provider), input.identity_provider, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Product\":");
    try aws.json.writeValue(@TypeOf(input.product), input.product, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Username\":");
    try aws.json.writeValue(@TypeOf(input.username), input.username, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartProductSubscriptionOutput {
    const result: StartProductSubscriptionOutput = try aws.json.parseJsonObject(
        StartProductSubscriptionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
