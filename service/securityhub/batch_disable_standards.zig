const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StandardsSubscription = @import("standards_subscription.zig").StandardsSubscription;

pub const BatchDisableStandardsInput = struct {
    /// The ARNs of the standards subscriptions to disable.
    standards_subscription_arns: []const []const u8,

    pub const json_field_names = .{
        .standards_subscription_arns = "StandardsSubscriptionArns",
    };
};

pub const BatchDisableStandardsOutput = struct {
    /// The details of the standards subscriptions that were disabled.
    standards_subscriptions: ?[]const StandardsSubscription = null,

    pub const json_field_names = .{
        .standards_subscriptions = "StandardsSubscriptions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDisableStandardsInput, options: CallOptions) !BatchDisableStandardsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDisableStandardsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/standards/deregister";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StandardsSubscriptionArns\":");
    try aws.json.writeValue(@TypeOf(input.standards_subscription_arns), input.standards_subscription_arns, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDisableStandardsOutput {
    var result: BatchDisableStandardsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchDisableStandardsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
