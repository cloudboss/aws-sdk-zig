const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipeState = @import("pipe_state.zig").PipeState;
const RequestedPipeStateDescribeResponse = @import("requested_pipe_state_describe_response.zig").RequestedPipeStateDescribeResponse;

pub const DeletePipeInput = struct {
    /// The name of the pipe.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DeletePipeOutput = struct {
    /// The ARN of the pipe.
    arn: ?[]const u8 = null,

    /// The time the pipe was created.
    creation_time: ?i64 = null,

    /// The state the pipe is in.
    current_state: ?PipeState = null,

    /// The state the pipe should be in.
    desired_state: ?RequestedPipeStateDescribeResponse = null,

    /// When the pipe was last updated, in [ISO-8601
    /// format](https://www.w3.org/TR/NOTE-datetime) (YYYY-MM-DDThh:mm:ss.sTZD).
    last_modified_time: ?i64 = null,

    /// The name of the pipe.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .current_state = "CurrentState",
        .desired_state = "DesiredState",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeletePipeInput, options: CallOptions) !DeletePipeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pipes", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeletePipeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pipes", "Pipes", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/pipes/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeletePipeOutput {
    var result: DeletePipeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeletePipeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
