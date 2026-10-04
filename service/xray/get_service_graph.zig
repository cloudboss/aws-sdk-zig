const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Service = @import("service.zig").Service;

pub const GetServiceGraphInput = struct {
    /// The end of the timeframe for which to generate a graph.
    end_time: i64,

    /// The Amazon Resource Name (ARN) of a group based on which you want to
    /// generate a graph.
    group_arn: ?[]const u8 = null,

    /// The name of a group based on which you want to generate a graph.
    group_name: ?[]const u8 = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// The start of the time frame for which to generate a graph.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .group_arn = "GroupARN",
        .group_name = "GroupName",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const GetServiceGraphOutput = struct {
    /// A flag indicating whether the group's filter expression has been consistent,
    /// or
    /// if the returned service graph may show traces from an older version of the
    /// group's filter
    /// expression.
    contains_old_group_versions: ?bool = null,

    /// The end of the time frame for which the graph was generated.
    end_time: ?i64 = null,

    /// Pagination token.
    next_token: ?[]const u8 = null,

    /// The services that have processed a traced request during the specified time
    /// frame.
    services: ?[]const Service = null,

    /// The start of the time frame for which the graph was generated.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .contains_old_group_versions = "ContainsOldGroupVersions",
        .end_time = "EndTime",
        .next_token = "NextToken",
        .services = "Services",
        .start_time = "StartTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceGraphInput, options: CallOptions) !GetServiceGraphOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceGraphInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ServiceGraph";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.group_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GroupName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceGraphOutput {
    const result: GetServiceGraphOutput = try aws.json.parseJsonObject(
        GetServiceGraphOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
