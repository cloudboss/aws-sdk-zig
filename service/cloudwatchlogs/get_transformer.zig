const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Processor = @import("processor.zig").Processor;

pub const GetTransformerInput = struct {
    /// Specify either the name or ARN of the log group to return transformer
    /// information for. If
    /// the log group is in a source account and you are using a monitoring account,
    /// you must use the
    /// log group ARN.
    log_group_identifier: []const u8,

    pub const json_field_names = .{
        .log_group_identifier = "logGroupIdentifier",
    };
};

pub const GetTransformerOutput = struct {
    /// The creation time of the transformer, expressed as the number of
    /// milliseconds after Jan
    /// 1, 1970 00:00:00 UTC.
    creation_time: ?i64 = null,

    /// The date and time when this transformer was most recently modified,
    /// expressed as the
    /// number of milliseconds after Jan 1, 1970 00:00:00 UTC.
    last_modified_time: ?i64 = null,

    /// The ARN of the log group that you specified in your request.
    log_group_identifier: ?[]const u8 = null,

    /// This sructure contains the configuration of the requested transformer.
    transformer_config: ?[]const Processor = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .last_modified_time = "lastModifiedTime",
        .log_group_identifier = "logGroupIdentifier",
        .transformer_config = "transformerConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTransformerInput, options: CallOptions) !GetTransformerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTransformerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetTransformer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTransformerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTransformerOutput, body, allocator);
}
