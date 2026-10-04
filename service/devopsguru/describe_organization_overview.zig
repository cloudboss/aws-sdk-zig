const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeOrganizationOverviewInput = struct {
    /// The ID of the Amazon Web Services account.
    account_ids: ?[]const []const u8 = null,

    /// The start of the time range passed in. The start time granularity is at the
    /// day
    /// level. The floor of the start time is used. Returned information occurred
    /// after this
    /// day.
    from_time: i64,

    /// The ID of the organizational unit.
    organizational_unit_ids: ?[]const []const u8 = null,

    /// The end of the time range passed in. The start time granularity is at the
    /// day level.
    /// The floor of the start time is used. Returned information occurred before
    /// this day. If
    /// this is not specified, then the current day is used.
    to_time: ?i64 = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .from_time = "FromTime",
        .organizational_unit_ids = "OrganizationalUnitIds",
        .to_time = "ToTime",
    };
};

pub const DescribeOrganizationOverviewOutput = struct {
    /// An integer that specifies the number of open proactive insights in your
    /// Amazon Web Services
    /// account.
    proactive_insights: ?i32 = null,

    /// An integer that specifies the number of open reactive insights in your
    /// Amazon Web Services
    /// account.
    reactive_insights: ?i32 = null,

    pub const json_field_names = .{
        .proactive_insights = "ProactiveInsights",
        .reactive_insights = "ReactiveInsights",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeOrganizationOverviewInput, options: CallOptions) !DescribeOrganizationOverviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeOrganizationOverviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/organization/overview";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FromTime\":");
    try aws.json.writeValue(@TypeOf(input.from_time), input.from_time, allocator, &body_buf);
    has_prev = true;
    if (input.organizational_unit_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrganizationalUnitIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.to_time) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ToTime\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeOrganizationOverviewOutput {
    const result: DescribeOrganizationOverviewOutput = try aws.json.parseJsonObject(
        DescribeOrganizationOverviewOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
