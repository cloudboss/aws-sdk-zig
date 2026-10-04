const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetMinuteUsageInput = struct {
    /// The month being requested, with a value of 1-12.
    month: i32,

    /// The year being requested, in the format of YYYY.
    year: i32,

    pub const json_field_names = .{
        .month = "month",
        .year = "year",
    };
};

pub const GetMinuteUsageOutput = struct {
    /// Estimated number of minutes remaining for an account, specific to the month
    /// being requested.
    estimated_minutes_remaining: ?i32 = null,

    /// Returns whether or not an account has signed up for the reserved minutes
    /// pricing plan, specific to the month being requested.
    is_reserved_minutes_customer: ?bool = null,

    /// Total number of reserved minutes allocated, specific to the month being
    /// requested.
    total_reserved_minute_allocation: ?i32 = null,

    /// Total scheduled minutes for an account, specific to the month being
    /// requested.
    total_scheduled_minutes: ?i32 = null,

    /// Upcoming minutes scheduled for an account, specific to the month being
    /// requested.
    upcoming_minutes_scheduled: ?i32 = null,

    pub const json_field_names = .{
        .estimated_minutes_remaining = "estimatedMinutesRemaining",
        .is_reserved_minutes_customer = "isReservedMinutesCustomer",
        .total_reserved_minute_allocation = "totalReservedMinuteAllocation",
        .total_scheduled_minutes = "totalScheduledMinutes",
        .upcoming_minutes_scheduled = "upcomingMinutesScheduled",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMinuteUsageInput, options: CallOptions) !GetMinuteUsageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMinuteUsageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/minute-usage";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"month\":");
    try aws.json.writeValue(@TypeOf(input.month), input.month, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"year\":");
    try aws.json.writeValue(@TypeOf(input.year), input.year, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMinuteUsageOutput {
    const result: GetMinuteUsageOutput = try aws.json.parseJsonObject(
        GetMinuteUsageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
