const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPCEConfiguration = @import("vpce_configuration.zig").VPCEConfiguration;

pub const CreateVPCEConfigurationInput = struct {
    /// The DNS name of the service running in your VPC that you want Device Farm to
    /// test.
    service_dns_name: []const u8,

    /// An optional description that provides details about your VPC endpoint
    /// configuration.
    vpce_configuration_description: ?[]const u8 = null,

    /// The friendly name you give to your VPC endpoint configuration, to manage
    /// your
    /// configurations more easily.
    vpce_configuration_name: []const u8,

    /// The name of the VPC endpoint service running in your AWS account that you
    /// want Device Farm to test.
    vpce_service_name: []const u8,

    pub const json_field_names = .{
        .service_dns_name = "serviceDnsName",
        .vpce_configuration_description = "vpceConfigurationDescription",
        .vpce_configuration_name = "vpceConfigurationName",
        .vpce_service_name = "vpceServiceName",
    };
};

pub const CreateVPCEConfigurationOutput = struct {
    /// An object that contains information about your VPC endpoint configuration.
    vpce_configuration: ?VPCEConfiguration = null,

    pub const json_field_names = .{
        .vpce_configuration = "vpceConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVPCEConfigurationInput, options: CallOptions) !CreateVPCEConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVPCEConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.CreateVPCEConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVPCEConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateVPCEConfigurationOutput, body, allocator);
}
