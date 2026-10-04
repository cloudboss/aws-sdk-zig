const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PredictQAppInputOptions = @import("predict_q_app_input_options.zig").PredictQAppInputOptions;
const PredictAppDefinition = @import("predict_app_definition.zig").PredictAppDefinition;

pub const PredictQAppInput = struct {
    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The input to generate the Q App definition from, either a conversation or
    /// problem statement.
    options: ?PredictQAppInputOptions = null,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .options = "options",
    };
};

pub const PredictQAppOutput = struct {
    /// The generated Q App definition.
    app: ?PredictAppDefinition = null,

    /// The problem statement extracted from the input conversation, if provided.
    problem_statement: []const u8,

    pub const json_field_names = .{
        .app = "app",
        .problem_statement = "problemStatement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PredictQAppInput, options: CallOptions) !PredictQAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PredictQAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apps.predictQApp";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"options\":");
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
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PredictQAppOutput {
    var result: PredictQAppOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PredictQAppOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
