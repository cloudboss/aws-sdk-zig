const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EksAnywhereSubscriptionLicenseType = @import("eks_anywhere_subscription_license_type.zig").EksAnywhereSubscriptionLicenseType;
const EksAnywhereSubscriptionTerm = @import("eks_anywhere_subscription_term.zig").EksAnywhereSubscriptionTerm;
const EksAnywhereSubscription = @import("eks_anywhere_subscription.zig").EksAnywhereSubscription;

pub const CreateEksAnywhereSubscriptionInput = struct {
    /// A boolean indicating whether the subscription auto renews at the end of the
    /// term.
    auto_renew: ?bool = null,

    /// A unique, case-sensitive identifier that you provide to ensure
    /// the idempotency of the request.
    client_request_token: ?[]const u8 = null,

    /// The number of licenses to purchase with the subscription. Valid values are
    /// between 1
    /// and 100. This value can't be changed after creating the subscription.
    license_quantity: ?i32 = null,

    /// The license type for all licenses in the subscription. Valid value is
    /// CLUSTER. With
    /// the CLUSTER license type, each license covers support for a single EKS
    /// Anywhere
    /// cluster.
    license_type: ?EksAnywhereSubscriptionLicenseType = null,

    /// The unique name for your subscription. It must be unique in your Amazon Web
    /// Services account in the
    /// Amazon Web Services Region you're creating the subscription in. The name can
    /// contain only alphanumeric
    /// characters (case-sensitive), hyphens, and underscores. It must start with an
    /// alphabetic
    /// character and can't be longer than 100 characters.
    name: []const u8,

    /// The metadata for a subscription to assist with categorization and
    /// organization. Each
    /// tag consists of a key and an optional value. Subscription tags don't
    /// propagate to any
    /// other resources associated with the subscription.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// An object representing the term duration and term unit type of your
    /// subscription. This
    /// determines the term length of your subscription. Valid values are MONTHS for
    /// term unit
    /// and 12 or 36 for term duration, indicating a 12 month or 36 month
    /// subscription. This
    /// value cannot be changed after creating the subscription.
    term: EksAnywhereSubscriptionTerm,

    pub const json_field_names = .{
        .auto_renew = "autoRenew",
        .client_request_token = "clientRequestToken",
        .license_quantity = "licenseQuantity",
        .license_type = "licenseType",
        .name = "name",
        .tags = "tags",
        .term = "term",
    };
};

pub const CreateEksAnywhereSubscriptionOutput = struct {
    /// The full description of the subscription.
    subscription: ?EksAnywhereSubscription = null,

    pub const json_field_names = .{
        .subscription = "subscription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEksAnywhereSubscriptionInput, options: CallOptions) !CreateEksAnywhereSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEksAnywhereSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/eks-anywhere-subscriptions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.auto_renew) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoRenew\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.license_quantity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"licenseQuantity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.license_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"licenseType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"term\":");
    try aws.json.writeValue(@TypeOf(input.term), input.term, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEksAnywhereSubscriptionOutput {
    var result: CreateEksAnywhereSubscriptionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateEksAnywhereSubscriptionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
