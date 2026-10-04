const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimePeriod = @import("time_period.zig").TimePeriod;

pub const CreateSpendingLimitInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Braket ignores the request, but does not return an error.
    client_token: []const u8,

    /// The Amazon Resource Name (ARN) of the quantum device to apply the spending
    /// limit to.
    device_arn: []const u8,

    /// The maximum amount that can be spent on the specified device, in USD.
    spending_limit: []const u8,

    /// The tags to apply to the spending limit. Each tag consists of a key and an
    /// optional value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time period during which the spending limit is active, including start
    /// and end dates.
    time_period: ?TimePeriod = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .device_arn = "deviceArn",
        .spending_limit = "spendingLimit",
        .tags = "tags",
        .time_period = "timePeriod",
    };
};

pub const CreateSpendingLimitOutput = struct {
    /// The Amazon Resource Name (ARN) of the created spending limit.
    spending_limit_arn: []const u8,

    pub const json_field_names = .{
        .spending_limit_arn = "spendingLimitArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSpendingLimitInput, options: CallOptions) !CreateSpendingLimitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "braket", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSpendingLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("braket", "Braket", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/spending-limit";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"deviceArn\":");
    try aws.json.writeValue(@TypeOf(input.device_arn), input.device_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"spendingLimit\":");
    try aws.json.writeValue(@TypeOf(input.spending_limit), input.spending_limit, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.time_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timePeriod\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSpendingLimitOutput {
    var result: CreateSpendingLimitOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSpendingLimitOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
