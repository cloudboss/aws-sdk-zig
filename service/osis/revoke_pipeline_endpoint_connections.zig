const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RevokePipelineEndpointConnectionsInput = struct {
    /// A list of endpoint IDs for which to revoke access to the pipeline.
    endpoint_ids: []const []const u8,

    /// The Amazon Resource Name (ARN) of the pipeline from which to revoke endpoint
    /// connections.
    pipeline_arn: []const u8,

    pub const json_field_names = .{
        .endpoint_ids = "EndpointIds",
        .pipeline_arn = "PipelineArn",
    };
};

pub const RevokePipelineEndpointConnectionsOutput = struct {
    /// The Amazon Resource Name (ARN) of the pipeline from which endpoint
    /// connections were
    /// revoked.
    pipeline_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .pipeline_arn = "PipelineArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokePipelineEndpointConnectionsInput, options: CallOptions) !RevokePipelineEndpointConnectionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "osis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokePipelineEndpointConnectionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("osis", "OSIS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2022-01-01/osis/revokePipelineEndpointConnections";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndpointIds\":");
    try aws.json.writeValue(@TypeOf(input.endpoint_ids), input.endpoint_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PipelineArn\":");
    try aws.json.writeValue(@TypeOf(input.pipeline_arn), input.pipeline_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokePipelineEndpointConnectionsOutput {
    const result: RevokePipelineEndpointConnectionsOutput = try aws.json.parseJsonObject(
        RevokePipelineEndpointConnectionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
