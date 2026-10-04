const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Processor = @import("processor.zig").Processor;

pub const PutTransformerInput = struct {
    /// Specify either the name or ARN of the log group to create the transformer
    /// for.
    log_group_identifier: []const u8,

    /// This structure contains the configuration of this log transformer. A log
    /// transformer is an
    /// array of processors, where each processor applies one type of transformation
    /// to the log events
    /// that are ingested.
    transformer_config: []const Processor,

    pub const json_field_names = .{
        .log_group_identifier = "logGroupIdentifier",
        .transformer_config = "transformerConfig",
    };
};

pub const PutTransformerOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutTransformerInput, options: CallOptions) !PutTransformerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutTransformerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutTransformer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutTransformerOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
