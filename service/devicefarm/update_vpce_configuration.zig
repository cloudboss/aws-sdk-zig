const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VPCEConfiguration = @import("vpce_configuration.zig").VPCEConfiguration;

pub const UpdateVPCEConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the VPC endpoint configuration you want to
    /// update.
    arn: []const u8,

    /// The DNS (domain) name used to connect to your private service in your VPC.
    /// The DNS name must not already
    /// be in use on the internet.
    service_dns_name: ?[]const u8 = null,

    /// An optional description that provides details about your VPC endpoint
    /// configuration.
    vpce_configuration_description: ?[]const u8 = null,

    /// The friendly name you give to your VPC endpoint configuration to manage your
    /// configurations more
    /// easily.
    vpce_configuration_name: ?[]const u8 = null,

    /// The name of the VPC endpoint service running in your AWS account that you
    /// want Device Farm to test.
    vpce_service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .service_dns_name = "serviceDnsName",
        .vpce_configuration_description = "vpceConfigurationDescription",
        .vpce_configuration_name = "vpceConfigurationName",
        .vpce_service_name = "vpceServiceName",
    };
};

pub const UpdateVPCEConfigurationOutput = struct {
    /// An object that contains information about your VPC endpoint configuration.
    vpce_configuration: ?VPCEConfiguration = null,

    pub const json_field_names = .{
        .vpce_configuration = "vpceConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVPCEConfigurationInput, options: CallOptions) !UpdateVPCEConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVPCEConfigurationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.UpdateVPCEConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVPCEConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateVPCEConfigurationOutput, body, allocator);
}
