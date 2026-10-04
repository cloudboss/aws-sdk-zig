const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceIntegrationConfig = @import("service_integration_config.zig").ServiceIntegrationConfig;

pub const DescribeServiceIntegrationInput = struct {
};

pub const DescribeServiceIntegrationOutput = struct {
    service_integration: ?ServiceIntegrationConfig = null,

    pub const json_field_names = .{
        .service_integration = "ServiceIntegration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServiceIntegrationInput, options: CallOptions) !DescribeServiceIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devops-guru", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServiceIntegrationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("devops-guru", "DevOps Guru", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/service-integrations";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServiceIntegrationOutput {
    var result: DescribeServiceIntegrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeServiceIntegrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
