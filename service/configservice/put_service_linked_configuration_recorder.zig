const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const PutServiceLinkedConfigurationRecorderInput = struct {
    /// The service principal of the Amazon Web Services service for the
    /// service-linked configuration recorder that you want to create.
    service_principal: []const u8,

    /// The tags for a service-linked configuration recorder. Each tag consists of a
    /// key and an optional value, both of which you define.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .service_principal = "ServicePrincipal",
        .tags = "Tags",
    };
};

pub const PutServiceLinkedConfigurationRecorderOutput = struct {
    /// The Amazon Resource Name (ARN) of the specified configuration recorder.
    arn: ?[]const u8 = null,

    /// The name of the specified configuration recorder.
    ///
    /// For service-linked configuration recorders, Config automatically assigns a
    /// name that has the prefix "`AWSConfigurationRecorderFor`" to the new
    /// service-linked configuration recorder.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutServiceLinkedConfigurationRecorderInput, options: CallOptions) !PutServiceLinkedConfigurationRecorderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutServiceLinkedConfigurationRecorderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.PutServiceLinkedConfigurationRecorder");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutServiceLinkedConfigurationRecorderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutServiceLinkedConfigurationRecorderOutput, body, allocator);
}
