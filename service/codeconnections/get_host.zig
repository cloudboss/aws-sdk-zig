const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderType = @import("provider_type.zig").ProviderType;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

pub const GetHostInput = struct {
    /// The Amazon Resource Name (ARN) of the requested host.
    host_arn: []const u8,

    pub const json_field_names = .{
        .host_arn = "HostArn",
    };
};

pub const GetHostOutput = struct {
    /// The name of the requested host.
    name: ?[]const u8 = null,

    /// The endpoint of the infrastructure represented by the requested host.
    provider_endpoint: ?[]const u8 = null,

    /// The provider type of the requested host, such as GitHub Enterprise Server.
    provider_type: ?ProviderType = null,

    /// The status of the requested host.
    status: ?[]const u8 = null,

    /// The VPC configuration of the requested host.
    vpc_configuration: ?VpcConfiguration = null,

    pub const json_field_names = .{
        .name = "Name",
        .provider_endpoint = "ProviderEndpoint",
        .provider_type = "ProviderType",
        .status = "Status",
        .vpc_configuration = "VpcConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetHostInput, options: CallOptions) !GetHostOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeconnections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetHostInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeconnections", "CodeConnections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.GetHost");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetHostOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetHostOutput, body, allocator);
}
