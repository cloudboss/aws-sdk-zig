const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetSubscriptionInput = struct {
    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .space_name = "spaceName",
    };
};

pub const GetSubscriptionOutput = struct {
    /// The display name of the Amazon Web Services account used for billing for the
    /// space.
    aws_account_name: ?[]const u8 = null,

    /// The day and time the pending change will be applied to the space, in
    /// coordinated universal time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    pending_subscription_start_time: ?i64 = null,

    /// The type of the billing plan that the space will be changed to at the start
    /// of the next billing cycle. This applies
    /// only to changes that reduce the functionality available for the space.
    /// Billing plan changes that increase functionality
    /// are applied immediately. For more information, see
    /// [Pricing](https://codecatalyst.aws/explore/pricing).
    pending_subscription_type: ?[]const u8 = null,

    /// The type of the billing plan for the space.
    subscription_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_name = "awsAccountName",
        .pending_subscription_start_time = "pendingSubscriptionStartTime",
        .pending_subscription_type = "pendingSubscriptionType",
        .subscription_type = "subscriptionType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSubscriptionInput, options: CallOptions) !GetSubscriptionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecatalyst", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSubscriptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecatalyst", "CodeCatalyst", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/spaces/");
    try path_buf.appendSlice(allocator, input.space_name);
    try path_buf.appendSlice(allocator, "/subscription");
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSubscriptionOutput {
    var result: GetSubscriptionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSubscriptionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
