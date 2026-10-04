const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StageSession = @import("stage_session.zig").StageSession;

pub const GetStageSessionInput = struct {
    /// ID of a session within the stage.
    session_id: []const u8,

    /// ARN of the stage for which the information is to be retrieved.
    stage_arn: []const u8,

    pub const json_field_names = .{
        .session_id = "sessionId",
        .stage_arn = "stageArn",
    };
};

pub const GetStageSessionOutput = struct {
    /// The stage session that is returned.
    stage_session: ?StageSession = null,

    pub const json_field_names = .{
        .stage_session = "stageSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStageSessionInput, options: CallOptions) !GetStageSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStageSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetStageSession";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sessionId\":");
    try aws.json.writeValue(@TypeOf(input.session_id), input.session_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"stageArn\":");
    try aws.json.writeValue(@TypeOf(input.stage_arn), input.stage_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStageSessionOutput {
    var result: GetStageSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetStageSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
