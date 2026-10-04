const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TLSInspectionConfigurationResponse = @import("tls_inspection_configuration_response.zig").TLSInspectionConfigurationResponse;

pub const DeleteTLSInspectionConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the TLS inspection configuration.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    tls_inspection_configuration_arn: ?[]const u8 = null,

    /// The descriptive name of the TLS inspection configuration. You can't change
    /// the name of a TLS inspection configuration after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    tls_inspection_configuration_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .tls_inspection_configuration_arn = "TLSInspectionConfigurationArn",
        .tls_inspection_configuration_name = "TLSInspectionConfigurationName",
    };
};

pub const DeleteTLSInspectionConfigurationOutput = struct {
    /// The high-level properties of a TLS inspection configuration. This, along
    /// with the TLSInspectionConfiguration, define the TLS inspection
    /// configuration. You can retrieve all objects for a TLS inspection
    /// configuration by calling DescribeTLSInspectionConfiguration.
    tls_inspection_configuration_response: ?TLSInspectionConfigurationResponse = null,

    pub const json_field_names = .{
        .tls_inspection_configuration_response = "TLSInspectionConfigurationResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteTLSInspectionConfigurationInput, options: CallOptions) !DeleteTLSInspectionConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-firewall", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteTLSInspectionConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-firewall", "Network Firewall", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DeleteTLSInspectionConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteTLSInspectionConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteTLSInspectionConfigurationOutput, body, allocator);
}
