const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriptionProviderSource = @import("subscription_provider_source.zig").SubscriptionProviderSource;
const RegisteredSubscriptionProvider = @import("registered_subscription_provider.zig").RegisteredSubscriptionProvider;

pub const ListRegisteredSubscriptionProvidersInput = struct {
    /// The maximum items to return in a request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. This
    /// is the nextToken from a previously truncated response.
    next_token: ?[]const u8 = null,

    /// To filter your results, specify which subscription providers to return
    /// in the list.
    subscription_provider_sources: ?[]const SubscriptionProviderSource = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .subscription_provider_sources = "SubscriptionProviderSources",
    };
};

pub const ListRegisteredSubscriptionProvidersOutput = struct {
    /// The next token used for paginated responses. When this
    /// field isn't empty, there are additional elements that the service hasn't
    /// included in this request. Use this token with the next request to retrieve
    /// additional objects.
    next_token: ?[]const u8 = null,

    /// The list of BYOL registration resources that fit the criteria
    /// you specified in the request.
    registered_subscription_providers: ?[]const RegisteredSubscriptionProvider = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .registered_subscription_providers = "RegisteredSubscriptionProviders",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRegisteredSubscriptionProvidersInput, options: CallOptions) !ListRegisteredSubscriptionProvidersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRegisteredSubscriptionProvidersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-linux-subscriptions", "License Manager Linux Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/subscription/ListRegisteredSubscriptionProviders";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subscription_provider_sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SubscriptionProviderSources\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRegisteredSubscriptionProvidersOutput {
    var result: ListRegisteredSubscriptionProvidersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRegisteredSubscriptionProvidersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
