const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SubscriptionProviderSource = @import("subscription_provider_source.zig").SubscriptionProviderSource;
const SubscriptionProviderStatus = @import("subscription_provider_status.zig").SubscriptionProviderStatus;

pub const GetRegisteredSubscriptionProviderInput = struct {
    /// The Amazon Resource Name (ARN) of the BYOL registration resource to get
    /// details for.
    subscription_provider_arn: []const u8,

    pub const json_field_names = .{
        .subscription_provider_arn = "SubscriptionProviderArn",
    };
};

pub const GetRegisteredSubscriptionProviderOutput = struct {
    /// The timestamp from the last time License Manager retrieved subscription
    /// details
    /// from your registered third-party Linux subscription provider.
    last_successful_data_retrieval_time: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the third-party access secret stored in
    /// Secrets Manager for the BYOL
    /// registration resource specified in the request.
    secret_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the BYOL registration resource specified
    /// in the request.
    subscription_provider_arn: ?[]const u8 = null,

    /// The subscription provider for the BYOL registration resource specified
    /// in the request.
    subscription_provider_source: ?SubscriptionProviderSource = null,

    /// The status of the Linux subscription provider access token from the last
    /// successful subscription data request.
    subscription_provider_status: ?SubscriptionProviderStatus = null,

    /// The detailed message from your subscription provider token status.
    subscription_provider_status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_successful_data_retrieval_time = "LastSuccessfulDataRetrievalTime",
        .secret_arn = "SecretArn",
        .subscription_provider_arn = "SubscriptionProviderArn",
        .subscription_provider_source = "SubscriptionProviderSource",
        .subscription_provider_status = "SubscriptionProviderStatus",
        .subscription_provider_status_message = "SubscriptionProviderStatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRegisteredSubscriptionProviderInput, options: CallOptions) !GetRegisteredSubscriptionProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "license-manager-linux-subscriptions");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRegisteredSubscriptionProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-linux-subscriptions", "License Manager Linux Subscriptions", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/subscription/GetRegisteredSubscriptionProvider";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SubscriptionProviderArn\":");
    try aws.json.writeValue(@TypeOf(input.subscription_provider_arn), input.subscription_provider_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRegisteredSubscriptionProviderOutput {
    var result: GetRegisteredSubscriptionProviderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRegisteredSubscriptionProviderOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
