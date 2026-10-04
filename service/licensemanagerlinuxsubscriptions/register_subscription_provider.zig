const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionProviderSource = @import("subscription_provider_source.zig").SubscriptionProviderSource;
const SubscriptionProviderStatus = @import("subscription_provider_status.zig").SubscriptionProviderStatus;

pub const RegisterSubscriptionProviderInput = struct {
    /// The Amazon Resource Name (ARN) of the secret where you've stored your
    /// subscription provider's access token. For
    /// RHEL subscriptions managed through the Red Hat Subscription Manager (RHSM),
    /// the secret contains
    /// your Red Hat Offline token.
    secret_arn: []const u8,

    /// The supported Linux subscription provider to register.
    subscription_provider_source: SubscriptionProviderSource,

    /// The metadata tags to assign to your registered Linux subscription provider
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .secret_arn = "SecretArn",
        .subscription_provider_source = "SubscriptionProviderSource",
        .tags = "Tags",
    };
};

pub const RegisterSubscriptionProviderOutput = struct {
    /// The Amazon Resource Name (ARN) of the Linux subscription provider resource
    /// that you registered.
    subscription_provider_arn: ?[]const u8 = null,

    /// The Linux subscription provider that you registered.
    subscription_provider_source: ?SubscriptionProviderSource = null,

    /// Indicates the status of the registration action for the Linux subscription
    /// provider
    /// that you requested.
    subscription_provider_status: ?SubscriptionProviderStatus = null,

    pub const json_field_names = .{
        .subscription_provider_arn = "SubscriptionProviderArn",
        .subscription_provider_source = "SubscriptionProviderSource",
        .subscription_provider_status = "SubscriptionProviderStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterSubscriptionProviderInput, options: CallOptions) !RegisterSubscriptionProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager-linux-subscriptions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterSubscriptionProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-linux-subscriptions", "License Manager Linux Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/subscription/RegisterSubscriptionProvider";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SecretArn\":");
    try aws.json.writeValue(@TypeOf(input.secret_arn), input.secret_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SubscriptionProviderSource\":");
    try aws.json.writeValue(@TypeOf(input.subscription_provider_source), input.subscription_provider_source, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterSubscriptionProviderOutput {
    const result: RegisterSubscriptionProviderOutput = try aws.json.parseJsonObject(
        RegisterSubscriptionProviderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
