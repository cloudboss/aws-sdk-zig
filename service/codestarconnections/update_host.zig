const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

pub const UpdateHostInput = struct {
    /// The Amazon Resource Name (ARN) of the host to be updated.
    host_arn: []const u8,

    /// The URL or endpoint of the host to be updated.
    provider_endpoint: ?[]const u8 = null,

    /// The VPC configuration of the host to be updated. A VPC must be configured
    /// and the
    /// infrastructure to be represented by the host must already be connected to
    /// the VPC.
    vpc_configuration: ?VpcConfiguration = null,

    pub const json_field_names = .{
        .host_arn = "HostArn",
        .provider_endpoint = "ProviderEndpoint",
        .vpc_configuration = "VpcConfiguration",
    };
};

pub const UpdateHostOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHostInput, options: CallOptions) !UpdateHostOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codestar-connections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHostInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-connections", "CodeStar connections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeStar_connections_20191201.UpdateHost");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHostOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
