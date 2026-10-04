const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartInvestigationInput = struct {
    /// The unique Amazon Resource Name (ARN) of the IAM user and IAM role.
    entity_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the behavior graph.
    graph_arn: []const u8,

    /// The data and time when the investigation ended. The value is an UTC ISO8601
    /// formatted
    /// string. For example, `2021-08-18T16:35:56.284Z`.
    scope_end_time: i64,

    /// The data and time when the investigation began. The value is an UTC ISO8601
    /// formatted string. For example, `2021-08-18T16:35:56.284Z`.
    scope_start_time: i64,

    pub const json_field_names = .{
        .entity_arn = "EntityArn",
        .graph_arn = "GraphArn",
        .scope_end_time = "ScopeEndTime",
        .scope_start_time = "ScopeStartTime",
    };
};

pub const StartInvestigationOutput = struct {
    /// The investigation ID of the investigation report.
    investigation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .investigation_id = "InvestigationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartInvestigationInput, options: CallOptions) !StartInvestigationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "detective", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartInvestigationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.detective", "Detective", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/investigations/startInvestigation";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EntityArn\":");
    try aws.json.writeValue(@TypeOf(input.entity_arn), input.entity_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GraphArn\":");
    try aws.json.writeValue(@TypeOf(input.graph_arn), input.graph_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ScopeEndTime\":");
    try aws.json.writeValue(@TypeOf(input.scope_end_time), input.scope_end_time, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ScopeStartTime\":");
    try aws.json.writeValue(@TypeOf(input.scope_start_time), input.scope_start_time, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartInvestigationOutput {
    var result: StartInvestigationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartInvestigationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
