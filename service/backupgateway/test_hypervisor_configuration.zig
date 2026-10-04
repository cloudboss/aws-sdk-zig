const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const TestHypervisorConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the gateway to the hypervisor to test.
    gateway_arn: []const u8,

    /// The server host of the hypervisor. This can be either an IP address or a
    /// fully-qualified domain name (FQDN).
    host: []const u8,

    /// The password for the hypervisor.
    password: ?[]const u8 = null,

    /// The username for the hypervisor.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .gateway_arn = "GatewayArn",
        .host = "Host",
        .password = "Password",
        .username = "Username",
    };
};

pub const TestHypervisorConfigurationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestHypervisorConfigurationInput, options: CallOptions) !TestHypervisorConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup-gateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TestHypervisorConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup-gateway", "Backup Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "BackupOnPremises_v20210101.TestHypervisorConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestHypervisorConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
