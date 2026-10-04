const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisplayData = @import("display_data.zig").DisplayData;
const FederationProtocol = @import("federation_protocol.zig").FederationProtocol;
const ResourceServerConfig = @import("resource_server_config.zig").ResourceServerConfig;

pub const DescribeApplicationProviderInput = struct {
    /// Specifies the ARN of the application provider for which you want details.
    application_provider_arn: []const u8,

    pub const json_field_names = .{
        .application_provider_arn = "ApplicationProviderArn",
    };
};

pub const DescribeApplicationProviderOutput = struct {
    /// The ARN of the application provider.
    application_provider_arn: []const u8,

    /// A structure with details about the display data for the application
    /// provider.
    display_data: ?DisplayData = null,

    /// The protocol used to federate to the application provider.
    federation_protocol: ?FederationProtocol = null,

    /// A structure with details about the receiving application.
    resource_server_config: ?ResourceServerConfig = null,

    pub const json_field_names = .{
        .application_provider_arn = "ApplicationProviderArn",
        .display_data = "DisplayData",
        .federation_protocol = "FederationProtocol",
        .resource_server_config = "ResourceServerConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApplicationProviderInput, options: CallOptions) !DescribeApplicationProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sso", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApplicationProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sso", "SSO Admin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SWBExternalService.DescribeApplicationProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApplicationProviderOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeApplicationProviderOutput, body, allocator);
}
