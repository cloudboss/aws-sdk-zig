const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HumanLoopDataAttributes = @import("human_loop_data_attributes.zig").HumanLoopDataAttributes;
const HumanLoopInput = @import("human_loop_input.zig").HumanLoopInput;

pub const StartHumanLoopInput = struct {
    /// Attributes of the specified data. Use `DataAttributes` to specify if your
    /// data
    /// is free of personally identifiable information and/or free of adult content.
    data_attributes: ?HumanLoopDataAttributes = null,

    /// The Amazon Resource Name (ARN) of the flow definition associated with this
    /// human
    /// loop.
    flow_definition_arn: []const u8,

    /// An object that contains information about the human loop.
    human_loop_input: HumanLoopInput,

    /// The name of the human loop.
    human_loop_name: []const u8,

    pub const json_field_names = .{
        .data_attributes = "DataAttributes",
        .flow_definition_arn = "FlowDefinitionArn",
        .human_loop_input = "HumanLoopInput",
        .human_loop_name = "HumanLoopName",
    };
};

pub const StartHumanLoopOutput = struct {
    /// The Amazon Resource Name (ARN) of the human loop.
    human_loop_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .human_loop_arn = "HumanLoopArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartHumanLoopInput, options: CallOptions) !StartHumanLoopOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartHumanLoopInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("a2i-runtime.sagemaker", "SageMaker A2I Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/human-loops";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FlowDefinitionArn\":");
    try aws.json.writeValue(@TypeOf(input.flow_definition_arn), input.flow_definition_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"HumanLoopInput\":");
    try aws.json.writeValue(@TypeOf(input.human_loop_input), input.human_loop_input, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"HumanLoopName\":");
    try aws.json.writeValue(@TypeOf(input.human_loop_name), input.human_loop_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartHumanLoopOutput {
    const result: StartHumanLoopOutput = try aws.json.parseJsonObject(
        StartHumanLoopOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
