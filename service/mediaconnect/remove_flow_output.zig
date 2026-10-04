const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RemoveFlowOutputInput = struct {
    /// The Amazon Resource Name (ARN) of the flow that you want to remove an output
    /// from.
    flow_arn: []const u8,

    /// The ARN of the output that you want to remove.
    output_arn: []const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .output_arn = "OutputArn",
    };
};

pub const RemoveFlowOutputOutput = struct {
    /// The ARN of the flow that the output was removed from.
    flow_arn: ?[]const u8 = null,

    /// The ARN of the output that was removed.
    output_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
        .output_arn = "OutputArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RemoveFlowOutputInput, options: CallOptions) !RemoveFlowOutputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RemoveFlowOutputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    try path_buf.appendSlice(allocator, "/outputs/");
    try path_buf.appendSlice(allocator, input.output_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RemoveFlowOutputOutput {
    var result: RemoveFlowOutputOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RemoveFlowOutputOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
