const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HumanLoopOutput = @import("human_loop_output.zig").HumanLoopOutput;
const HumanLoopStatus = @import("human_loop_status.zig").HumanLoopStatus;

pub const DescribeHumanLoopInput = struct {
    /// The name of the human loop that you want information about.
    human_loop_name: []const u8,

    pub const json_field_names = .{
        .human_loop_name = "HumanLoopName",
    };
};

pub const DescribeHumanLoopOutput = struct {
    /// The creation time when Amazon Augmented AI created the human loop.
    creation_time: i64,

    /// A failure code that identifies the type of failure.
    ///
    /// Possible values: `ValidationError`, `Expired`,
    /// `InternalError`
    failure_code: ?[]const u8 = null,

    /// The reason why a human loop failed. The failure reason is returned when the
    /// status of the
    /// human loop is `Failed`.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the flow definition.
    flow_definition_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the human loop.
    human_loop_arn: []const u8,

    /// The name of the human loop. The name must be lowercase, unique within the
    /// Region in your
    /// account, and can have up to 63 characters. Valid characters: a-z, 0-9, and -
    /// (hyphen).
    human_loop_name: []const u8,

    /// An object that contains information about the output of the human loop.
    human_loop_output: ?HumanLoopOutput = null,

    /// The status of the human loop.
    human_loop_status: HumanLoopStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .failure_code = "FailureCode",
        .failure_reason = "FailureReason",
        .flow_definition_arn = "FlowDefinitionArn",
        .human_loop_arn = "HumanLoopArn",
        .human_loop_name = "HumanLoopName",
        .human_loop_output = "HumanLoopOutput",
        .human_loop_status = "HumanLoopStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHumanLoopInput, options: CallOptions) !DescribeHumanLoopOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHumanLoopInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("a2i-runtime.sagemaker", "SageMaker A2I Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/human-loops/");
    try path_buf.appendSlice(allocator, input.human_loop_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHumanLoopOutput {
    const result: DescribeHumanLoopOutput = try aws.json.parseJsonObject(
        DescribeHumanLoopOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
